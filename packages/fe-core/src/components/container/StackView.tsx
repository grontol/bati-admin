import { deepState, derived, effect, onDestroy, state } from "@pang"
import { createCompNode, foreach } from "@pang/core.js"
import { addPopStateListener, historyPopWithoutEffect, historyPush } from "@tahfeedz/fe-core/lib/utils/history.js"
import { twMerge } from "tailwind-merge"

type ParamsTypeOf<T extends StackViewComponent> = T extends StackViewComponent<infer P> ? P : void

type StackViewBaseContext = {
    push(name: string, params?: any): Promise<any>
    pushComp<T extends StackViewComponent<any>>(comp: T, params: ParamsTypeOf<T>): Promise<any>
    replace(name: string, params?: any): void
    replaceComp<T extends StackViewComponent<any>>(comp: T, params: ParamsTypeOf<T>): void
    pop(value?: any): void
    popUntil(name: string, value?: any): void
}

export type StackViewContext = StackViewBaseContext & {
    isActive(): boolean
}

export type StackViewComponent<T = any> = (props: { ctx: StackViewContext, params: T }) => JSX.Element

export type StackViewConfig = {
    id: string
    views?: Record<string, StackViewComponent>
    defaultView: string | StackViewComponent
}

type Transition = 'in-left' | 'in-right' | 'out-left' | 'out-right' | 'none'

type StackItem = {
    el: () => JSX.Element
    name: string
    transition: Transition
    visible: boolean
    setReturnValue: (value?: any) => void
    resolver: (res: (value?: any) => void) => void
}

function makeItem(ctx: StackViewContext, name: string, comp: StackViewComponent, params?: any): StackItem {
    let curRes: ((value?: any) => void) | null = null
    
    function resolver(res: (value?: any) => void) {
        curRes = res
    }
    
    return {
        name,
        el: () => createCompNode(comp, { ctx: () => ctx, params: () => params }, null),
        transition: 'none',
        visible: true,
        setReturnValue: (value?: any) => {
            curRes?.(value)
        },
        resolver,
    }
}

const DURATION = 250
const EASING = "cubic-bezier(0.66, 0, 0.34, 1)"

export function StackView(config: StackViewConfig) {    
    const views = config.views ?? {}    
    const ctx: StackViewBaseContext = {
        push: pushName,
        pushComp,
        replace: replaceName,
        replaceComp,
        pop,
        popUntil,
    }
    
    const stack = deepState<StackItem[]>([])
    
    function makeCompleteCtx(name: string): StackViewContext {
        return {
            ...ctx,
            isActive() {
                return stack.value.length > 0 && stack.value[stack.value.length - 1].name === name
            },
        }
    }
 
    // @ts-ignore
    if (!window._$$hotReloadId) {
        stack.value.push(makeItem(
            makeCompleteCtx(typeof config.defaultView === "string" ? config.defaultView : config.defaultView.name),
            typeof config.defaultView === "string" ? config.defaultView : config.defaultView.name,
            typeof config.defaultView === "string" ? views[config.defaultView] : config.defaultView,
        ))
    }
    
    function pushName(name: string, params?: any): Promise<any> {
        return push(name, views[name], params)
    }
    
    function pushComp(comp: StackViewComponent, params?: any): Promise<any> {
        return push(comp.name, comp, params)
    }    
    
    function push(name: string, comp: StackViewComponent, params?: any): Promise<any> {
        const lastItem = stack.value[stack.value.length - 1]
        const newItem = makeItem(makeCompleteCtx(name), name, comp, params)
        
        stack.value.push(newItem)
        historyPush(name)
        newItem.transition = 'in-right'
        lastItem.transition = 'out-left'
        
        setTimeout(() => {
            newItem.transition = 'none'
            lastItem.transition = 'none'
            lastItem.visible = false
        }, DURATION)
        
        return new Promise(newItem.resolver)
    }
    
    function replaceName(name: string, params?: any) {
        return replace(name, views[name], params)
    }
    
    function replaceComp(comp: StackViewComponent, params?: any) {
        return replace(comp.name, comp, params)
    }    
    
    function replace(name: string, comp: StackViewComponent, params?: any) {
        const newItem = makeItem(makeCompleteCtx(name), name, comp, params)
        
        stack.value.pop()
        stack.value.push(newItem)
        newItem.transition = 'in-right'
        
        setTimeout(() => {
            newItem.transition = 'none'
        }, DURATION)
    }
    
    let poppingCount = 0
    
    function pop(value?: any, manualTrigger = true): boolean {
        if (manualTrigger) {
            historyPopWithoutEffect()
        }
        
        if (stack.value.filter(x => !!x).length <= 1) return false
        
        if (poppingCount === 0) {
            poppingCount++
            
            stack.value[stack.value.length - 1].transition = 'out-right'
            stack.value[stack.value.length - 2].transition = 'in-left'
            stack.value[stack.value.length - 2].visible = true
            
            stack.value[stack.value.length - 1].setReturnValue(value)
            
            setTimeout(() => {
                for (let a = 0; a < poppingCount; a++) {
                    stack.value[stack.value.length - 1].visible = false
                    stack.value.pop()
                }
                
                stack.value[stack.value.length - 1].transition = 'none'
                
                poppingCount = 0
            }, DURATION)
        }
        else {
            poppingCount++
            
            stack.value[stack.value.length - poppingCount - 1].transition = 'in-left'
            stack.value[stack.value.length - poppingCount].visible = false
            stack.value[stack.value.length - poppingCount - 1].visible = true
            
            stack.value[stack.value.length - poppingCount].setReturnValue(value)
        }
        
        return true
    }
    
    function popUntil(name: string, value?: any): boolean {
        if (stack.value.length <= 1) return false
        
        const index = stack.value.findIndex(x => x.name === name || x.name === views[name].name)
        if (index < 0) return false
        
        stack.value[stack.value.length - 1].transition = 'out-right'
        stack.value[index].transition = 'in-left'
        stack.value[index].visible = true
        
        for (let a = index + 1; a < stack.value.length; a++) {
            stack.value[a].setReturnValue(value)
            historyPopWithoutEffect()
        }
        
        for (let a = index + 1; a < stack.value.length - 1; a++) {
            stack.value[a].visible = false
        }
        
        setTimeout(() => {
            stack.value.splice(index + 1, stack.value.length - index - 1)
            stack.value[index].transition = 'none'
        }, DURATION)
        
        return true
    }
    
    function popAll() {
        for (let a = 0; a < stack.value.length - 1; a++) {
            historyPopWithoutEffect()
        }
        
        stack.value.splice(0)
    }
    
    addPopStateListener(() => {
        pop(null, false)
    })
    
    onDestroy(() => {
        if (!(window as any)._$$hotReload) {
            popAll()
        }
    })
    
    return <>
        {foreach(stack.value, (v, i) => v ? (
            <StackViewWrapper
                content={v.el()}
                transition={v.transition}
                duration={DURATION}
                visible={v.visible}
            />
        ) : null)}
    </>
}

