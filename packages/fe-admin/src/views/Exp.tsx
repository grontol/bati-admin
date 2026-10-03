import { deepState, effect, state } from "@pang"
import { DateInput } from "@tahfeedz/fe-core/components/input/DateInput.jsx"
import { Table } from "@tahfeedz/fe-core/components/table/Table.jsx"

export function Exp() {
    const xx = { d: new Date(), s: "x" }
    console.log("xx", xx)
    const data = deepState<{ d: Date, s: string }>(xx)
    
    effect(() => console.log(data.value.d))
    
    return <div>
        {/* <DateInput
            value={data.value.d}
            onChange={v => data.value.d}
        /> */}
    </div>
}