import { twMerge } from "tailwind-merge"

export function TintImage(props: {
    image: string
    class?: string
    style?: Partial<CSSStyleDeclaration>
}) {
    return <div
        class={twMerge(
            "mask-cover mask-no-repeat bg-black",
            props.class,
        )}
        style={{
            maskImage: `url(${props.image})`,
            ...props.style,
        }}
    />
}