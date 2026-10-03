import { onDestroy, onMount } from "@pang"
import { isMobile } from "@tahfeedz/fe-core/lib/utils/device.js"
import { twMerge } from "tailwind-merge"

export function Ripple(props: {
    class?: string
    noHidden?: boolean
    color?: string
    disabled?: boolean
}) {
    let el: HTMLDivElement
    let circle: HTMLSpanElement | null = null
    let anim: Animation | null = null
    
    const isMobileView = isMobile().value

    function click(e: MouseEvent) {
        if (props.disabled) return
        
        if (!circle) {
            circle = document.createElement("span")
        }
        
        if (anim) {
            anim.cancel()
        }

        const diameter = Math.min(el.clientWidth, el.clientHeight, 70)
        const radius = diameter / 2
        
        circle.style.pointerEvents = 'none'
        circle.style.width = circle.style.height = `${diameter}px`
        circle.style.left = `${e.offsetX - (el.offsetLeft + radius)}px`
        circle.style.top = `${e.offsetY - (el.offsetTop + radius)}px`
        circle.style.position = "absolute"
        circle.style.borderRadius = "50%"
        circle.style.transform = "scale(0)"
        circle.style.background = props.color ?? "rgba(0, 0, 0, 0.2)"
        circle.style.opacity = "1"

        anim = circle.animate([{
            transform: `scale(4)`,
            opacity: 0
        }], {
            duration: 350
        })
        
        anim.onfinish = () => {
            anim = null
        }

        el.appendChild(circle)
    }

    function touchStart(e: TouchEvent) {
        if (props.disabled) return
        
        if (!circle) {
            circle = document.createElement("span")
        }
        
        if (anim) {
            anim.cancel()
        }

        const diameter = Math.min(el.clientWidth, el.clientHeight)
        const radius = diameter / 2
        const r = (e.target as HTMLElement).getBoundingClientRect()

        circle.style.pointerEvents = 'none'
        circle.style.width = circle.style.height = `${diameter}px`
        circle.style.left = `${e.touches[0].pageX - r.left - (el.offsetLeft + radius)}px`
        circle.style.top = `${e.touches[0].pageY - r.top - (el.offsetTop + radius)}px`
        circle.style.position = "absolute"
        circle.style.borderRadius = "50%"
        circle.style.transform = "scale(0)"
        circle.style.background = props.color ?? "rgba(0, 0, 0, 0.2)"
        circle.style.opacity = "1"

        anim = circle.animate([{
            transform: `scale(4)`,
            opacity: 0
        }], {
            duration: 350
        })
        
        anim.onfinish = () => {
            anim = null
        }

        el.appendChild(circle)
    }
    
    onMount(() => {
        if (isMobileView) {
            el.addEventListener("touchstart", touchStart)
        }
        else {
            el.addEventListener("mousedown", click)
        }
    })
    
    onDestroy(() => {
        if (isMobileView) {
            el.removeEventListener("touchstart", touchStart)
        }
        else {
            el.removeEventListener("mousedown", click)
        }
    })

    return <div
        ref={x => el = x}
        noInspect={true}
        class={twMerge(
            "absolute left-0 right-0 top-0 bottom-0",
            !props.noHidden && "overflow-hidden",
            props.class
        )}
    >
    </div>
}