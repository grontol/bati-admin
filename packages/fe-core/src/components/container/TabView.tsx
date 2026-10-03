import { derived } from "@pang"
import { foreach } from "@pang/core.js"
import { Icon } from "@tahfeedz/fe-core/components/Icon.jsx"
import { Ripple } from "@tahfeedz/fe-core/components/Ripple.jsx"
import { twJoin, twMerge } from "tailwind-merge"

export type TabViewItem = {
    title: JSX.Element
    countIndicator?: number
    icon?: string
    iconImage?: string
    iconClass?: string
    content?: () => JSX.Element
}

export function TabView(props: {
    tabStyle?: "default" | "blue" | "slide" | "flat" | "desktop"
    items: TabViewItem[]
    activeTab: number
    onTabSelected: (i: number) => void
    iconOnActiveOnly?: boolean
    inactiveContentMode?: "destroy" | "hide"
    
    class?: string
    contentClass?: string
    
    desktopHeaderSlot?: JSX.Element
}) {
    const tabStyle = derived(() => props.tabStyle ?? "blue")
    const inactiveContentMode = derived(() => props.inactiveContentMode ?? "destroy")
    
    return <div
        class={twMerge(
            "flex flex-col",
            props.class,
        )}
    >
        {tabStyle.value === "blue" ? (
            <div class="flex gap-2 px-4 py-2 relative">
                <svg
                    class="absolute inset-0 w-full h-full"
                    viewBox="0 0 55 26"
                    preserveAspectRatio="none"
                    xmlns="http://www.w3.org/2000/svg"
                    aria-hidden="true"
                >
                    <path
                        d="M27.5 0.25c7.415 0 17.695 0.652 23.349 1.056 2.205 0.158 3.901 1.996 3.901 4.21v14.969c0 2.213 -1.696 4.052 -3.901 4.21C45.196 25.098 34.916 25.75 27.5 25.75s-17.695 -0.652 -23.349 -1.056C1.946 24.537 0.25 22.698 0.25 20.484V5.516c0 -2.213 1.696 -4.052 3.901 -4.21C9.805 0.902 20.084 0.25 27.5 0.25Z"
                        fill="var(--color-kedua)"
                        vector-effect="non-scaling-stroke"
                        shape-rendering="geometricPrecision"
                    />
                </svg>
                
                {foreach(props.items, (it, i) => (
                    <TabItemBlue
                        item={it}
                        active={props.activeTab === i}
                        onSelect={() => props.onTabSelected(i)}
                        iconOnActiveOnly={props.iconOnActiveOnly}
                    />
                ))}
            </div>
        ) : tabStyle.value === "slide" ? <>
            <div class="flex items-center">
                {foreach(props.items, (it, i) => (
                    <div
                        class={twJoin(
                            "flex-1 text-primary font-bold py-1.5 cursor-pointer relative",
                            i === 0 ? "text-left" : i === props.items.length - 1 ? "text-right" : "text-center"
                        )}
                        onclick={() => props.onTabSelected(i)}
                    >
                        {it.title}
                        
                        <Ripple/>
                    </div>
                ))}
            </div>
            
            <div
                class="h-1 bg-primary transition-transform"
                style={{
                    width: `${100 / props.items.length}%`,
                    transform: `translateX(${100 * props.activeTab}%)`,
                }}
            />
        </> : tabStyle.value === "flat" ? <>
            <div class="flex items-center border-b border-black-extra-light">
                {foreach(props.items, (it, i) => (
                    <div
                        class={twJoin(
                            "flex justify-center items-center flex-1 text-sm font-bold py-1.5 cursor-pointer text-center relative rounded-t-2xl border border-b-0",
                            i === props.activeTab ? "border-black-extra-light text-primary" : "border-transparent text-black-light",
                        )}
                        onclick={() => props.onTabSelected(i)}
                    >
                        <span>{it.title}</span>
                        
                        {it.countIndicator && (
                            <div
                                class={twJoin(
                                    "flex justify-center items-center text-xxs min-w-4 rounded-full ml-1 px-1 pt-0.5",
                                    i === props.activeTab ? "bg-primary/10" : "bg-black-extra-light/50"
                                )}
                            >{it.countIndicator > 10 ? <div class="flex items-center">10<div class="mb-0.5">+</div></div> : it.countIndicator}</div>
                        )}
                        
                        <Ripple class="rounded-t-2xl"/>
                    </div>
                ))}
            </div>
        </> : tabStyle.value === "desktop" ? <>
            <div class="flex items-end border-b border-black-extra-light relative">
                {foreach(props.items, (it, i) => (
                    <div
                        class={twJoin(
                            "flex justify-center items-center px-4 py-1 min-w-20 cursor-pointer text-center relative border border-b-0",
                            i === props.activeTab ? "border-black-extra-light text-primary" : "border-transparent text-black-light bg-black/5",
                            i === 0 && "rounded-tl-lg",
                            i === props.items.length - 1 && "rounded-tr-lg",
                        )}
                        onclick={() => props.onTabSelected(i)}
                    >
                        <span>{it.title}</span>
                    </div>
                ))}
                
                <div class="flex-1"/>
                {props.desktopHeaderSlot}
            </div>
        </> : (
            <div class="flex gap-2">
                {foreach(props.items, (it, i) => (
                    <TabItem
                        item={it}
                        active={props.activeTab === i}
                        onSelece={() => props.onTabSelected(i)}
                    />
                ))}
            </div>
        )}
        
        {inactiveContentMode.value === "destroy" ? (
            <div
                class={twMerge(
                    "flex flex-col flex-1",
                    props.contentClass,
                )}
            >
                {props.items[props.activeTab]?.content?.()}
            </div>
        ) : (
            foreach(props.items, (it, i) => (
                <div
                    class={twMerge(
                        "flex flex-col flex-1",
                        props.contentClass,
                        i !== props.activeTab && "hidden",
                    )}
                >
                    {it.content?.()}
                </div>
            ))
        )}
    </div>
}

