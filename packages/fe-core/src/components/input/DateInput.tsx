import { derived, effect, onDestroy, onMount, state } from "@pang"
import { InputError } from "@tahfeedz/fe-core/components/input/InputError.jsx"
import { InputLabel } from "@tahfeedz/fe-core/components/input/InputLabel.jsx"
import { createField } from "@tahfeedz/fe-core/components/validation/field.js"
import { validationContext } from "@tahfeedz/fe-core/components/validation/Validation.jsx"
import { requiredValidator } from "@tahfeedz/fe-core/components/validation/validator.js"
import { twMerge } from "tailwind-merge"
import { Datepicker } from "vanillajs-datepicker"

import "vanillajs-datepicker/css/datepicker.min.css"

type Props = {
    style?: "default" | "material" | "none"
    value?: Date | null
    onChange?: (v: Date) => void
    label?: string
    
    required?: boolean
    disabled?: boolean
    readonly?: boolean
    autofocus?: boolean
    
    placeholder?: string
    class?: string
    inputContainerClass?: string
    inputClass?: string
    
    startIcon?: JSX.Element
    endIcon?: JSX.Element
    
    transition?: TransitionRunner
}

const FORMAT = "dd/mm/yyyy"

export function DateInput(props: Props) {
    let input: HTMLInputElement
    let datePicker: Datepicker | null = null
    
    const validation = validationContext.get()
    
    const required = derived(() => props.required ?? false)
    const disabled = derived(() => props.disabled ?? false)
    const readonly = derived(() => props.readonly ?? false)
    const autofocus = derived(() => props.autofocus ?? false)
    
    const field = validation ? createField(
        derived(() => props.value),
        derived(() => required.value ? [requiredValidator()] : []),
        () => {
            input.focus()
        }
    ) : null
    
    const isError = derived(() => (field?.errors?.value?.length ?? 0) > 0)
    const errMsg = derived(() => (field?.errors?.value?.length ?? 0) > 0 ? field!.errors.value[0] : null)
    
    const isFocused = state(false)
    
    function dateChanged() {
        props.onChange?.(datePicker!.getDate() as Date)
    }
    
    effect(() => {
        if (props.value) {
            datePicker?.setDate(props.value)
        }
        else {
            datePicker?.setDate(null)
        }
    })
    
    onMount(() => {
        if (autofocus.value) {
            setTimeout(() => {
                input.focus()
            })
        }
        
        if (field) {
            validation?.addField(field)
        }
        
        datePicker = new Datepicker(input, {
            format: FORMAT,
            autohide: true,
        })
        
        if (props.value) {
            datePicker.setDate(props.value)
        }
        
        input.addEventListener("changeDate", dateChanged)
    })
    
    onDestroy(() => {
        if (field) {
            validation?.removeField(field)
        }
        
        input.removeEventListener("changeDate", dateChanged)
    })
    
    return <div
        class={twMerge(
            "flex flex-col relative",
            props.class,
        )}
        transition={props.transition}
    >
        {props.label !== undefined && <>
            {props.style === "material" ? <>
                <div class="h-5"/>
            
                <InputLabel
                    label={props.label}
                    required={props.required && (isFocused.value || !!props.value)}
                    class={twMerge(
                        "absolute transition-all pointer-events-none select-none",
                        isFocused.value || props.value ? "top-0 left-0" : "top-6 left-0 text-black-light text-base",
                        !isFocused.value && !props.value && props.startIcon && "left-8",
                    )}
                />
            </> : (
                <InputLabel
                    label={props.label}
                    required={props.required}
                />
            )}
        </>}
        
        <div class="flex items-center" onclick={() => input.focus()}>
            {props.startIcon && (props.startIcon)}
            
            <div
                class={twMerge(
                    "flex-1 border-black-extra-light focus-within:border-primary",
                    props.style === "material"
                        ? "flex items-center border-b transition-colors"
                    : props.style === "none"
                        ? "flex items-center"
                        : "flex items-center bg-white/80 border transition-colors rounded",
                    isError.value ? "border-red-500 focus-within:border-red-500" : "",
                    readonly.value ? "bg-white/10" : "",
                    disabled.value ? "bg-gray-400/10" : "",
                    props.inputContainerClass,
                )}
            >
                <input
                    ref={v => input = v}
                    class={twMerge(
                        "outline-none flex-1 px-3 py-1.5 [appearance:textfield] [&::-webkit-outer-spin-button]:appearance-none [&::-webkit-inner-spin-button]:appearance-none",
                        props.style === "material" && "px-0",
                        props.inputClass,
                    )}
                    type="text"
                    disabled={disabled.value}
                    readonly={readonly.value}
                    placeholder={props.placeholder}
                    onfocus={() => isFocused.value = true}
                    onfocusout={() => isFocused.value = false}
                />
            </div>
            
            {props.endIcon && (props.endIcon)}
        </div>
        
        {errMsg.value && (
            <InputError
                class="mt-1"
                message={errMsg.value}
            />
        )}
    </div>
}