import { twMerge } from "tailwind-merge";

export function InputError(props: { message: string, class?: string }) {
    return (
        <div class={twMerge("text-error flex items-center gap-1 text-red-500", props.class)}>
            <span class="icon-[bx--error]"></span>
            <span class="text-xs">{props.message}</span>
        </div>
    )
}