import { derived, onDestroy, onMount, state } from "@pang"
import { foreach } from "@pang/core.js"
import { curtain, easeLinear } from "@pang/transition.js"
import { Icon } from "@tahfeedz/fe-core/components/Icon.jsx"
import { Ripple } from "@tahfeedz/fe-core/components/Ripple.jsx"
import { addPopStateListener, historyPopWithoutEffect, historyPush, removePopStateListener } from "@tahfeedz/fe-core/lib/utils/history.js"
import { colors } from "@tahfeedz/fe-core/utils/colors.js"
import { twMerge } from "tailwind-merge"

export type BottomNavigationItem = {
    text: string
    image?: string
    icon?: string
    iconClass?: string
    color: string
    view: () => JSX.Element
    large?: boolean
}

export function BottomNavigation(props: {
    items: BottomNavigationItem[]
    activeColor?: string
    activeIndex?: number
    isNavigationActive: () => boolean
    style?: "normal" | "sweet"
}) {
    const homeIndex = props.activeIndex ?? 0
    const activeIndex = state(props.activeIndex ?? 0)
    const hasLarge = derived(() => props.items.some(x => x.large))
    const activeColor = derived(() => props.activeColor ?? "black")
    const style = derived(() => props.style ?? "sweet")
    
    function select(index: number) {
        if (index === homeIndex && activeIndex.value !== homeIndex) {
            historyPopWithoutEffect()
        }
        else if (activeIndex.value === homeIndex && index !== homeIndex) {
            historyPush("BottomNavigation")
        }
        
        activeIndex.value = index
    }
    
    function onPopState() {
        if (!props.isNavigationActive()) {
            return
        }
        
        if (activeIndex.value !== homeIndex) {
            activeIndex.value = homeIndex
        }
    }
    
    onMount(() => {
        addPopStateListener(onPopState)
    })
    
    onDestroy(() => {
        removePopStateListener(onPopState)
    })
    
    return <div class="flex-1 flex flex-col overflow-hidden relative">
        <div class="flex flex-col flex-1 overflow-auto">
            {props.items[activeIndex.value].view()}
        </div>
        
        {style.value === "normal" ? (
            <div class="flex items-end border border-black-extra-light overflow-hidden">
                {foreach(props.items, (item, i) => (
                    <div
                        class={twMerge(
                            "flex flex-col items-center flex-1 p-2 relative cursor-pointer",
                            item.large ? "pt-1" : hasLarge.value ? "pt-3" : "pt-2",
                        )}
                        onclick={() => select(i)}
                    >
                        <div
                            class={twMerge(
                                "w-6 h-6 mask-cover mask-no-repeat transition-transform",
                                item.large && "w-8 h-8",
                                activeIndex.value === i && "scale-125",
                            )}
                            style={{
                                maskImage: `url(${item.image})`,
                                background: activeIndex.value === i ? colors[(i - 1 + colors.length) % colors.length] ?? activeColor.value : "#737373",
                            }}
                        />
                        
                        <span
                            class={twMerge(
                                "text-xs mt-1",
                                activeIndex.value === i && "font-bold",
                            )}
                            style={{
                                color: activeIndex.value === i ? colors[(i - 1 + colors.length) % colors.length] ?? activeColor.value : "#737373",
                            }}
                        >{item.text}</span>
                        
                        <Ripple noHidden={true}/>
                    </div>
                ))}
            </div>
        ) : (
            <div class="flex items-center gap-1 overflow-hidden px-4 py-2.5 bg-white border-t border-x border-black/10 rounded-t-2xl">
                {foreach(props.items, (item, i) => (
                    <div
                        class={twMerge(
                            "flex items-center justify-center relative pl-3 pr-4 py-1 rounded-full transition-colors duration-75 cursor-pointer overflow-hidden",
                            activeIndex.value === i ? "text-white" : "flex-1",
                        )}
                        style={{
                            background: activeIndex.value === i ? item.color ?? activeColor.value : "transparent",
                        }}
                        onclick={() => select(i)}
                    >
                        {item.image && (
                            <div
                                class="w-6 h-6 mask-cover mask-no-repeat shrink-0 transition-colors duration-75"
                                style={{
                                    maskImage: `url(${item.image})`,
                                    background: activeIndex.value === i ? "white" : "#737373",
                                }}
                            />
                        )}
                        
                        {item.icon && (
                            <Icon
                                icon={item.icon}
                                class={twMerge(
                                    "text-2xl shrink-0",
                                    item.iconClass,
                                )}
                                style={{
                                    color: activeIndex.value === i ? "white" : "#737373",
                                }}
                            />
                        )}
                        
                        {activeIndex.value === i && (
                            <div
                                class="text-sm font-bold ml-2 text-white"
                                transition={curtain({ direction: "horizontal", scale: "both", duration: 75, easing: easeLinear })}
                            >{item.text}</div>
                        )}
                        
                        <Ripple noHidden={true} class="rounded-full"/>
                    </div>
                ))}
            </div>
        )}
    </div>
}