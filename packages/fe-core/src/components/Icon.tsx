import { Ripple } from "@tahfeedz/fe-core/components/Ripple.jsx"
import { twMerge } from "tailwind-merge"

export function Icon(props: {
    icon: string
    class?: string
    style?: string | Partial<CSSStyleDeclaration>
    onclick?: () => void
}) {
    return <span
        class={twMerge(
            "shrink-0",
            props.icon,
            props.class,
        )}
        style={props.style}
        onclick={props.onclick}
    />
}

export function IconButton(props: {
    icon: string
    class?: string
    onclick?: () => void
}) {
    return <button
        class={twMerge(
            "hover:brightness-105 text-2xl cursor-pointer p-2 text-black-medium transition-colors rounded-full flex items-center justify-center relative",
            props.class,
        )}
        onclick={props.onclick}
        type="button"
    >
        <span
            class={twMerge(
                props.icon,
            )}
        />
        
        <Ripple class="rounded-full"/>
    </button>
}