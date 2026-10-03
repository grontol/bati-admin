import { fade, scale, self } from "@pang";
import { Icon } from "@tahfeedz/fe-core/components/Icon.jsx";
import { twMerge } from "tailwind-merge";

export function ModalPopup(props: {
    visible: boolean
    onClose?: () => void
    dismissOnClickOutside?: boolean
    
    title?: JSX.Element
    children?: JSX.Element
    action?: JSX.Element
}) {
    function onClickOutside() {
        if ((props.dismissOnClickOutside ?? true)) {
            props.onClose?.()
        }
    }
    
    return <>
        {props.visible && (
            <div
                class={twMerge(
                    "fixed bg-black/60 top-0 left-0 right-0 bottom-0 z-999 flex flex-row items-center justify-center",
                )}
                onclick={self(onClickOutside)}
                transition={fade({ duration: 75 })}
            >
                <div
                    class="flex flex-col bg-white rounded-md p-4 mx-4"
                    style={{ minWidth: `min(500px, 90%)` }}
                    transition={scale({ duration: 75 })}
                >
                    {props.title && (
                        <h1 class="text-xl font-bold text-black-medium">{props.title}</h1>
                    )}
                    
                    <div class="py-2 flex flex-col">{props.children}</div>
        
                    {props.action && (
                        <div class="flex flex-row justify-end mt-2">{props.action}</div>
                    )}
                    
                    <Icon
                        icon="icon-[mdi--close]"
                        class="absolute right-2 top-2 text-2xl text-black-light p-1 hover:text-black-medium cursor-pointer"
                        onclick={props.onClose}
                    />
                </div>
            </div>
        )}
    </>
}