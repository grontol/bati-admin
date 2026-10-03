import { foreach } from "./core.js"
import { onDestroy, onMount } from "./lifecycle.js"
import { derived, effect, persistentState, state } from "./reactive.js"

type StackTrace = {
    src: string
    compName: string
}

type Snippet = {
    line: number
    code: string
    isTarget: boolean
}

type SnippetResponse = {
    snippet: Snippet[]
}

type CompTree = {
    name: string
    src: string
    children: CompTree[]
    els: HTMLElement[]
}

const IFRAME_EVENT_NAME = "IFRAME_INSPECT_OVERLAY"

type IFrameEventData = {
    type: string,
    data: StackTrace[],
    instance: string,
}

export function InspectOverlay(props: { appEl: HTMLElement }) {
    let isTicking = false
    let curEl: HTMLElement | null = null
    let ctrlCount = 0
    let stackEl: HTMLElement | null = null
    let resizeMode: "none" | "left" | "right" | "top" | "bottom" = "none"
    let resizeStartX = 0
    let resizeStartY = 0
    let resizeStartWidth = 0
    let resizeStartHeight = 0
    
    const inspectActive = state(false)
    const detailActive = state<"none" | "stacktrace" | "comptree">("none")
    const rect = state<{ w: number, h: number, t: number, l: number } | null>(null)
    const compName = state<string | null>(null)
    const stacks = state<StackTrace[] | null>(null)
    const compTree = state<CompTree | null>(null)
    const stackMode = persistentState<"overlay" | "inline">("_$$pang_dev_overlay_mode", "overlay")
    const stackPosition = persistentState<"bottom" | "left" | "right" | "top">("_$$pang_dev_overlay", "bottom")
    const stackHeight = persistentState<number | null>("_$$pang_dev_overlay_height", null)
    const stackWidth = persistentState<number | null>("_$$pang_dev_overlay_width", null)

    effect(() => {
        if (inspectActive.value) {
            document.body.style.cursor = "crosshair"
        }
        else {
            document.body.style.cursor = ""
        }
    }, [inspectActive])
    
    effect(() => {
        if (stackMode.value === "inline" && detailActive.value !== "none") {
            if (stackPosition.value === "left") {
                props.appEl.style.margin = `0 0 0 ${stackWidth.value ?? stackEl?.getBoundingClientRect().width ?? 0}px`
            }
            else if (stackPosition.value === "right") {
                props.appEl.style.margin = `0 ${stackWidth.value ?? stackEl?.getBoundingClientRect().width ?? 0}px 0 0`
            }
            else if (stackPosition.value === "bottom") {
                props.appEl.style.margin = `0 0 ${stackHeight.value ?? stackEl?.getBoundingClientRect().height ?? 0}px 0`
            }
            else {
                props.appEl.style.margin = `${stackHeight.value ?? stackEl?.getBoundingClientRect().height ?? 0}px 0 0 0`
            }
        }
        else {
            props.appEl.style.margin = "0"
        }
    }, [detailActive, stackWidth, stackHeight, stackPosition, stackMode])

    function clear() {
        inspectActive.value = false
        detailActive.value = "none"
    }

    let timeoutId: any = null    
    function handleKeydown(e: KeyboardEvent) {
        if (e.key === "Control") {
            if (timeoutId) clearTimeout(timeoutId)
            ctrlCount += 1

            if (ctrlCount >= 3) {
                detailActive.value = "comptree"
                ctrlCount = 0
                compTree.value = collectCompTree()
            }
            else {
                timeoutId = setTimeout(() => {
                    if (ctrlCount === 2) {
                        inspectActive.value = true
                        stacks.value = null
                    }
                    
                    ctrlCount = 0
                }, 300)
            }
        }

        if (e.key === "Escape") {
            if (inspectActive.value) {
                inspectActive.value = false
            }
            else if (detailActive.value !== "none") {
                detailActive.value = "none"
            }
        }

        if (inspectActive.value) {
            e.preventDefault()
            e.stopPropagation()
            e.stopImmediatePropagation()
        }
    }

    function handleMousemove(e: MouseEvent) {
        if (resizeMode !== "none") {
            if (resizeMode === "bottom") {
                stackHeight.value = resizeStartHeight + (resizeStartY - e.clientY)
            }
            else if (resizeMode === "top") {
                stackHeight.value = resizeStartHeight + (e.clientY - resizeStartY)
            }
            else if (resizeMode === "left") {
                stackWidth.value = resizeStartWidth + (e.clientX - resizeStartX)
            }
            else {
                stackWidth.value = resizeStartWidth + (resizeStartX - e.clientX)
            }
        }
        else if (inspectActive.value) {
            if (!isTicking) {
                window.requestAnimationFrame(() => {
                    const elements = document.elementsFromPoint(e.clientX, e.clientY)
                    const targetElement = elements.find(x => !!((x as any)._$$pangMeta?.["src"])) as HTMLElement | null

                    if (targetElement) {
                        curEl = targetElement

                        const r = targetElement.getBoundingClientRect()
                        rect.value = { t: r.top, l: r.left, w: r.width, h: r.height }

                        const pangSrc = (targetElement as any)._$$pangMeta["src"]
                        compName.value = pangSrc?.split("::")?.[1] ?? null
                    }
                    else {
                        rect.value = null
                        curEl = null
                    }

                    isTicking = false
                })

                isTicking = true
            }
        }
    }
    
    function handleMouseup() {
        if (resizeMode === "none") return
        resizeMode = "none"
    }

    function handleClick(e: PointerEvent) {
        if (inspectActive.value && curEl) {
            const source = getMeta(curEl, "src")

            if (curEl && source) {
                e.preventDefault()
                e.stopPropagation()
                e.stopImmediatePropagation()

                if (window.name) {
                    window.parent.postMessage({
                        type: IFRAME_EVENT_NAME,
                        data: collectStackTraces(source, curEl),
                        instance: window.name,
                    } satisfies IFrameEventData)
                    
                    inspectActive.value = false
                }
                else {
                    stacks.value = collectStackTraces(source, curEl)
                    
                    if (detailActive.value === "none") {
                        inspectActive.value = false
                        detailActive.value = "stacktrace"
                    }
                }
            }
            else {
                stacks.value = null
            }
        }
    }
    
    function collectStackTraces(self: string, el: Element): StackTrace[] {
        const res: StackTrace[] = []
        let curEl: Node = el
        let compEndCount = 0

        res.push(parseSrc(self))

        while (true) {
            if (curEl.previousSibling) {
                curEl = curEl.previousSibling
            }
            else if (curEl.parentNode) {
                curEl = curEl.parentNode
            }
            else {
                break
            }

            if (curEl instanceof Comment) {
                if (getMeta(curEl, "compEnd")) {
                    compEndCount += 1
                }
                else if (getMeta(curEl, "compStart")) {
                    if (compEndCount > 0) {
                        compEndCount -= 1
                    }
                    else {
                        const src = getMeta(curEl, "callSrc")
                        
                        if (src) {
                            res.push(parseSrc(src))
                        }
                    }
                }
            }
        }

        return res
    }
    
    function collectCompTree() {
        const treeStack: CompTree[] = [
            {
                name: "[Root]",
                src: "",
                children: [],
                els: [],
            }
        ]
        
        function doRecursive(node: Node) {
            for (const c of node.childNodes) {
                if (getMeta(c, "compStart")) {
                    const tree: CompTree = {
                        name: getMeta(c, "compName") ?? "",
                        src: getMeta(c, "compSrc") ?? "",
                        children: [],
                        els: [],
                    }
                    
                    treeStack[treeStack.length - 1].children.push(tree)
                    treeStack.push(tree)
                }
                else if (getMeta(c, "compEnd")) {
                    treeStack.pop()
                }
                
                doRecursive(c)
            }
        }
        
        doRecursive(props.appEl)
        
        if (treeStack.length !== 1) {
            console.error("Invalid comp tree")
        }
        
        return treeStack[0]
    }

    function gotoSource(src: string) {
        fetch(`/__open-in-editor?file=${encodeURIComponent(src)}`)
    }
    
    function startResize(e: MouseEvent) {
        if (!stackEl) return
        
        const r = stackEl.getBoundingClientRect()
        
        resizeMode = stackPosition.value
        resizeStartX = e.clientX
        resizeStartY = e.clientY
        resizeStartWidth = r.width
        resizeStartHeight = r.height
        
        e.stopImmediatePropagation()
        e.stopPropagation()
        e.preventDefault()
    }
    
    function onMessage(e: Event & { data?: IFrameEventData }) {
        if (e.data && e.data.type === IFRAME_EVENT_NAME) {
            stacks.value = e.data.data
                    
            if (detailActive.value === "none") {
                inspectActive.value = false
                detailActive.value = "stacktrace"
            }
        }
    }

    onMount(() => {
        window.addEventListener("keydown", handleKeydown, { capture: true })
        window.addEventListener("mousemove", handleMousemove, { capture: true })
        window.addEventListener("mouseup", handleMouseup, { capture: true })
        window.addEventListener("click", handleClick)
        
        if (!window.name) {
            window.addEventListener("message", onMessage)
        }
    })

    onDestroy(() => {
        window.removeEventListener("keydown", handleKeydown, { capture: true })
        window.removeEventListener("mousemove", handleMousemove, { capture: true })
        window.removeEventListener("mouseup", handleMouseup, { capture: true })
        window.removeEventListener("click", handleClick)
        
        if (!window.name) {
            window.removeEventListener("message", onMessage)
        }
    })

    return <>
        {inspectActive.value && <>
            <div
                noInspect={true}
                style={{
                    position: "fixed",
                    background: "transparent",
                    zIndex: "9999991",
                    inset: "0",
                }}
            />
        
            {rect.value && (
                <div
                    noInspect={true}
                    style={{
                        position: "fixed",
                        zIndex: "9999992",
                        width: `${rect.value.w}px`,
                        height: `${rect.value.h}px`,
                        left: `${rect.value.l}px`,
                        top: `${rect.value.t}px`,
                        background: "rgba(228, 19, 217, 0.25)",
                        border: "1px solid rgb(228, 19, 217)",
                        pointerEvents: "none",
                    }}
                />
            )}

            {compName.value && (
                <div
                    noInspect={true}
                    style={{
                        ...{
                            position: "fixed",
                            background: "rgb(131, 52, 131)",
                            color: "white",
                            zIndex: "9999994",
                            bottom: "",
                            right: "",
                            top: "",
                            left: "",
                            padding: "4px 14px",
                            fontFamily: "monospace",
                            fontSize: "1.2em",
                            borderRadius: "6px",
                        },
                        ...(
                            stackPosition.value === "bottom" ? {
                                top: "0.5em",
                                right: "0.5em",
                            }
                            : stackPosition.value === "top" ? {
                                bottom: "0.5em",
                                right: "0.5em",
                            }
                            : stackPosition.value === "left" ? {
                                bottom: "0.5em",
                                right: "0.5em",
                            }
                            : {
                                bottom: "0.5em",
                                left: "0.5em",
                            }
                        )
                    }}
                >{compName.value}</div>
            )}
        </>}

        {detailActive.value !== "none" && (
            <div
                ref={x => stackEl = x}
                onmousedown={e => {
                    e.stopPropagation()
                }}
                noInspect={true}
                style={{
                    ...{
                        cursor: "default",
                        position: "fixed",
                        background: "rgb(75, 54, 75)",
                        color: "white",
                        zIndex: "9999993",
                        display: "flex",
                        flexDirection: "column",
                        maxWidth: "",
                        maxHeight: "",
                        top: "",
                        bottom: "",
                        left: "",
                        right: "",
                        width: "",
                        height: "",
                        borderTopWidth: "0",
                        borderBottomWidth: "0",
                        borderLeftWidth: "0",
                        borderRightWidth: "0",
                        borderTopStyle: "",
                        borderBottomStyle: "",
                        borderLeftStyle: "",
                        borderRightStyle: "",
                        borderColor: "rgb(131, 102, 131)",
                    },
                    ...(
                        stackPosition.value === "bottom" ? {
                            bottom: "0",
                            right: "0",
                            left: "0",
                            maxHeight: stackHeight.value ? "" : "60%",
                            height: stackHeight.value ? `${stackHeight.value}px` : "",
                            borderTopWidth: "1px",
                            borderTopStyle: "solid",
                        }
                        : stackPosition.value === "left" ? {
                            bottom: "0",
                            top: "0",
                            left: "0",
                            maxWidth: stackWidth.value ? "" : "60%",
                            width: stackWidth.value ? `${stackWidth.value}px` : "",
                            borderRightWidth: "1px",
                            borderRightStyle: "solid",
                        }
                        : stackPosition.value === "right" ? {
                            bottom: "0",
                            top: "0",
                            right: "0",
                            maxWidth: stackWidth.value ? "" : "60%",
                            width: stackWidth.value ? `${stackWidth.value}px` : "",
                            borderLeftWidth: "1px",
                            borderLeftStyle: "solid",
                        }
                        : {
                            top: "0",
                            right: "0",
                            left: "0",
                            maxHeight: stackHeight.value ? "" : "60%",
                            height: stackHeight.value ? `${stackHeight.value}px` : "",
                            borderBottomWidth: "1px",
                            borderBottomStyle: "solid",
                        }
                    )
                }}
            >                
                <div
                    style={{
                        display: "flex",
                        alignItems: "center",
                        marginBottom: "0.5em",
                        marginRight: "5px",
                        marginTop: "5px",
                        paddingLeft: "0.5em",
                    }}
                >
                    <Button
                        active={inspectActive.value}
                        onclick={() => inspectActive.value = !inspectActive.value}
                    >
                        <Crosshair/>
                    </Button>
                    
                    <Button
                        active={stackPosition.value === "top"}
                        onclick={() => stackPosition.value = "top"}
                        style={{
                            marginLeft: "1em",
                        }}
                    >
                        <DockTop/>
                    </Button>
                    
                    <Button
                        active={stackPosition.value === "left"}
                        onclick={() => stackPosition.value = "left"}
                    >
                        <DockLeft/>
                    </Button>
                    
                    <Button
                        active={stackPosition.value === "bottom"}
                        onclick={() => stackPosition.value = "bottom"}
                    >
                        <DockBottom/>
                    </Button>
                    
                    <Button
                        active={stackPosition.value === "right"}
                        onclick={() => stackPosition.value = "right"}
                    >
                        <DockRight/>
                    </Button>
                    
                    <Button
                        active={stackMode.value === "overlay"}
                        onclick={() => stackMode.value = "overlay"}
                        style={{
                            marginLeft: "1em",
                        }}
                    >
                        <Overlay/>
                    </Button>
                    
                    <Button
                        active={stackMode.value === "inline"}
                        onclick={() => stackMode.value = "inline"}
                    >
                        <Inline/>
                    </Button>
                    
                    <div style={{ flex: "1" }}/>
                    
                    <div
                        style={{
                            fontFamily: "monospace",
                            fontSize: "1.4em",
                            cursor: "pointer",
                            padding: "0 5px",
                            borderRadius: "3px",
                            hover: {
                                background: "#ffffff33",
                            },
                            active: {
                                background: "#ffffff55",
                            }
                        }}
                        onclick={clear}
                    >x</div>
                </div>
                
                {detailActive.value === "stacktrace" && stacks.value ? (
                    <div
                        style={{
                            overflow: "auto",
                            flex: "1",
                            padding: "1.5em",
                            paddingTop: "0",
                        }}
                    >
                        {foreach(stacks.value, (s, i) => (
                            <div>
                                {i > 0 && (
                                    <div
                                        style={{
                                            height: "1px",
                                            background: "#744c6a",
                                            margin: "0.5em 0"
                                        }}
                                    />
                                )}

                                <div
                                    style={{
                                        fontWeight: "bold",
                                        fontSize: "1.3em",
                                        fontFamily: "monospace"
                                    }}
                                >[{s.compName}]</div>

                                <div
                                    style={{
                                        color: "#d6b6ff",
                                        cursor: "pointer",
                                        textDecoration: "underline",
                                        fontFamily: "monospace",
                                        fontSize: "1.05em",
                                        background: "transparent",
                                        outline: "none",
                                        border: "none",
                                        textAlign: "left",
                                        direction: "rtl",
                                        whiteSpace: "nowrap",
                                        overflow: "hidden",
                                        textOverflow: "ellipsis",
                                        
                                        hover: {
                                            color: "#bb94ee",
                                        }
                                    }}
                                    onclick={() => gotoSource(s.src)}
                                >&lrm;{s.src}&lrm;</div>

                                <SourcePreview src={s.src} />
                            </div>
                        ))}
                    </div>
                ) : detailActive.value === "comptree" && compTree.value ? (
                    <div
                        style={{
                            padding: "1em 2em"
                        }}
                    >
                        <CompTreeView tree={compTree.value}/>
                    </div>
                ) : null}
                
                {/* Resize handles ---------------- */}
                <div
                    style={{
                        ...{
                            position: "absolute",
                            left: "",
                            right: "",
                            top: "",
                            bottom: "",
                            width: "",
                            height: "",
                            cursor: "",
                        },
                        ...(
                            stackPosition.value === "bottom" ? {
                                left: "0",
                                right: "0",
                                top: "-5px",
                                height: "10px",
                                cursor: "ns-resize",
                            }
                            : stackPosition.value === "left" ? {
                                top: "0",
                                bottom: "0",
                                right: "-8px",
                                width: "10px",
                                cursor: "ew-resize",
                            }
                            : stackPosition.value === "right" ? {
                                top: "0",
                                bottom: "0",
                                left: "-5px",
                                width: "10px",
                                cursor: "ew-resize",
                            }
                            : {
                                left: "0",
                                right: "0",
                                bottom: "-5px",
                                height: "10px",
                                cursor: "ns-resize",
                            }
                        )
                    }}
                    onmousedown={startResize}
                />
            </div>
        )}
    </>
}

