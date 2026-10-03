import { InputError } from "@tahfeedz/fe-core/components/input/InputError.jsx"
import { InputLabel } from "@tahfeedz/fe-core/components/input/InputLabel.jsx"
import { createField } from "@tahfeedz/fe-core/components/validation/field.js"
import { validationContext } from "@tahfeedz/fe-core/components/validation/Validation.jsx"
import { requiredValidator, Validator } from "@tahfeedz/fe-core/components/validation/validator.js"
import { derived, onDestroy, onMount } from "@pang"
import { twMerge } from "tailwind-merge"
import Quill from "quill";
import "quill/dist/quill.core.css";
import "quill/dist/quill.snow.css";

type Props = {
    type?: "text" | "number"
    value?: any
    onChange?: (v: any) => void
    label?: string
    
    required?: boolean
    disabled?: boolean
    readonly?: boolean
    autofocus?: boolean
    
    validators?: Validator[],
    placeholder?: string
    class?: string
}

export function RichTextInput(props: Props) {
    let input: HTMLInputElement
    let editorEl: HTMLDivElement
    let quill: Quill
    
    const validation = validationContext.get()
    
    const required = derived(() => props.required ?? false)
    const disabled = derived(() => props.disabled ?? false)
    const readonly = derived(() => props.readonly ?? false)
    const autofocus = derived(() => props.autofocus ?? false)
    
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
    
    onMount(() => {
        if (autofocus.value) {
            setTimeout(() => {
                input.focus()
            })
        }
        
        if (field) {
            validation?.addField(field)
        }
        
        quill = new Quill(editorEl, {
            theme: "snow",
            readOnly: props.readonly ?? false,
            modules: {
                toolbar: [
                    [{ header: [1, 2, false] }],
                    ['bold', 'italic', 'underline'],
                    ['image', 'code-block'],
                ]
            },
        })
        
        if (props.value) {
            quill.setContents(props.value)
        }
        
        quill.on('text-change', function(delta, oldDelta, source) {
            if (source === 'user') {
                props.onChange?.(quill.getContents())
            }
        });
    })
    
    onDestroy(() => {
        if (field) {
            validation?.removeField(field)
        }
    })
    
    return <div
        class={twMerge(
            "flex flex-col",
            props.class,
        )}
    >
        {props.label !== undefined && (
            <InputLabel
                label={props.label}
                required={props.required}
            />
        )}
        
        <div
            ref={v => editorEl = v}
            class={twMerge(
                "flex bg-white/80 border border-black-extra-light transition-colors rounded",
                isError.value ? "border-red-500" : "",
                readonly.value ? "bg-white/10" : "",
                disabled.value ? "bg-gray-400/10" : "",
            )}
        >
            <input
                ref={v => input = v}
                class="outline-none flex-1 px-3 py-1.5 [appearance:textfield] [&::-webkit-outer-spin-button]:appearance-none [&::-webkit-inner-spin-button]:appearance-none"
                type={props.type ?? "text"}
                value={props.value}
                oninput={props.onChange}
                disabled={disabled.value}
                readonly={readonly.value}
                placeholder={props.placeholder}
            />
        </div>
        
        {errMsg.value && (
            <InputError
                class="mt-1"
                message={errMsg.value}
            />
        )}
    </div>
}

export function RichTextView(props: { data: any }) {
    let el: HTMLDivElement
    
    onMount(() => {
        const quill = new Quill(el, {
            theme: "snow",
            readOnly: true,
            modules: {
                toolbar: []
            },
        })
        
        if (props.data) {
            quill.setContents(props.data)
        }
    })
    
    return <div ref={v => el = v}/>
}