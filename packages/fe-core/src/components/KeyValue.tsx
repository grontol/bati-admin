import { foreach } from "@pang/core.js"

export function KeyValue(props: {
    items: { key: string, value: JSX.Element, visible?: boolean }[]
    keyWidth?: string
}) {
    return <table>
        <tbody>
            {foreach(props.items, item => <>
                {(item.visible ?? true) && (
                    <tr class="items-start">
                        <td width={props.keyWidth}>{item.key}</td>
                        <td class="px-2 w-px">:</td>
                        <td class="">{item.value}</td>
                    </tr>
                )}
            </>)}
        </tbody>
    </table>
}