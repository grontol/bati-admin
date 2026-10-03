import { twMerge } from "tailwind-merge"

export function LevelContainer(props: {
    title: string
    description?: string
    children?: JSX.Element
    action?: JSX.Element
    class?: string
    contentClass?: string
}) {
    return <div
        class={twMerge(
            "flex flex-col",
            props.class,
        )}
    >
        <div class="flex items-center bg-primary py-2 px-4 pr-2 rounded-t">
            <span class="text-white text-lg font-semibold">{props.title}</span>
            <span class="text-kedua text-sm font-bold ml-4">{props.description}</span>
            <div class="flex-1"/>
            {props.action}
        </div>
        
        <div class={twMerge("border border-black-extra-light rounded-b", props.contentClass)}>
            {props.children}
        </div>
    </div>
}