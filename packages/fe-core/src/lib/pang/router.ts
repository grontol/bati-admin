import { ElNode, PrimitiveNode, ReplaceableNode, createCompNode } from "./core.js"
import { derived, state } from "./reactive.js"

export type RouteParam = {
    path?: Record<string, string>,
    children?: JSX.Element,
}

export type RouterConfig = {
    routes: RouterRoute[],
    notFound?: JSX.Component,
    unauthorized?: JSX.Component,
}

export type RouterRoute = {
    path: string,
    component?: (param: RouteParam) => JSX.Element,
    children?: RouterRoute[],
    authGuard?: AuthGuard,
    query?: string
}

type RouterComponent = (param: RouteParam) => JSX.Element
export type AuthGuardRedirect = { type: "redirect", path: string }
export type AuthGuardResult = boolean | AuthGuardRedirect
export type AuthGuard = () => AuthGuardResult

type RouterItem = {
    paths: string[],
    components: RouterComponent[],
    authGuards: AuthGuard[],
}

const activePath = state<string[]>([])
const activePathString = derived(() => '/' + activePath.value.join("/"))

let globalReload: (() => void) | null = null

export function Router(config: RouterConfig): JSX.Component {
    const node = new ReplaceableNode()
    const items = collectRouterItems(config.routes)
    let comps: RouterComponent[] = []
    const nodes = [node]
    
    function reload() {
        const hash = location.hash
        const paths = splitPath(trimAnyChar(hash, '#'))
        activePath.value = paths
        const matchedItems = matchItems(paths, items)
        
        let replaceIndex = 0
        
        if (matchedItems.length > 0) {
            let item: RouterItem | null = null
            let guardRes: AuthGuardResult = true
            
            for (const i of matchedItems) {
                let guardResPerMatch: AuthGuardResult = true
                
                for (const guard of i.authGuards) {
                    const r = guard()
                    
                    if (typeof r === "boolean") {
                        if (!r) {
                            guardResPerMatch = false
                            break
                        }
                    }
                    else {
                        guardResPerMatch = r
                        break
                    }
                }
                
                if (guardResPerMatch === true) {
                    item = i
                    guardRes = guardResPerMatch
                    break
                }
                else if (guardRes === true) {
                    guardRes = guardResPerMatch
                }
            }
            
            if (item && guardRes === true) {
                for (let a = 0; a < comps.length; a++) {
                    if (a >= item.components.length || comps[a] !== item.components[a]) {
                        break
                    }
                    
                    replaceIndex = a + 1
                }
                
                comps = [...item.components]
                
                for (let a = nodes.length - 1; a > replaceIndex; a--) {
                    nodes.splice(a, 1)
                }
                
                let prevNode: PNode | null = null
                
                for (let a = comps.length - 1; a >= replaceIndex; a--) {
                    const replacable = prevNode ? new ReplaceableNode(prevNode) : null
                    const compNode = createCompNode(comps[a], null, replacable ? [replacable] : null)
                    
                    if (replacable) {
                        nodes[a + 1] = replacable
                    }
                    
                    prevNode = compNode
                }
                
                nodes[replaceIndex]?.replace(prevNode)
            }
            else if (typeof guardRes === "boolean") {
                if (!guardRes) {
                    comps = []
                    nodes.splice(1, nodes.length - 1)
                    
                    if (config.unauthorized) {
                        node.replace(createCompNode(config.unauthorized, null, null))
                    }
                    else {
                        node.replace(
                            new ElNode('div', { class: () => 'bg-gray-800 h-screen flex items-center justify-center text-3xl font-bold' }, [
                                new PrimitiveNode('UNAUTHORIZED')
                            ])
                        )
                    }
                }
            }
            else if (guardRes.type === "redirect") {
                goto(guardRes.path, false)
            }
        }
        else {
            comps = []
            nodes.splice(1, nodes.length - 1)
            
            if (config.notFound) {
                node.replace(createCompNode(config.notFound, null, null))
            }
            else {
                node.replace(
                    new ElNode('div', { class: () => 'bg-gray-800 h-screen flex items-center justify-center text-3xl font-bold' }, [
                        new PrimitiveNode('NOT FOUND')
                    ])
                )
            }
        }
    }
    
    globalReload = reload
    reload()
    
    window.onhashchange = () => {
        reload()
    }
    
    return () => node
}

