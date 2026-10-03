import { state } from "@pang";
import { Ripple } from "@tahfeedz/fe-core/components/Ripple.jsx";
import { SvgBack } from "@tahfeedz/fe-core/svgs.jsx";
import { twMerge } from "tailwind-merge";

export function Toolbar(props: {
    title?: string
    noBack?: boolean
    onBack?: () => void
    children?: JSX.Element
    childrenClass?: string
    action?: JSX.Element
    actionClass?: string
    class?: string
}) {
    return <div
        class={twMerge(
            "flex-1 flex flex-col overflow-hidden",
            props.class,
        )}
    >
        <div class="flex p-2 items-center gap-2 relative justify-center bg-white border-b border-black/10">
            {!props.noBack && (
                <button
                    class="active:bg-white/20 flex justify-center items-center p-1 rounded-full transition-colors absolute left-2 cursor-pointer"
                    onclick={props.onBack}
                >
                    <SvgBack fill="#444444"/>
                    <Ripple class="rounded-full"/>
                </button>
            )}
            
            <div class="flex-1"/> 
            <span class="text-black-dark font-bold min-h-7 flex justify-center items-center">{props.title}</span>
            <div class="flex-1"/>
            
            <div class={twMerge("absolute right-2", props.actionClass)}>
                {props.action}
            </div>
        </div>
        
        <div
            class={twMerge(
                "flex flex-col flex-1 overflow-auto",
                props.childrenClass,
            )}
        >
            {props.children}
        </div>
    </div>
}

export function ToolbarMandala(props: {
    title?: string
    header?: JSX.Element
    noBack?: boolean
    onBack?: () => void
    children?: JSX.Element
    childrenClass?: string
    action?: JSX.Element
    class?: string
}) {
    let headerEl: HTMLDivElement | null = null
    
    const scrollValue = state(0)
    
    function handleScroll(e: Event) {
        if (!headerEl) return
                
        const el = e.target as HTMLDivElement
        scrollValue.value = Math.min(el.scrollTop / headerEl.clientHeight, 1)
    }
    
    return <div
        class={twMerge(
            "flex-1 flex flex-col overflow-hidden bg-linear-to-br from-primary to-primary-dark relative",
            props.class,
        )}
    >
        <img
            src="/images/mandala-top.webp"
            class="absolute -top-10 right-0 pointer-events-none"
            style={{
                opacity: !props.header ? '0' : `${1 - scrollValue.value}`
            }}
        />
        
        <div class="flex p-2 items-center gap-2 justify-center relative">
            {!props.noBack && (
                <button
                    class="active:bg-white/20 flex justify-center items-center p-1 rounded-full transition-colors absolute left-2 cursor-pointer"
                    onclick={props.onBack}
                >
                    <svg
                        width="24" height="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"
                        fill="white"
                    >
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M13.165 11.9934L13.1634 11.6393C13.1513 10.2348 13.0666 8.98174 12.9206 8.18763C12.9206 8.17331 12.7613 7.38572 12.6599 7.12355C12.5006 6.74463 12.2126 6.42299 11.8515 6.2192C11.5624 6.0738 11.2592 6 10.9417 6C10.6922 6.01157 10.2806 6.13714 9.98692 6.24242L9.74283 6.33596C8.12612 6.97815 5.03561 9.07656 3.85199 10.3598L3.76473 10.4495L3.37527 10.8698C3.12982 11.1915 3 11.5847 3 12.0077C3 12.3866 3.11563 12.7656 3.3469 13.0718C3.41614 13.171 3.52766 13.2983 3.62693 13.4058L4.006 13.8026C5.31046 15.1243 8.13485 16.9782 9.59883 17.5924C9.59883 17.6057 10.5086 17.9857 10.9417 18H10.9995C11.6639 18 12.2846 17.6211 12.6021 17.0086C12.6888 16.8412 12.772 16.5132 12.8352 16.2252L12.949 15.6813C13.0788 14.8067 13.165 13.465 13.165 11.9934ZM19.4967 13.5183C20.3269 13.5183 21 12.8387 21 12.0004C21 11.1622 20.3269 10.4825 19.4967 10.4825L15.7975 10.8097C15.1463 10.8097 14.6183 11.3417 14.6183 12.0004C14.6183 12.6581 15.1463 13.1912 15.7975 13.1912L19.4967 13.5183Z" fill="inherit"/>
                    </svg>
                    
                    <Ripple class="rounded-full"/>
                </button>
            )}
            
            <div class="flex-1"/> 
            <span
                class="font-bold min-h-7 text-white flex items-center justify-center"
                style={{
                    opacity: !props.header ? '1' : `${scrollValue.value}`
                }}
            >{props.title}</span>
            <div class="flex-1"/>
            
            <div class="absolute right-2">
                {props.action}
            </div>
        </div>
        
        <div class="flex flex-col flex-1 relative overflow-auto" onscroll={handleScroll}>
            {props.header && (
                <div
                    ref={x => headerEl = x}
                    class="flex flex-col p-4 pt-2 text-white"
                    style={{
                        opacity: `${1 - scrollValue.value}`,
                    }}
                >{props.header}</div>
            )}
            
            <div
                class={twMerge(
                    "flex flex-col flex-1 bg-white rounded-t-2xl",
                    props.childrenClass,
                )}
            >
                {props.children}
            </div>
        </div>
    </div>
}

