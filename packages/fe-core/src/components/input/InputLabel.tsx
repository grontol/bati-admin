import { twMerge } from "tailwind-merge"

export function InputLabel(props: {
    label: JSX.Element,
    for?: string
    required?: boolean,
    class?: string
}) {
    return <label
        class={twMerge(
            "text-sm text-black-medium mb-1.5",
            props.class,
        )}
        for={props.for}
    >
        {props.label}
        
        {props.required && (
            <span class="text-red-500 ml-1">*</span>
        )}
    </label>
}