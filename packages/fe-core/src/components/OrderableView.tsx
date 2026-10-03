import { Icon } from "@tahfeedz/fe-core/components/Icon.jsx"
import { derived, effect, onDestroy, onMount, state } from "@pang"
import { foreach } from "@pang/core.js"
import { css } from "@pang/css.js"
import Sortable from "sortablejs"
import { twMerge } from "tailwind-merge"

type Props<T> = {
    items: readonly T[]
    render: (t: T) => JSX.Element
    onSorted?: (from: number, to: number) => void
    
    class?: string
    itemClass?: string
}

export function OrderableView<T>(props: Props<T>) {
    let el = state<HTMLDivElement | null>(null)
    let sortable: Sortable | null = null
    
    const canDrag = derived(() => props.items && props.items.length > 1)
    
    effect(() => {
        if (!el.value) return
        
        if (sortable) {
            sortable.destroy()
        }
        
        sortable = Sortable.create(el.value, {
            handle: ".drag-handle",
            ghostClass: "drag-placeholder",
            onEnd(event) {
                if (event.oldIndex !== undefined && event.newIndex !== undefined) {
                    props.onSorted?.(event.oldIndex, event.newIndex)
                }
            },
        })
    })
    
    onDestroy(() => {
        if (sortable) {
            sortable.destroy()
        }
    })
    
    return <>
        <div
            ref={v => el.value = v}
            class={twMerge(
                "flex flex-col",
                props.class,
            )}
        >
            {foreach(props.items, it => (
                <div class={twMerge("flex items-center", props.itemClass)}>
                    <Icon
                        icon="icon-[ooui--draggable]"
                        class={twMerge(
                            "drag-handle text-xl mr-2 text-black-medium cursor-pointer",
                            !canDrag.value && "hidden"
                        )}
                    />
                    
                    {props.render(it)}
                </div>
            ))}
        </div>
        
        <style css={css`
            .drag-placeholder {
                background: #f09f9f !important;
            }
        `}/>
    </>
}