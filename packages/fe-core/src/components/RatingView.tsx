import { foreach } from "@pang/core.js"
import { onMount } from "@pang/lifecycle.js"
import { derived } from "@pang/reactive.js"
import { twMerge } from "tailwind-merge"

export function RatingView(props: {
    value: number
    onChange?: (value: number) => void
    readonly?: boolean
    size?: "xs" | "sm" | "md"
    class?: string
}) {
    const size = derived(() => props.size === "xs" ? "" : props.size === "sm" ? "text-lg" : "text-3xl")
    const value = derived(() => Math.round(props.value))
    
    let container: HTMLDivElement
    
    let width = 0
    
    let isMouseDown = false
    
    function mouseDown(e: MouseEvent) {
        isMouseDown = true
        refreshValue(e.offsetX)
    }
    
    function refreshValue(x: number) {
        props.onChange?.(Math.round((x) * 10 / width))
    }
    
    onMount(() => {
        setTimeout(() => {
            const r = container.getBoundingClientRect()
            width = r.width
        }, 10)
    })
    
    return <div
        class={twMerge(
            "flex self-center",
            props.class,
        )}
        ref={v => container = v}
        onmousedown={mouseDown}
    >
        {foreach(5, i => <>
            {(i + 1) * 2 <= value.value ? (
                <span class={`icon-[mdi--star] ${size.value} text-yellow-500 pointer-events-none`}/>
            ) : i * 2 + 1 <= value.value ? (
                <div class="relative flex pointer-events-none">
                    <span
                        class={`icon-[mdi--star] ${size.value} text-yellow-500 pointer-events-none`}
                        style={{ clipPath: "inset(0 50% 0 0)" }}
                    />
                    
                    <span
                        class={`icon-[mdi--star] ${size.value} text-gray-400 absolute left-0 pointer-events-none`}
                        style={{ clipPath: "inset(0 0 0 50%)" }}
                    />
                </div>
            ) : (
                <span class={`icon-[mdi--star] ${size.value} text-gray-400 pointer-events-none`}/>
            )}
        </>)}
    </div>
}