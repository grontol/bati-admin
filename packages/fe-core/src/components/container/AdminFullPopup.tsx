import { PageContainer } from "@tahfeedz/fe-core/components/container/PageContainer.jsx";
import { Icon } from "@tahfeedz/fe-core/components/Icon.jsx";
import { prevent, scale } from "@pang";
import { twMerge } from "tailwind-merge";

export function AdminFullPopup(props: {
    title?: string
    subtitle?: string
    
    visible?: boolean
    onCancel?: () => void
    
    children?: JSX.Element
    action?: JSX.Element
    class?: string
}) {
    function cancel() {
        props.onCancel?.()
    }
    
    return <>
        {props.visible && (
            <div
                class={twMerge(
                    "flex flex-col fixed h-screen left-0 right-0 top-0 bottom-0 z-20 bg-white",
                    props.class,
                )}
                transition={scale({duration: 75})}
            >
                <div 
                    class="flex flex-col flex-1 overflow-hidden h-full bg-linear-to-br from-back to-primary/30" 
                >
                    <PageContainer class="relative p-0 flex-1 overflow-auto">
                        <button 
                            class="absolute right-4 top-4 text-black-light hover:text-primary-dark hover:scale-110 z-10 cursor-pointer"
                            onclick={cancel}
                        >
                            <Icon icon="icon-[mdi--close]" class="text-xl"/>
                        </button>
                        
                        <div class="p-6 py-3 border-b border-black-extra-light shadow-sm relative">
                            <h1 class="text-xl font-semibold text-primary-dark font-secondary">{props.title ?? "Title Here"}</h1>
                            
                            {props.subtitle && (
                                <h2 class="text-sm text-black-light">{props.subtitle}</h2>
                            )}
                        </div>
                        
                        <form class="flex-1 flex flex-col overflow-hidden" onsubmit={prevent()}>
                            <div class="py-3 px-6 pb-10 flex-1 flex flex-col overflow-auto bg-back/50">
                                {props.children}
                            </div>
                            
                            <div class="p-4 flex flex-row justify-end border-t border-black-extra-light">
                                {props.action}
                            </div>
                        </form>
                    </PageContainer>
                </div>
            </div>
        )}
    </>
}