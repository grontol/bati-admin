import { InputError } from "@tahfeedz/fe-core/components/input/InputError.jsx"
import { InputLabel } from "@tahfeedz/fe-core/components/input/InputLabel.jsx"
import { validationContext } from "@tahfeedz/fe-core/components/validation/Validation.jsx"
import { createField } from "@tahfeedz/fe-core/components/validation/field.js"
import { requiredValidator } from "@tahfeedz/fe-core/components/validation/validator.js"
import { foreach } from "@pang/core.js"
import { onDestroy, onMount } from "@pang/lifecycle.js"
import { derived, state } from "@pang/reactive.js"
import { twMerge } from "tailwind-merge"
import { OrderableView } from "@tahfeedz/fe-core/components/OrderableView.jsx"

let idCounter = 0
let groupCounter = 0

export type OptionItem<T = string> = {
    text: string
    value: T
}

type Option<T> = T | OptionItem<T>

type Props<T> = {
    options: readonly Option<T>[]
    value: T[]
    label?: string
    inline?: boolean
    inlineOptions?: boolean
    onChange?: (v: T[]) => void
    onSorted?: (from: number, to: number) => void
    required?: boolean
    disabled?: boolean
    readonly?: boolean
    placeholder?: string
    searchable?: boolean
    clearable?: boolean
    insertable?: boolean
    orderable?: boolean
    class?: string
    optionClass?: string
}

export function CheckInput<T extends string | number = string>(props: Props<T>) {
    let el: HTMLDivElement

    const group = groupCounter++
    const validation = validationContext.get()
    
    const inline = derived(() => props.inline ?? false)
    const inlineOptions = derived(() => props.inlineOptions ?? false)
    const required = derived(() => props.required ?? false)
    const disabled = derived(() => props.disabled ?? false)
    const readonly = derived(() => props.readonly ?? false)
    const orderable = derived(() => props.orderable ?? false)
    
    const field = validation ? createField(
        derived(() => props.value),
        derived(() => required.value ? [requiredValidator(false)] : []),
        () => {
            el.focus()
        }
    ) : null
    
    const isError = derived(() => (field?.errors?.value?.length ?? 0) > 0)
    const errMsg = derived(() => (field?.errors?.value?.length ?? 0) > 0 ? field!.errors.value[0] : null)
    
    function changeHandler(opt: Option<T>) {
        const v = getValueOf(opt)
        const newValue = [...props.value]
        
        if (newValue.includes(v)) {
            newValue.splice(newValue.indexOf(v), 1)
        }
        else {
            newValue.push(v)
        }
        
        props.onChange?.(newValue)
    }
    
    onMount(() => {
        if (field) {
            validation?.addField(field)
        }
    })
    
    onDestroy(() => {
        if (field) {
            validation?.removeField(field)
        }
    })
    
    return (
        <div
            class={twMerge(
                "flex flex-col relative",
                inline.value ? "flex-row items-center gap-2" : "",
                props.class,
            )}
        >
            {props.label !== undefined && (
                <InputLabel
                    class={twMerge(
                        inline.value ? "mb-0" : "",
                    )}
                    label={props.label}
                    required={props.required}
                />
            )}
            
            <div
                ref={r => el = r}
                class={twMerge(
                    "flex border border-transparent transition-colors rounded relative",
                    inlineOptions.value ? "gap-4" : "flex-col",
                    isError.value ? "border-red-500" : "",
                    props.optionClass,
                )}
            >
                {orderable.value ? (
                    <OrderableView
                        items={props.options}
                        onSorted={props.onSorted}
                        render={opt => (
                            <div class="flex items-center gap-2 cursor-pointer">
                                <input
                                    class="cursor-pointer"
                                    type="checkbox"
                                    id={`checkinput-${idCounter}`}
                                    name={`checkinput-group-${group}`}
                                    checked={props.value.includes(getValueOf(opt))}
                                    onchange={() => changeHandler(opt)}
                                    value={String(getValueOf(opt))}
                                    disabled={disabled.value}
                                />
                                <label class="flex-1 cursor-pointer" for={`checkinput-${idCounter++}`}>{getTextOf(opt)}</label>
                            </div>
                        )}
                    />
                ) : foreach(props.options, opt => <div class="flex items-center gap-2 cursor-pointer">
                    <input
                        class="cursor-pointer"
                        type="checkbox"
                        id={`checkinput-${idCounter}`}
                        name={`checkinput-group-${group}`}
                        checked={props.value.includes(getValueOf(opt))}
                        onchange={() => changeHandler(opt)}
                        value={String(getValueOf(opt))}
                        disabled={disabled.value}
                    />
                    <label class="flex-1 cursor-pointer" for={`checkinput-${idCounter++}`}>{getTextOf(opt)}</label>
                </div>)}
            </div>
                        
            {errMsg.value && (
                <InputError
                    class="mt-1"
                    message={errMsg.value}
                />
            )}
        </div>
    )
}

function getValueOf<T>(option: Option<T>): T {
    if (isOptionItem(option)) {
        return option.value
    }
    else {
        return option
    }
}

function getTextOf<T extends string | number>(option: Option<T>): string {
    if (isOptionItem(option)) {
        return option.text
    }
    else {
        return option.toString()
    }
}

function isOptionItem<T>(item: Option<T>): item is OptionItem<T> {
    return typeof item === "object" && item && "text" in item && "value" in item
}