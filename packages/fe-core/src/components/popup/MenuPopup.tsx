import { foreach, onDestroy, onMount, scale, state } from "@pang"
import { Icon } from "@tahfeedz/fe-core/components/Icon.jsx"
import { twMerge } from "tailwind-merge"

export type MenuItemDivider = {
    type: "divider"
}
 
export type MenuItemText = {
    type: "button"
    text: string
    icon?: string
    onClick?: () => void
}

export type MenuItem = MenuItemText | MenuItemDivider

export function MenuPopup(props: {
    elId: string
    items: MenuItem[]
    header?: JSX.Element
    children?: JSX.Element
    popupClass?: string
    itemClass?: string
    iconClass?: string
}) {
    let el: HTMLDivElement
    const visible = state(false)
    
    const handleClick = (event: any) => {
        if (!el.contains(event.target) && !event.defaultPrevented) {
            visible.value = false
        }
    }
    
    function onItemClick(item: MenuItemText) {
        item.onClick?.()
        visible.value = false
    }
    
    onMount(() => {
        document.addEventListener('click', handleClick, true)
    })
    
    onDestroy(() => {
        document.removeEventListener('click', handleClick, true)
    })
    
    return <div
        ref={x => el = x}
        class="relative"
    >
        <button
            class="relative hover:bg-black/10 rounded-full cursor-pointer transition-colors"
            onclick={() => visible.value = true}
        >
            {props.children}
        </button>
        
        {visible.value && (
            <div
                class={twMerge(
                    "absolute right-0 top-full mt-2 z-100 bg-white-darker rounded-lg shadow-sharp flex flex-col disable-break py-2 box-border overflow-auto min-w-[200px]",
                    props.popupClass,
                )}
                transition={scale({ duration: 75 })}
            >
                {props.header}
                
                {foreach(props.items, item => <>
                    {item.type === "divider" ? (
                        <div class="bg-black-extra-light/80 h-px my-1"></div>
                    ) : (
                        <button
                            class={twMerge(
                                "px-4 py-1 hover:bg-black/5 transition-colors cursor-pointer flex items-center text-gray-700",
                                props.itemClass,
                            )}
                            onclick={() => onItemClick(item)}
                        >
                            {item.icon && (
                                <Icon
                                    icon={item.icon}
                                    class={twMerge(
                                        "text-xl mr-2 text-black-light",
                                        props.iconClass,
                                    )}
                                />
                            )}
                            
                            <span>{item.text}</span>
                        </button>
                    )}
                </>)}
            </div>
        )}
    </div>
}