export function formatUrlPath(path: string, withHash = true) {
    if (withHash) {
        return '/' + [
            '#',
            ...path.split('/').filter(x => !!x)
        ].join('/')
    }
    else {
        return '/' + [
            ...path.split('/').filter(x => !!x)
        ].join('/')
    }
}

export function goto(path: string, pushHistory = true) {
    if (pushHistory) {
        window.location.hash = formatUrlPath(path, false)
        
        if (window.location.search) {
            window.location.search = ""
        }
    }
    else {
        const oldPath = trimAnyChar(window.location.hash, "#/", true, true)
        const newPath = trimAnyChar(path, "#/", true, true)
        
        if (oldPath !== newPath) {        
            let newUrl = trimAnyChar(window.location.pathname, "/", true, true) + formatUrlPath(path, true)
            if (newUrl === "/#") newUrl = "/"
            
            history.replaceState(null, "", newUrl)
            
            // HACK: Fix biar kalau dipanggil pas Component init
            //       Soalnya bikin context gak beraturan
            //       Dikasih setTimeout({}, 0) biar mastiin selesai dari current event loop
            setTimeout(() => {
                globalReload?.()
            }, 0)
        }
    }
}

export function isActivePath(path: string) {
    return matchPath(activePath.value, splitPath(trimAnyChar(path, "#/")))
}

export function getActivePathStore(): Obs<string> {
    return activePathString
}

function matchPath(paths: string[], patterns: string[]) {
    if (paths.length !== patterns.length) {
        return false
    }
    
    for (let a = 0; a < paths.length; a++) {
        if (paths[a] !== patterns[a]) {
            return false
        }
    }
    
    return true
}

function matchItems(paths: string[], items: RouterItem[]): RouterItem[] {
    const res: RouterItem[] = []
    
    for (const item of items) {
        if (matchPath(paths, item.paths)) {                
            res.push(item)
        }
    }
    
    return res
}

function collectRouterItems(configs: RouterRoute[]) {
    function inner(
        config: RouterRoute,
        parentPaths: string[],
        parentComponents: (RouterComponent | undefined)[],
        parentAuthGuards: AuthGuard[],
        out: RouterItem[],
    ) {
        const paths = [...parentPaths, ...splitPath(config.path)].filter(x => !!x)
        const components = [...parentComponents, config.component]
        const authGuards = config.authGuard ? [...parentAuthGuards, config.authGuard] : [...parentAuthGuards]
        
        if (config.children) {
            for (const child of config.children) {
                inner(child, paths, components, authGuards, out)
            }
        }
        else {
            out.push({
                paths,
                components: components.filter(x => !!x) as any,
                authGuards,
            })
        }
    }
    
    const items: RouterItem[] = []
    
    for (const config of configs) {
        inner(config, [], [], [], items)
    }
    
    return items
}

function splitPath(path: string) {
    return trimAnyChar(path, '/').split('/').filter(x => !!x)
}

function trimAnyChar(path: string, chars: string, doStart = true, doEnd = true) {
    let start = 0
    let end = path.length
    
    if (doStart) {
        for (let a = 0; a < path.length; a++) {
            if (chars.includes(path[a])) {
                start++
            }
            else {
                break
            }
        }
    }
    
    if (doEnd) {
        for (let a = path.length - 1; a > start; a--) {
            if (chars.includes(path[a])) {
                end--
            }
            else {
                break
            }
        }
    }
    
    if (start === 0 && end === path.length) {
        return path
    }
    else if (end - start > 0) {
        return path.slice(start, end)
    }
    else {
        return ''
    }
}