import { parse } from "@babel/parser"
import {
    ArrowFunctionExpression,
    CallExpression,
    ClassDeclaration,
    ConditionalExpression,
    Expression,
    FunctionDeclaration,
    LogicalExpression,
    Node,
    SpreadElement,
    VariableDeclaration,
    arrowFunctionExpression,
    callExpression,
    identifier,
    isConditionalExpression,
    isExpression,
    isLogicalExpression,
    memberExpression,
    objectExpression,
    objectProperty,
    stringLiteral
} from "@babel/types"

import generate from "@babel/generator"
import { TraceMap, originalPositionFor } from "@jridgewell/trace-mapping"
import { recursive } from "babel-walk"
import fs from "fs"
import { PluginOption } from "vite"

const astMap = new Map<string, any>()
const exportedCompMap = new Map<string, string[]>()
const filenameMap = new Map<string, number>()
let filenameCounter = 1

export function transformJsxPlugin(): PluginOption {
    let isDev = false

    return {
        name: 'pang-jsx-transform',

        configureServer(server) {
            server.middlewares.use(async (req, res, next) => {
                const url = new URL(req.url || '', `http://${req.headers.host}`);

                if (url.pathname === '/__get-source-snippet') {
                    const filePath = url.searchParams.get('file');
                    const lineParam = url.searchParams.get('line');

                    if (!filePath || !lineParam) {
                        res.statusCode = 400;
                        return res.end('Missing query params');
                    }

                    try {
                        const fileContent = fs.readFileSync(filePath, 'utf-8');
                        const lines = fileContent.split('\n');
                        const targetLine = parseInt(lineParam, 10);

                        // Ambil radius 3 baris ke atas dan ke bawah biar dapet context snippet
                        const startLine = Math.max(1, targetLine - 2);
                        const endLine = Math.min(lines.length, targetLine + 3);

                        const snippet = lines.slice(startLine - 1, endLine).map((code, index) => {
                            const currentLineNumber = startLine + index;
                            return {
                                line: currentLineNumber,
                                code: code,
                                isTarget: currentLineNumber === targetLine
                            };
                        });

                        res.setHeader('Content-Type', 'application/json');
                        return res.end(JSON.stringify({ snippet }));
                    } catch (err) {
                        res.statusCode = 500;
                        return res.end('Failed to read file');
                    }
                }

                next();
            });
        },

        configResolved(config) {
            isDev = config.command === 'serve'
        },

        transform(code, id, options) {
            if (/.[tj]sx$/.test(id)) {                
                const res = transformJsx(code, id, this.getCombinedSourcemap(), false, isDev)

                return {
                    code: res.code,
                    map: res.map,
                }
            }
        },

        handleHotUpdate(ctx) {
            if (!/.[tj]sx$/.test(ctx.file)) {
                for (const m of ctx.modules) {
                    for (const im of m._clientModule?.importers ?? []) {
                        if (im.id && /.[tj]sx$/.test(im.id)) {
                            ctx.server.ws.send(`pang:refresh:${im.id}`)
                        }
                    }
                }
            }
        },
    }
}

type CollectedInfo = {
    syms: CollectedSym[]
    exported: ExportSym[]
}

type CollectedSym = {
    name: string
    inModuleName: string | null
    modified: boolean
} & ({
    type: "func" | "var"
} | {
    type: "comp"
    src: string
})

type ExportSym = {
    localName: string
    exportName: string
}

