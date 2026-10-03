import { derived } from "@pang/reactive.js"
import { Ripple } from "@tahfeedz/fe-core/components/Ripple.jsx"
import { SvgBack } from "@tahfeedz/fe-core/svgs.jsx"
import { twJoin, twMerge } from "tailwind-merge"

type Props = {
    onclick?: () => void
    children?: JSX.Element
    class?: string

    size?: "sm" | "md" | "lg"
    style?: "fill" | "outline" | "none"
    color?: "primary" | "secondary" | "warning" | "error" | "neutral"
    roundness?: "semi" | "full" | "none"

    disabled?: boolean
    disabledClass?: string
    type?: "submit" | "button"
}

export function Button(props: Props) {
    const size = derived(() => props.size ?? "md")
    const style = derived(() => props.style ?? "fill")
    const color = derived(() => props.color ?? "primary")
    const roundness = derived(() => props.roundness ?? "semi")

    const background = derived(() => {
        if (style.value === 'fill') {
            if (color.value === 'primary') return "bg-primary border border-transparent text-white"
            else if (color.value === 'secondary') return "bg-secondary border border-transparent text-white"
            else if (color.value === 'warning') return "bg-warning border border-transparent text-white"
            else if (color.value === 'error') return "bg-error border border-transparent text-white"
            else return "bg-text-medium/20 border border-transparent text-white"
        }
        else if (style.value === 'outline') {
            if (color.value === 'primary') return "border border-primary text-primary"
            else if (color.value === 'secondary') return "border border-secondary text-secondary"
            else if (color.value === 'warning') return "border border-warning text-warning"
            else if (color.value === 'error') return "border border-error text-error"
            else return "border border-text-medium text-text-medium"
        }
        else {
            if (color.value === 'primary') return "text-primary border border-transparent"
            else if (color.value === 'secondary') return "text-secondary border border-transparent"
            else if (color.value === 'warning') return "text-warning border border-transparent"
            else if (color.value === 'error') return "text-error border border-transparent"
            else return "text-text-medium border border-transparent"
        }
    })

    const paddingAndText = derived(() => {
        if (size.value === "sm") {
            if (roundness.value === "full") return "px-2 py-0.5 text-sm"
            else return "px-1.5 py-0.5 text-sm"
        }
        else if (size.value === "lg") {
            if (roundness.value === "full") return "px-4 py-1.5 text-lg"
            else return "px-3 py-1.5 text-lg"
        }
        else {
            if (roundness.value === "full") return "px-3 py-1"
            else return "px-2 py-1"
        }
    })

    return (
        <button
            type={props.type ?? "button"}
            class={twMerge(
                background.value,
                "cursor-pointer hover:brightness-105 active:brightness-110 flex justify-center items-center",
                paddingAndText.value,
                props.disabled ? props.disabledClass ?? "brightness-145 hover:brightness-145 active:brightness-145 cursor-not-allowed" : "",
                roundness.value === "full" ? "rounded-full" : roundness.value === "semi" ? "rounded" : "",
                props.class,
            )}
            onclick={props.onclick}
            disabled={props.disabled}
        >{props.children}</button>
    )
}

type BenjolProps = {
    onclick?: () => void
    children?: JSX.Element
    class?: string

    size?: "sm" | "md" | "lg"
    color?: "primary" | "secondary" | "warning" | "error" | "neutral"
    strokeColor?: string
    smallWidth?: boolean

    disabled?: boolean
    type?: "submit" | "button"
    
    nextArrow?: boolean
    backArrow?: boolean
    arrowClass?: string
    arrowAbsolute?: boolean
    
    transition?: TransitionRunner
}