function CompTreeView(props: { tree: CompTree }) {
    const expanded = state(false)
    
    return <div>
        <div
            style={{
                cursor: "pointer",
                color: "",
                display: "flex",
                alignItems: "center",
                userSelect: "none",
                
                hover: {
                    color: "#ff93e4",
                }
            }}
            onclick={() => expanded.value = !expanded.value}
        >
            {props.tree.children.length > 0 ? <ArrowRight rotate={expanded.value}/> : <div style={{ width: "1.3em" }}/>}
            {"<"}{props.tree.name}{">"}
        </div>
        
        {expanded.value && (
            <div
                style={{
                    marginLeft: "1em",
                }}
            >
                {foreach(props.tree.children, c => <CompTreeView tree={c}/>)}
            </div>
        )}
    </div>
}

function SourcePreview(props: { src: string }) {
    const snippets = state<Snippet[]>([])
    const lineNumberWidth = derived(() => (snippets.value.length > 0 ? snippets.value[snippets.value.length - 1].line : 0).toString().length)

    onMount(async () => {
        const parts = props.src.split(":")
        const file = parts[0]
        const line = parts[1]

        const res = await fetch(`/__get-source-snippet?file=${encodeURIComponent(file)}&line=${line}`)
        const json = await res.json() as SnippetResponse
        snippets.value = json.snippet
    })

    return <div
        style={{
            padding: "1em 1.5em",
            background: "rgb(41, 31, 41)",
            borderRadius: "10px",
            margin: "1em 0",
            whiteSpace: "pre",
            fontFamily: "monospace",
            overflowX: "auto",
        }}
    >
        {foreach(snippets.value, s => (
            <div
                style={{
                    color: s.isTarget ? "#bbffc6" : "#adcce7",
                }}
            >{s.isTarget ? "--> " : "    "}{s.line.toString().padStart(lineNumberWidth.value, ' ')} | {s.code}</div>
        ))}
    </div>
}