export function transformJsx(code: string, fileName: string, sourceMap: any, isBrowser = true, enableHotReload = true): { code: string, map: any } {
    const tracer = enableHotReload && sourceMap ? new TraceMap(sourceMap) : null
    let filenameId: number
    
    if (filenameMap.has(fileName)) {
        filenameId = filenameMap.get(fileName)!
    }
    else {
        filenameId = filenameCounter++
        filenameMap.set(fileName, filenameId)
    }

    const collectedInfo: CollectedInfo = {
        syms: [],
        exported: [],
    }

    const ast = parse(code, { sourceType: 'module', plugins: ["jsx", "typescript"], sourceFilename: fileName })
    walkAst(collectedInfo, fileName, filenameId, enableHotReload, tracer)(ast)

    let generated: { code: string, map: any }

    if (isBrowser) {
        // @ts-ignore
        generated = generate(ast, { sourceMaps: false })
    }
    else {
        generated = generate.default(ast, { sourceMaps: true, sourceFileName: fileName })
    }

    if (enableHotReload) {
        type Exported = { localName: string, exportName: string, modified: boolean, src: string }

        const exportedComp: Exported[] = []
        const addExports: Exported[] = []
        let shouldInvalidate = false
        let hasExportedVar = false

        for (const sym of collectedInfo.syms) {
            if (sym.type === "comp") {
                if (sym.inModuleName) {
                    exportedComp.push({ localName: sym.name, exportName: sym.inModuleName, modified: sym.modified, src: sym.src })
                }
                else {
                    const ex = collectedInfo.exported.find(x => x.localName === sym.name)

                    if (ex) {
                        exportedComp.push({ localName: sym.name, exportName: ex.exportName, modified: sym.modified, src: sym.src })
                    }
                    else {
                        const x: Exported = { localName: sym.name, exportName: `_$$Exp_${sym.name}`, modified: sym.modified, src: sym.src }
                        exportedComp.push(x)
                        addExports.push(x)
                    }
                }
            }
            else {
                if (sym.inModuleName || collectedInfo.exported.find(x => x.localName === sym.name)) {
                    if (sym.modified) {
                        shouldInvalidate = true
                    }

                    hasExportedVar = true
                }
            }
        }

        // Kalau gak shouldInvalidate, check apa ada perubahan variable/function internal
        // Kalau ada yang berubah, set all component to be `modified`
        if (!shouldInvalidate) {
            for (const sym of collectedInfo.syms) {
                if (sym.type !== "comp" && !sym.inModuleName && sym.modified) {
                    for (const e of exportedComp) {
                        e.modified = true
                    }
                }
            }
        }

        // Kalau ada exported component baru, juga shouldInvalidate = true
        const prevExportedComp = exportedCompMap.get(fileName)
        if (prevExportedComp && exportedComp.some(x => !prevExportedComp.includes(x.localName))) {
            shouldInvalidate = true
        }
        exportedCompMap.set(fileName, exportedComp.map(x => x.localName))

        const exported: Record<string, Exported> = {}
        for (const e of exportedComp) {
            exported[e.localName] = e
        }

        generated.code = `${generated.code}
import {
    updateComp as _$$updateComp,
    hotReloadComp as _$$hotReloadComp,
    createHmrContext as _$$createHmrContext,
    evaluateProxy as _$$evaluateProxy,
} from "@pang/hmr.js"

if (!window._$$filenames) window._$$filenames = {}
window._$$filenames['${filenameId}'] = '${fileName}'

${exportedComp.map(x => `${x.localName}._$$pangSrc = '${x.src}'`).join("\n")}

${addExports.map(x => `export { ${x.localName} as ${x.exportName} }`).join("\n")}

export const _$$hmr = _$$createHmrContext("${fileName}")
export const _$$shouldInvalidate = ${shouldInvalidate}
export const _$$exported = ${JSON.stringify(exported)}
export const _$$hasExportedVar = ${hasExportedVar}

let _$$shouldRefresh = false

if (import.meta.hot) {
    import.meta.hot.on("vite:beforeUpdate", () => {
        import.meta.hot.data['_$$${fileName}__data'] = _$$hmr.data
    })
    
    import.meta.hot.accept(mod => {
        mod._$$hmr.data.stateMap = import.meta.hot.data['_$$${fileName}__data'].stateMap
        mod._$$hmr.data.deepStateMap = import.meta.hot.data['_$$${fileName}__data'].deepStateMap
        
        const shouldInvalidate = _$$hmr.shouldInvalidate()
        const shouldRefresh = _$$shouldRefresh
        _$$shouldRefresh = false
        
        if (mod._$$hasExportedVar && (mod._$$shouldInvalidate || shouldRefresh)) {
            _$$hmr.invalidate()
            import.meta.hot.invalidate()
        }
        else {
            _$$hmr.startHotReload()
            ${exportedComp.map(x => `_$$updateComp(${x.localName}, mod.${x.exportName}, shouldRefresh || (mod._$$exported['${x.localName}']?.modified ?? false), shouldInvalidate)`).join("\n")}
            _$$hmr.endHotReload()
        }
    })
    
    import.meta.hot.on("pang:refresh:${fileName}", () => {
        _$$shouldRefresh = true
    })
}
`
    }

    return generated
}