export function BenjolButton(props: BenjolProps) {
    return <button
        transition={props.transition}
        class={twMerge(
            "relative flex items-center justify-center p-2 active:brightness-90 cursor-pointer fill-primary text-white transition-all",
            props.disabled ? "fill-gray-400 hover:brightness-100 active:brightness-100 cursor-not-allowed" : "",
            props.class,
        )}
        disabled={props.disabled}
        onclick={props.onclick}
    >
        {props.smallWidth ? (
            <svg
                class="absolute inset-0 w-full h-full fill-inherit transition-colors"
                width="84"
                height="52"
                viewBox="0 0 84 52"
                preserveAspectRatio="none"
                xmlns="http://www.w3.org/2000/svg"
            >
                <path d="M0 14.9446C0 7.63733 5.61496 1.56253 12.9085 1.11453C21.6712 0.576279 33.236 -0.00681928 42.1269 6.1035e-05C50.9204 0.00686606 62.3763 0.585555 71.0824 1.11863C78.3793 1.56543 84 7.64205 84 14.9527V37.0473C84 44.3579 78.3793 50.4345 71.0824 50.8813C62.3764 51.4144 50.9205 51.9931 42.1269 51.9999C33.236 52.0068 21.6712 51.4237 12.9085 50.8854C5.61493 50.4374 0 44.3626 0 37.0553V14.9446Z" fill="#F478B8"/>
            </svg>
        ) : (
            <svg
                class="absolute inset-0 w-full h-full fill-inherit transition-colors"
                width="370"
                height="52"
                viewBox="0 0 370 52"
                preserveAspectRatio="none"
                xmlns="http://www.w3.org/2000/svg"
            >
                <path
                    d="M0 15.7529C0 8.11807 6.0745 1.89327 13.7083 1.76818C45.9823 1.23934 128.342 -0.00999139 185.559 6.10352e-05C242.271 0.0100247 324.123 1.24598 356.287 1.76971C363.922 1.89402 370 8.11925 370 15.7548V36.2452C370 43.8808 363.922 50.106 356.287 50.2303C324.123 50.7541 242.271 51.9901 185.559 52C128.342 52.0101 45.9822 50.7607 13.7082 50.2319C6.07448 50.1068 0 43.882 0 36.2472V15.7529Z"
                    // stroke={props.strokeColor}
                    stroke-width={props.strokeColor ? "1" : undefined}
                    stroke-linejoin={props.strokeColor ? "round" : undefined}
                    stroke-linecap={props.strokeColor ? "round" : undefined}
                    vector-effect={props.strokeColor ? "non-scaling-stroke" : undefined}
                    shape-rendering={props.strokeColor ? "geometricPrecision" : undefined}
                />
            </svg>
        )}
        
        <div
            class={twJoin(
                "flex items-center",
                (props.arrowAbsolute ?? true) ? "flex-1" : "",
            )}
        >
            {props.backArrow && (
                <SvgBack
                    fill="white"
                    class={twMerge(
                        (props.arrowAbsolute ?? true) ? "absolute left-4" : "relative mr-1",
                        props.arrowClass,
                    )}
                />
            )}
            
            <div class="relative font-semibold pointer-events-none flex-1 flex items-center w-full justify-center">{props.children}</div>
            
            {props.nextArrow && (
                <SvgBack
                    fill="white"
                    class={twMerge(
                        "rotate-180",
                        (props.arrowAbsolute ?? true) ? "absolute right-4" : "relative ml-1",
                        props.arrowClass,
                    )}
                />
            )}
        </div>
        
        <Ripple disabled={props.disabled}/>
        
        {props.disabled && (
            <div class="absolute inset-0 bg-white/50"/>
        )}
    </button>
}

export function ToggleButton(props: {
    value: boolean
    label?: string
    onChange?: (value: boolean) => void
    size?: "md" | "sm"
    class?: string
}) {
    const size = derived(() => props.size ?? "md")
    
    return <div
        class={twMerge(
            "flex items-center gap-2 cursor-pointer",
            props.class,
        )}
        onclick={() => props.onChange?.(!props.value)}
    >
        <div
            class={twMerge(
                "p-1 rounded-full h-6 w-12 cursor-pointer relative",
                props.value ? "bg-primary" : "bg-gray-500",
                size.value === "sm" && "h-4 w-8",
            )}
        >
            <div class={twMerge(
                "w-4 h-4 rounded-full bg-white absolute top-1 transition-all ease-in-out",
                props.value ? size.value === "sm" ? "left-4.5" : "left-7" : size.value === "sm" ? "left-0.5" : "left-1",
                size.value === "sm" && "w-3 h-3 top-0.5",
            )} />
        </div>
        
        {props.label && (
            <span
                class={twJoin(
                    props.size === "sm" ? "text-sm" : ""
                )}
            >{props.label}</span>
        )}
    </div>
}