function Button(props: {
    active?: boolean
    onclick?: () => void
    children?: JSX.Element
    style?: CssStyle
}) {
    return <button
        style={{
            ...{
                outline: "none",
                border: "none",
                background: "transparent",
                color: props.active ? "#ff93e4" : "#cccccc",
                cursor: "pointer",
                padding: "4px",
                borderRadius: "3px",
                hover: {
                    background: "#ffffff22",
                },
                active: {
                    background: "#ffffff33",
                }
            },
            ...props.style
        }}
        onclick={e => {
            props.onclick?.()
            e.preventDefault()
            e.stopPropagation()
        }}
    >
        {props.children}
    </button>
}

function DockTop() {
    return <svg xmlns="http://www.w3.org/2000/svg" width="1.3em" height="1.3em" viewBox="0 0 24 24">
        <path d="M0 0h24v24H0z" fill="none" />
        <path fill="currentColor" d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2m0 16H5v-9h14zm0-11H5V5h14z" />
    </svg>
}

function DockRight() {
    return <svg xmlns="http://www.w3.org/2000/svg" width="1.3em" height="1.3em" viewBox="0 0 24 24">
        <path d="M0 0h24v24H0z" fill="none" />
        <path fill="currentColor" d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2M5 19V5h9v14zm14 0h-3V5h3z" />
    </svg>
}