function TabItem(props: {
    item: TabViewItem
    active: boolean
    onSelece?: () => void
}) {
    return <button
        class="relative flex items-center flex-1 justify-center px-6 py-3 cursor-pointer"
        onclick={props.onSelece}
    >
        <svg
            class="absolute inset-0 w-full h-full"
            viewBox="0 0 55 26"
            preserveAspectRatio="none"
            xmlns="http://www.w3.org/2000/svg"
            aria-hidden="true"
        >
            <path
                d="M27.5 0.25c7.415 0 17.695 0.652 23.349 1.056 2.205 0.158 3.901 1.996 3.901 4.21v14.969c0 2.213 -1.696 4.052 -3.901 4.21C45.196 25.098 34.916 25.75 27.5 25.75s-17.695 -0.652 -23.349 -1.056C1.946 24.537 0.25 22.698 0.25 20.484V5.516c0 -2.213 1.696 -4.052 3.901 -4.21C9.805 0.902 20.084 0.25 27.5 0.25Z"
                fill={props.active ? "white" : "var(--color-kedua)"}
                stroke={props.active ? "black" : "transparent"}
                stroke-width="1"
                stroke-linejoin="round"
                stroke-linecap="round"
                vector-effect="non-scaling-stroke"
                shape-rendering="geometricPrecision"
            />
        </svg>
        
        {props.item.iconImage && (
            <img
                src={props.item.iconImage}
                class="w-5 h-5 mr-2 relative"
            />
        )}

        <span class="relative font-semibold text-black pointer-events-none">{props.item.title}</span>
        
        <Ripple/>
    </button>
}

function TabItemBlue(props: {
    item: TabViewItem
    active: boolean
    onSelect?: () => void
    iconOnActiveOnly?: boolean
}) {
    const activeAndIconOnActiveOnly = derived(() => props.active && (props.iconOnActiveOnly ?? false))
    
    return <button
        class={twMerge(
            "relative flex items-center flex-1 justify-center px-6 py-1.5 cursor-pointer transition-all overflow-hidden",
            activeAndIconOnActiveOnly.value && "px-10",
        )}
        onclick={props.onSelect}
    >
        <svg
            class="absolute inset-0 w-full h-full"
            viewBox="0 0 55 26"
            preserveAspectRatio="none"
            xmlns="http://www.w3.org/2000/svg"
            aria-hidden="true"
        >
            <path
                d="M27.5 0.25c7.415 0 17.695 0.652 23.349 1.056 2.205 0.158 3.901 1.996 3.901 4.21v14.969c0 2.213 -1.696 4.052 -3.901 4.21C45.196 25.098 34.916 25.75 27.5 25.75s-17.695 -0.652 -23.349 -1.056C1.946 24.537 0.25 22.698 0.25 20.484V5.516c0 -2.213 1.696 -4.052 3.901 -4.21C9.805 0.902 20.084 0.25 27.5 0.25Z"
                fill={props.active ? "white" : "transparent"}
                vector-effect="non-scaling-stroke"
                shape-rendering="geometricPrecision"
            />
        </svg>
        
        {props.item.iconImage && (!props.iconOnActiveOnly || props.active) && (
            <img
                src={props.item.iconImage}
                class={twMerge(
                    "w-5 h-5 mr-2 relative shrink-0",
                    props.item.iconClass,
                )}
            />
        )}
        
        {props.item.icon && (!props.iconOnActiveOnly || props.active) && (
            <Icon
                icon={props.item.icon}
                class={twMerge(
                    "w-5 h-5 mr-2 relative text-primary shrink-0",
                    props.item.iconClass,
                )}
            />
        )}

        <span class="relative font-semibold text-primary pointer-events-none">{props.item.title}</span>
        
        <Ripple class="rounded-xl my-0.5"/>
    </button>
}