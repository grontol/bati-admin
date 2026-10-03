import { Icon, IconButton } from "@tahfeedz/fe-core/components/Icon.jsx"
import { InputLabel } from "@tahfeedz/fe-core/components/input/InputLabel.jsx"
import { derived } from "@pang"

type Props = {
    label: string
    value: number
    onChange?: (v: number) => void
    minValue?: number
    maxValue?: number
}

export function NumberUpDownInput(props: Props) {
    const minValue = derived(() => props.minValue ?? 0)
    const maxValue = derived(() => props.maxValue ?? 10)
    
    function up() {
        if (props.value >= maxValue.value) return
        props.onChange?.(props.value + 1)
    }
    
    function down() {
        if (props.value <= minValue.value) return
        props.onChange?.(props.value - 1)
    }
    
    return <div class="flex items-stretch">
        <span class="flex-1 text-sm text-black-medium">{props.label}</span>
        
        <button
            class="border border-black-light rounded-tl rounded-bl flex items-center p-1 bg-black/5 active:bg-black/10 transition-colors"
            onclick={down}
        >
            <Icon icon="icon-[prime--sort-up-fill]" class="rotate-180"/>
        </button>
        
        <div class="border-y border-black-light font-bold min-w-8 text-center">{props.value}</div>
        
        <button
            class="border border-black-light rounded-tr rounded-br flex items-center p-1 bg-black/5 active:bg-black/10 transition-colors"
            onclick={up}
        >
            <Icon icon="icon-[prime--sort-up-fill]"/>
        </button>
    </div>
}