function walkAst(collectedInfo: CollectedInfo, fileName: string, filenameId: number, enableHotReload: boolean, tracer: TraceMap | null) {
    const compStack: string[] = []
    let curComp = ""
    let depth = 0

    function checkAstChanged(name: string, ast: Node) {
        const astId = `${fileName}::${name}`
        let modified = false
        const newAst = generate.default(ast).code

        if (astMap.has(astId)) {
            const oldAst = astMap.get(astId)

            if (newAst !== oldAst) {
                modified = true
            }
        }

        astMap.set(astId, newAst)

        return modified
    }

    function processFunctionDeclaration(decl: FunctionDeclaration, exported: boolean, isDefaultExport: boolean, c: (node: Node) => void) {
        let isComp = false
        let pangSrc = ""

        if (enableHotReload) {
            if (/^[A-Z].*/.test(decl.id?.name ?? "")) {
                decl.body.body.unshift({
                    type: "ExpressionStatement",
                    expression: {
                        type: "CallExpression",
                        callee: {
                            type: "Identifier",
                            name: "_$$hmr.enter"
                        },
                        arguments: [
                            {
                                type: "StringLiteral",
                                value: decl.id?.name ?? "",
                            }
                        ]
                    }
                })

                isComp = true
                curComp = decl.id?.name ?? ""
                compStack.push(decl.id?.name ?? "")
                
                const line = decl.id?.loc?.start.line
                const column = decl.id?.loc?.start.column

                if (tracer !== null && line && column) {
                    const original = originalPositionFor(tracer, {
                        line,
                        column
                    })

                    if (original.line !== null) {
                        pangSrc = `${filenameId}:${original.line}:${original.column + 1}::${decl.id?.name ?? ""}`
                    }
                }
            }

            const modified = checkAstChanged(decl.id?.name ?? "", decl)

            collectedInfo.syms.push({
                name: decl.id?.name ?? "",
                inModuleName: exported ? (isDefaultExport ? "default" : decl.id?.name ?? "") : null,
                modified,
                type: isComp ? "comp" : "func",
                src: pangSrc,
            })
        }

        depth++
        c(decl.body)
        curComp = ""
        depth--

        if (enableHotReload && isComp) {
            compStack.pop()
        }
    }

    function processVarDecl(decl: VariableDeclaration, exported: boolean) {
        if (enableHotReload) {
            for (const d of decl.declarations) {
                if (d.id.type === "Identifier") {
                    const modified = checkAstChanged(d.id.name, d)

                    collectedInfo.syms.push({
                        name: d.id.name,
                        inModuleName: exported ? d.id.name : null,
                        modified,
                        type: "var",
                    })
                }
            }
        }
    }

    function processClassDeclaration(decl: ClassDeclaration, exported: boolean, isDefaultExport: boolean) {
        if (enableHotReload) {
            if (decl.id?.name) {
                const modified = checkAstChanged(decl.id.name, decl)

                collectedInfo.syms.push({
                    name: decl.id.name ?? "",
                    inModuleName: isDefaultExport ? "default" : decl.id.name,
                    modified,
                    type: "var",
                })
            }
        }
    }

    function processExport(localName: string, exportName: string) {
        collectedInfo.exported.push({ localName, exportName })
    }

    return recursive({
        ExportNamedDeclaration(node, _, c) {
            if (node.declaration?.type === "FunctionDeclaration") {
                processFunctionDeclaration(node.declaration, true, false, c)
            }
            else if (node.declaration?.type === "VariableDeclaration") {
                processVarDecl(node.declaration, true)
            }
            else if (node.declaration?.type === "ClassDeclaration") {
                processClassDeclaration(node.declaration, true, false)
            }
            else {
                for (const s of node.specifiers) {
                    if (s.type === "ExportSpecifier") {
                        processExport(
                            s.local.name,
                            s.exported.type === "StringLiteral" ? s.exported.value : s.exported.name,
                        )
                    }
                    else if (s.type === "ExportDefaultSpecifier") {
                        processExport(
                            s.exported.name,
                            'default',
                        )
                    }
                    else {
                        // TODO: "ExportNamespaceSpecifier"
                    }
                }
            }
        },

        ExportDefaultDeclaration(node, _, c) {
            if (node.declaration?.type === "FunctionDeclaration") {
                processFunctionDeclaration(node.declaration, true, true, c)
            }
            else if (node.declaration.type === "Identifier") {
                processExport(node.declaration.name, "default")
            }
            else if (node.declaration.type === "ClassDeclaration") {
                processClassDeclaration(node.declaration, true, true)
            }
            else {
                // TODO: Handle something else
            }
        },

        FunctionDeclaration(node, _, c) {
            processFunctionDeclaration(node, false, false, c)
        },

        VariableDeclaration(node, _, c) {
            if (!enableHotReload) return

            if (curComp) {
                for (const decl of node.declarations) {
                    if (
                        decl.init?.type === "CallExpression"
                        && decl.init.callee.type === "Identifier"
                        && decl.id.type === "Identifier"
                    ) {
                        if (decl.init.callee.name === "state") {
                            decl.init.callee.name = "_$$hmr.state"
                            decl.init.arguments = [
                                {
                                    type: "StringLiteral",
                                    value: `${curComp}_${decl.id.name}`,
                                },
                                ...decl.init.arguments,
                            ]
                        }
                        else if (decl.init.callee.name === "deepState") {
                            decl.init.callee.name = "_$$hmr.deepState"
                            decl.init.arguments = [
                                {
                                    type: "StringLiteral",
                                    value: decl.id.name,
                                },
                                ...decl.init.arguments,
                            ]
                        }
                    }
                }
            }
            else if (depth === 0) {
                processVarDecl(node, false)
            }
        },

        ClassDeclaration(node, _, c) {
            processClassDeclaration(node, false, false)
        },

        CallExpression(node, _, c) {
            for (const arg of node.arguments) {
                c(arg)
            }

            if (node.callee.type === 'Identifier' && node.callee.name === 'jsx') {
                processJsxCall(node, tracer, filenameId, compStack.length > 0 ? compStack[compStack.length - 1] : "")
            }
        },
    })
}