function StackViewWrapper(props: {
    content: JSX.Element,
    transition: 'in-left' | 'in-right' | 'out-left' | 'out-right' | 'none',
    visible: boolean,
    duration: number,
}) {
    let el: HTMLDivElement
    
    
    const visible = state(true)
    const actualVisible = derived(() => props.visible)// && visible.value)
    
    function getTransitionKeyFrame(value: 0 | 1 | -1) {
        return {
            transform: `translateX(${value * 100}%)`,
        }
    }
    
    effect(() => {
        if (props.transition === 'in-left') {
            visible.value = true
            
            requestAnimationFrame(() => {
                el.animate([
                    getTransitionKeyFrame(-1),
                    getTransitionKeyFrame(0),
                ], {
                    duration: props.duration,
                    easing: EASING,
                })
            })
        }
        else if (props.transition === 'in-right') {
            visible.value = true
            
            requestAnimationFrame(() => {
                el.animate([
                    getTransitionKeyFrame(1),
                    getTransitionKeyFrame(0),
                ], {
                    duration: props.duration,
                    easing: EASING,
                })
            })
        }
        else if (props.transition === 'out-left') {
            visible.value = true
            setTimeout(() => {
                visible.value = false
            }, props.duration)
            
            requestAnimationFrame(() => {
                el.animate([
                    getTransitionKeyFrame(0),
                    getTransitionKeyFrame(-1),
                ], {
                    duration: props.duration,
                    easing: EASING,
                })
            })
        }
        else if (props.transition === 'out-right') {
            visible.value = true
            setTimeout(() => {
                visible.value = false
            }, props.duration)
            
            requestAnimationFrame(() => {
                el.animate([
                    getTransitionKeyFrame(0),
                    getTransitionKeyFrame(1),
                ], {
                    duration: props.duration,
                    easing: EASING,
                })
            })
        }
    })
    
    return <div
        ref={v => el = v}
        class={twMerge(
            "absolute top-0 left-0 flex flex-col h-full w-full bg-white overflow-hidden",
        )}
        style={{
            // NOTE: Kalau pakai contentVisibility, kalau item-nya punya transisi jadinya nunggu transisi dulu baru hilang
            // contentVisibility: actualVisible.value ? "visible" : "hidden",
            display: actualVisible.value ? "flex" : "none",
        }}
    >
        {props.content}
    </div>
}