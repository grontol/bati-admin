import { derived, onDestroy, onMount, state, stop } from "@pang"
import { Button } from "@tahfeedz/fe-core/components/Button.jsx"
import { InputError } from "@tahfeedz/fe-core/components/input/InputError.jsx"
import { InputLabel } from "@tahfeedz/fe-core/components/input/InputLabel.jsx"
import { createField } from "@tahfeedz/fe-core/components/validation/field.js"
import { validationContext } from "@tahfeedz/fe-core/components/validation/Validation.jsx"
import { requiredValidator, Validator } from "@tahfeedz/fe-core/components/validation/validator.js"
import { twMerge } from "tailwind-merge"

type Props = {
    id?: string
    type?: "text" | "number" | "password" | "email" | "date"
    style?: "default" | "material" | "none"
    value?: string
    onChange?: (v: string) => void
    label?: JSX.Element
    multiline?: boolean
    rows?: number
    size?: "md" | "sm"
    
    required?: boolean
    disabled?: boolean
    readonly?: boolean
    autofocus?: boolean
    clearable?: boolean
    
    validators?: Validator[],
    placeholder?: string
    class?: string
    inputContainerClass?: string
    inputClass?: string
    
    startIcon?: JSX.Element
    endIcon?: JSX.Element
    unit?: string
    
    transition?: TransitionRunner
    
    onblur?: ((this: GlobalEventHandlers, ev: FocusEvent) => any) | null
    onkeydown?: ((this: GlobalEventHandlers, ev: KeyboardEvent) => any) | null
}

export function TextInput(props: Props) {
    let input: HTMLInputElement | HTMLTextAreaElement
    
    const validation = validationContext.get()
    
    const multiline = derived(() => props.multiline ?? false)
    const required = derived(() => props.required ?? false)
    const disabled = derived(() => props.disabled ?? false)
    const readonly = derived(() => props.readonly ?? false)
    const autofocus = derived(() => props.autofocus ?? false)
    const clearable = derived(() => props.clearable ?? false)
    const size = derived(() => props.size ?? "default")
    
    const field = validation ? createField(
        derived(() => props.value),
        derived(() => [
            ...(required.value ? [requiredValidator()] : []),
            ...(props.validators ?? [])
        ]),
        () => {
            input.focus()
        }
    ) : null
    
    const isError = derived(() => (field?.errors?.value?.length ?? 0) > 0)
    const errMsg = derived(() => (field?.errors?.value?.length ?? 0) > 0 ? field!.errors.value[0] : null)
    
    const isFocused = state(false)
    
    onMount(() => {
        if (autofocus.value) {
            setTimeout(() => {
                input.focus()
            })
        }
        
        if (field) {
            validation?.addField(field)
        }
    })
    
    onDestroy(() => {
        if (field) {
            validation?.removeField(field)
        }
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
                    for={props.id}
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
                    for={props.id}
                    label={props.label}
                    required={props.required}
                />
            )}
        </>}
        
        <div class="flex items-center">
            {props.startIcon && (props.startIcon)}
            
            <div
                class={twMerge(
                    "flex-1 border-black-extra-light focus-within:border-primary relative",
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
                {multiline.value ? (
                    <textarea
                        id={props.id}
                        ref={v => input = v}
                        class={twMerge(
                            "outline-none flex-1 px-3 py-1.5 [appearance:textfield] [&::-webkit-outer-spin-button]:appearance-none [&::-webkit-inner-spin-button]:appearance-none",
                            props.style === "material" && "px-0",
                            props.inputClass,
                        )}
                        type={props.type ?? "text"}
                        value={props.value}
                        oninput={props.onChange}
                        disabled={disabled.value}
                        readonly={readonly.value}
                        placeholder={props.placeholder}
                        rows={props.rows !== undefined ? props.rows.toString() : undefined}
                        onfocus={() => isFocused.value = true}
                        onfocusout={() => isFocused.value = false}
                        onblur={props.onblur}
                        onkeydown={props.onkeydown}
                    />
                ) : (
                    <input
                        id={props.id}
                        ref={v => input = v}
                        class={twMerge(
                            "outline-none flex-1 px-3 py-1.5 [appearance:textfield] [&::-webkit-outer-spin-button]:appearance-none [&::-webkit-inner-spin-button]:appearance-none",
                            props.style === "material" && "px-0",
                            props.inputClass,
                        )}
                        type={props.type ?? "text"}
                        value={props.value}
                        oninput={props.onChange}
                        disabled={disabled.value}
                        readonly={readonly.value}
                        placeholder={props.placeholder}
                        onfocus={() => isFocused.value = true}
                        onfocusout={() => isFocused.value = false}
                        onblur={props.onblur}
                        onkeydown={props.onkeydown}
                    />
                )}
                
                {clearable.value && !readonly.value && !disabled.value && props.value && (
                    <Button
                        class="absolute right-0 top-1 px-1"
                        color="neutral"
                        style="none"
                        onclick={stop(() => props.onChange?.(""))}
                    >
                        <span class="icon-[mdi--close] text-black-extra-light hover:text-black-light text-lg"/>
                    </Button>
                )}
                
                {props.unit && (
                    <span class="text-xs text-black-light mr-2 pointer-events-none">{props.unit}</span>
                )}
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