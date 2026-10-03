import { twMerge } from "tailwind-merge";

export function TitledPanel(props: {
    title: string
    children?: JSX.Element
    class?: string
    titleClass?: string
    
    style?: "default" | "transparent"
}) {
    return <div
        class={twMerge(
            "flex flex-col border p-3 pt-5 rounded-lg relative",
            props.style === "transparent" ? "border-black-extra-light bg-transparent col-span-2" : "bg-white border-black-light shadow",
            props.class,
        )}
    >
        <div
            class={twMerge(
                "absolute left-2 px-1",
                props.style === "transparent" ? "bg-gray-100" : "bg-white",
                props.titleClass,
            )}
            style={{ bottom: `calc(100% - 0.7em)` }}
        >{props.title}</div>
        {props.children}
    </div>
}