export function ToolbarImage(props: {
    title?: string
    header?: JSX.Element
    noBack?: boolean
    onBack?: () => void
    children?: JSX.Element
    childrenClass?: string
    action?: JSX.Element
    class?: string
}) {
    let headerEl: HTMLDivElement | null = null
    
    const scrollValue = state(0)
    
    function handleScroll(e: Event) {
        if (!headerEl) return
                
        const el = e.target as HTMLDivElement
        scrollValue.value = Math.min(el.scrollTop / headerEl.clientHeight, 1)
    }
    
    return <div
        class={twMerge(
            "flex-1 flex flex-col overflow-hidden relative",
            props.class,
        )}
    >
        <div
            class="flex p-2 items-center gap-2 justify-center absolute top-0 left-0 right-0 z-10"
            style={{
                background: `linear-gradient(to bottom right, rgba(2,146,154,${scrollValue.value.toFixed(2)}), rgba(4,97,102, ${scrollValue.value.toFixed(2)}))`
            }}
        >
            {!props.noBack && (
                <button
                    class="active:bg-white/20 flex justify-center items-center p-1 rounded-full transition-colors absolute left-2 cursor-pointer"
                    style={{
                        background: `rgba(0, 0, 0, ${(1 - scrollValue.value) * 0.2})`
                    }}
                    onclick={props.onBack}
                >
                    <svg
                        width="24" height="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"
                        fill="white"
                    >
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M13.165 11.9934L13.1634 11.6393C13.1513 10.2348 13.0666 8.98174 12.9206 8.18763C12.9206 8.17331 12.7613 7.38572 12.6599 7.12355C12.5006 6.74463 12.2126 6.42299 11.8515 6.2192C11.5624 6.0738 11.2592 6 10.9417 6C10.6922 6.01157 10.2806 6.13714 9.98692 6.24242L9.74283 6.33596C8.12612 6.97815 5.03561 9.07656 3.85199 10.3598L3.76473 10.4495L3.37527 10.8698C3.12982 11.1915 3 11.5847 3 12.0077C3 12.3866 3.11563 12.7656 3.3469 13.0718C3.41614 13.171 3.52766 13.2983 3.62693 13.4058L4.006 13.8026C5.31046 15.1243 8.13485 16.9782 9.59883 17.5924C9.59883 17.6057 10.5086 17.9857 10.9417 18H10.9995C11.6639 18 12.2846 17.6211 12.6021 17.0086C12.6888 16.8412 12.772 16.5132 12.8352 16.2252L12.949 15.6813C13.0788 14.8067 13.165 13.465 13.165 11.9934ZM19.4967 13.5183C20.3269 13.5183 21 12.8387 21 12.0004C21 11.1622 20.3269 10.4825 19.4967 10.4825L15.7975 10.8097C15.1463 10.8097 14.6183 11.3417 14.6183 12.0004C14.6183 12.6581 15.1463 13.1912 15.7975 13.1912L19.4967 13.5183Z" fill="inherit"/>
                    </svg>
                    
                    <Ripple class="rounded-full"/>
                </button>
            )}
            
            <div class="flex-1"/> 
            <div
                class="font-bold min-h-7 text-white pt-0.5 line-clamp-1 mx-10"
                style={{
                    opacity: !props.header ? '1' : `${scrollValue.value}`
                }}
            >{props.title}</div>
            <div class="flex-1"/>
            
            <div class="absolute right-2">
                {props.action}
            </div>
        </div>
        
        <div class="flex flex-col flex-1 overflow-auto" onscroll={handleScroll}>
            {props.header && (
                <div
                    ref={x => headerEl = x}
                    class="flex flex-col"
                    style={{
                        opacity: `${1 - scrollValue.value}`,
                    }}
                >{props.header}</div>
            )}
            
            <div
                class={twMerge(
                    "flex flex-col flex-1",
                    props.childrenClass,
                )}
            >
                {props.children}
            </div>
        </div>
    </div>
}