function DockBottom() {
    return <svg xmlns="http://www.w3.org/2000/svg" width="1.3em" height="1.3em" viewBox="0 0 24 24">
        <path d="M0 0h24v24H0z" fill="none" />
        <path fill="currentColor" d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2m0 16H5v-3h14zm0-5H5V5h14z" />
    </svg>
}

function DockLeft() {
    return <svg xmlns="http://www.w3.org/2000/svg" width="1.3em" height="1.3em" viewBox="0 0 24 24">
        <path d="M0 0h24v24H0z" fill="none" />
        <path fill="currentColor" d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2M5 19V5h3v14zm5 0V5h9v14z" />
    </svg>
}

function Overlay() {
    return <svg xmlns="http://www.w3.org/2000/svg" width="1.3em" height="1.3em" viewBox="0 0 32 32">
        <path d="M0 0h32v32H0z" fill="none" />
        <path fill="currentColor" d="M28 8h-4V4a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2v18a2 2 0 0 0 2 2h4v4a2 2 0 0 0 2 2h18a2 2 0 0 0 2-2V10a2 2 0 0 0-2-2M4 22V4h18v4H10a2 2 0 0 0-2 2v12Zm18 0h-2.586L10 12.586V10h2.586L22 19.416Zm-12-6.586L16.586 22H10Zm12.001 1.173L15.414 10H22ZM10 28v-4h12a2 2 0 0 0 2-2V10h4v18Z" />
    </svg>
}