function processJsxCall(call: CallExpression, tracer: TraceMap | null, filenameId: number, curComp: string) {
    const line = call.loc?.start.line
    const column = call.loc?.start.column
    let pangSrc: string | null = null

    if (tracer !== null && line && column) {
        const original = originalPositionFor(tracer, {
            line,
            column
        })

        if (original.line !== null) {
            pangSrc = `${filenameId}:${original.line}:${original.column + 1}::${curComp}`
        }
    }

    const props = call.arguments[1]
    let actualProps = props
    
    const propToRemoves: number[] = []
    
    if (props.type === 'ObjectExpression') {
        for (let a = 0; a < props.properties.length; a++) {
            const prop = props.properties[a]
            
            if (prop.type === 'ObjectProperty' && isExpression(prop.value)) {
                let key: string | null = null

                if (prop.key.type === 'Identifier') {
                    key = prop.key.name
                }
                else if (prop.key.type === 'StringLiteral') {
                    key = prop.key.value
                }

                prop.value = wrapWithArrow(prop.value)
            }
            else if (prop.type === "SpreadElement") {
                propToRemoves.push(a)
                                
                actualProps = callExpression(
                    memberExpression(
                        identifier("Object"),
                        identifier("defineProperties"),
                    ),
                    [
                        actualProps,
                        callExpression(
                            memberExpression(
                                identifier("Object"),
                                identifier("getOwnPropertyDescriptors"),
                            ),
                            [
                                prop.argument
                            ]
                        )
                    ]
                )
            }
        }

        if (pangSrc) {
            props.properties.push(
                objectProperty(stringLiteral("data-pang-src"), wrapWithArrow(stringLiteral(pangSrc)))
            )
        }
    
        for (let a = props.properties.length - 1; a >= 0; a--) {
            if (propToRemoves.includes(a)) {
                props.properties.splice(a, 1)
            }
        }
    }
    else if (props.type === 'NullLiteral') {
        if (pangSrc) {
            call.arguments[1] = objectExpression([
                objectProperty(stringLiteral("data-pang-src"), wrapWithArrow(stringLiteral(pangSrc)))
            ])
        }
    }

    for (let a = 2; a < call.arguments.length; a++) {
        const child = call.arguments[a]

        if (isConditionalExpression(child)) {
            call.arguments[a] = replaceWithIf(child)
        }
        else if (isLogicalExpression(child) && child.operator === '&&') {
            call.arguments[a] = replaceWithIfLogical(child)
        }
        else if (isExpression(child)) {
            call.arguments[a] = wrapWithArrow(child)
        }
    }
    
    call.arguments[1] = actualProps
}

