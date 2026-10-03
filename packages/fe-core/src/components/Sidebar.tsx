import { BreadCrumbItem, breadcrumbStore } from "@tahfeedz/fe-core/components/Breadcrumb.jsx";
import { Icon } from "@tahfeedz/fe-core/components/Icon.jsx";
import { foreach, html } from "@pang/core.js";
import { deepState, derived, effect, state } from "@pang/reactive.js";
import { formatUrlPath, getActivePathStore } from "@pang/router.js";
import { twMerge } from "tailwind-merge";
import { SessionManager } from "@tahfeedz/fe-core/data/session.js";
import { curtain, easeLinear } from "@pang/transition.js";

export type SidebarChildItem = {
    text: string
    link: string
    breadcrumb: BreadCrumbItem[]
    hidden?: boolean
}

export type SidebarItem = {
    text: string
    link?: string
    breadcrumb?: BreadCrumbItem[]
    icon?: string
    children?: SidebarChildItem[]
    expanded?: boolean
    hidden?: boolean
}

export type SidebarSection = {
    text?: string
    items: SidebarItem[]
    hidden?: boolean
}

export function Sidebar(props: {
    sections: SidebarSection[]
    onSelect?: () => void
}) {
    const activePage = getActivePathStore()
    const sections = deepState([...props.sections])
    
    effect(() => {
        outer:
        for (const sec of props.sections) {
            for (const item of sec.items) {
                const link = item.link
                
                if (link && link === activePage.value && item.breadcrumb) {
                    breadcrumbStore.value = item.breadcrumb
                    break outer
                }
                
                if (item.children) {
                    for (const child of item.children) {
                        if (child.link === activePage.value) {
                            breadcrumbStore.value = child.breadcrumb
                            break outer
                        }
                    }
                }
            }
        }
    })
    
    return <div class="h-full w-[300px] p-4 space-y-4 overflow-y-auto">
        <nav>
            <ul class="flex flex-col gap-y-1">
                {foreach(sections.value, section => (
                    !section.hidden ? <>
                        {section.text && (
                            <li class="font-bold text-primary-dark py-2 px-4">{section.text}</li>
                        )}
                        
                        {foreach(section.items, item => (
                            !item.hidden ? (
                                <SidebarItemView 
                                    item={item}
                                    selected={isActive(item, activePage.value)}
                                    activeChildIndex={getActiveChildIndex(item, activePage.value)}
                                    expanded={item.expanded ?? false}
                                    onExpandedChanged={v => item.expanded = v}
                                    onSelect={props.onSelect}
                                />
                            ) : null
                        ))}
                    </> : null
                ))}
            </ul>
        </nav>
    </div>
}

function SidebarItemView(props: {
    item: SidebarItem
    selected: boolean
    activeChildIndex: number
    expanded: boolean
    onExpandedChanged: (v: boolean) => void
    filter?: string
    onSelect?: () => void
}) {
    const searchMode = derived(() => !!props.filter)
    
    function onClick() {
        if (props.item.link) {
            itemClick()
        }
        
        if (!props.item.children?.length) return
        props.onExpandedChanged(!props.expanded)
    }
    
    function itemClick() {
        props.onSelect?.()
    }
    
    function createHighlightSpan(text: string): string {
        const index = text.toLowerCase().indexOf(props.filter?.toLowerCase() ?? '')
        
        if (index < 0) {
            return text
        }
        
        const highlightCls = "text-white bg-orange-500 font-bold"
        
        const left = text.substring(0, index)
        const right = text.substring(index + (props.filter?.length ?? 0))
        const middle = text.substring(index, index + (props.filter?.length ?? 0))
        
        return `${left}<span class="${highlightCls}">${middle}</span>${right}`
    }
    
    return <li class="flex flex-col">
        <a
            href={props.item.link ? formatUrlPath(props.item.link ?? "") : undefined}
            class={twMerge(
                "flex flex-row items-center py-1 px-3 rounded-lg transition-colors cursor-pointer",
                props.selected ? "hover:bg-primary" : "hover:bg-primary/10",
                props.selected ? 'text-white bg-primary-light' : 'text-black-light',
            )}
            onclick={onClick}
        >
            {props.item.icon && (
                <Icon
                    icon={props.item.icon}
                    class={twMerge(
                        "text-xl mr-2",
                        props.selected ? "" : "text-black-light",
                    )}
                />
            )}
        
            <span class="flex-1 font-semibold">
                {props.filter ? (
                    html(createHighlightSpan(props.item.text))
                ) : (
                    props.item.text
                )}
            </span>
            
            {props.item.children?.length && (
                <Icon
                    icon="icon-[ri--arrow-down-s-line]"
                    class={twMerge(
                        "text-lg transition-transform",
                        props.selected ? "scale-125" : "",
                        props.expanded ? "" : "-rotate-90",
                    )}
                />
            )}
        </a>
        
        {(props.expanded || searchMode.value) && props.item.children && (
            <div class="flex flex-col gap-y-1 mt-1 overflow-hidden" transition={curtain({duration: 150, scale: "none", easing: easeLinear})}>
                {foreach(props.item.children, (child, i) => 
                    !child.hidden ? (
                        <a 
                            href={formatUrlPath(child.link)} 
                            class={twMerge(`flex flex-row items-center py-0.5 px-4 ml-6 rounded-lg 
                                transition-[colors,transform]
                                text-black-light hover:text-primary-dark`
                            )}
                            onclick={itemClick}
                        >
                            <span
                                class={twMerge("flex-1 font-semibold",
                                    props.activeChildIndex === i ? "text-primary-dark font-bold" : "",
                                )}
                            >
                                {props.filter ? html(createHighlightSpan(child.text)) : child.text}
                            </span>
                        </a>
                    ) : null
                )}
            </div>
        )}
    </li>
}

function isActive(item: SidebarItem, activePage: string): boolean {
    if (item.link && item.link === activePage) {
        return true
    }
    
    if (item.children && item.children.some(x => {
        return x.link === activePage
    })) {
        return true
    }
    
    return false
}

function getActiveChildIndex(item: SidebarItem, activePage: string): number {
    if (!item.children || !item.children.length || !isActive(item, activePage)) return -1
    
    return item.children.findIndex(x => (x.link === '/' ? '' : x.link) === activePage)
}