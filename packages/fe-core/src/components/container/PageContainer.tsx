import { twMerge } from "tailwind-merge";

export function PageContainer(props: {
    children?: JSX.Element
    class?: string
}) {
    return <div class={twMerge("p-6 flex flex-col m-4 bg-white rounded-lg shadow-lg", props.class)}>
        {props.children}
    </div>
}