function replaceWithIf(node: ConditionalExpression): SpreadElement {
    const elements: Expression[] = [
        wrapWithArrow(createCondition('$$If', node.test, node.consequent))
    ]

    let next = node.alternate

    while (isConditionalExpression(next)) {
        elements.push(
            wrapWithArrow(createCondition('$$ElseIf', next.test, next.consequent))
        )

        next = next.alternate
    }

    elements.push(
        wrapWithArrow(createCondition('$$Else', null, next))
    )

    return {
        type: "SpreadElement",
        argument: {
            type: 'ArrayExpression',
            elements,
        }
    }
}

function replaceWithIfLogical(node: LogicalExpression): SpreadElement {
    return {
        type: "SpreadElement",
        argument: {
            type: 'ArrayExpression',
            elements: [
                wrapWithArrow(
                    createCondition('$$If', node.left, node.right)
                ),
                wrapWithArrow(createCondition('$$Else', null, { type: 'NullLiteral' }))
            ]
        }
    }
}

function createCondition(type: '$$If' | '$$ElseIf' | '$$Else', test: Expression | null, consequent: Expression): CallExpression {
    return {
        type: 'CallExpression',
        callee: {
            type: 'Identifier',
            name: 'jsx'
        },
        arguments: [
            {
                type: 'StringLiteral',
                value: type,
            },
            type === '$$Else' ? {
                type: 'NullLiteral'
            } : {
                type: 'ObjectExpression',
                properties: [
                    {
                        type: 'ObjectProperty',
                        key: {
                            type: 'Identifier',
                            name: 'cond',
                        },
                        computed: false,
                        shorthand: false,
                        value: wrapWithArrow(test!)
                    }
                ]
            },
            wrapWithArrow(consequent),
        ]
    }
}

function wrapWithArrow(node: Expression): ArrowFunctionExpression {
    const x = arrowFunctionExpression([], node, false)

    // x.loc = node.loc
    // x.start = node.start
    // x.end = node.end

    return x
}