function Inline() {
    return <svg xmlns="http://www.w3.org/2000/svg" width="1.3em" height="1.3em" viewBox="0 0 24 24">
        <path d="M0 0h24v24H0z" fill="none" />
        <path fill="currentColor" d="M3 16V8q0-.425.288-.712T4 7h8q.425 0 .713.288T13 8v8q0 .425-.288.713T12 17H4q-.425 0-.712-.288T3 16m13 1q-.425 0-.712-.288T15 16t.288-.712T16 15h4q.425 0 .713.288T21 16t-.288.713T20 17zM4 21q-.425 0-.712-.288T3 20t.288-.712T4 19h16q.425 0 .713.288T21 20t-.288.713T20 21zM4 5q-.425 0-.712-.288T3 4t.288-.712T4 3h16q.425 0 .713.288T21 4t-.288.713T20 5z" />
    </svg>
}

function Crosshair() {
    return <svg xmlns="http://www.w3.org/2000/svg" width="1.3em" height="1.3em" viewBox="0 0 24 24">
        <path d="M0 0h24v24H0z" fill="none" />
        <path fill="currentColor" d="M11 3h2v7h-2zm0 11h2v7h-2zm3-3h7v2h-7zM3 11h7v2H3z" />
    </svg>
}

function ArrowRight(props: { rotate?: boolean }) {
    return <svg style={props.rotate ? "rotate: 90deg" : ""} xmlns="http://www.w3.org/2000/svg" width="1.3em" height="1.3em" viewBox="0 0 24 24">
    	<path d="M0 0h24v24H0z" fill="none" />
        <path fill="currentColor" d="M10 17V7l5 5z" />
    </svg>
}

function parseSrc(src: string): StackTrace {
    const parts = src.split("::")
    const srcParts = parts[0].split(":")
    const actualSrc = `${(window as any)._$$filenames?.[srcParts[0]]}:${srcParts[1]}:${srcParts[2]}`
    const compName = parts[1] ?? ""
    
    return {
        src: actualSrc,
        compName,
    }
}

function getMeta(el: Node, key: string) {
    return (el as any)._$$pangMeta?.[key]
}