import { twMerge } from "tailwind-merge"

export function FormContainer(props: {
    children?: JSX.Element
    cols?: 2 | 3 | 4 | 12
    class?: string
}) {
    return <div
        class={twMerge(
            "grid grid-cols-1 gap-4",
            props.cols === 4 ? "md:grid-cols-4" : props.cols === 3 ? "md:grid-cols-3" : "md:grid-cols-2",
            props.class,
        )}
    >
        {props.children}
    </div>
}