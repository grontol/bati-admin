import { derived, onDestroy, onMount, stop } from "@pang"
import { foreach } from "@pang/core.js"
import { Icon, IconButton } from "@tahfeedz/fe-core/components/Icon.jsx"
import { InputError } from "@tahfeedz/fe-core/components/input/InputError.jsx"
import { InputLabel } from "@tahfeedz/fe-core/components/input/InputLabel.jsx"
import { createField } from "@tahfeedz/fe-core/components/validation/field.js"
import { validationContext } from "@tahfeedz/fe-core/components/validation/Validation.jsx"
import { requiredValidator, Validator } from "@tahfeedz/fe-core/components/validation/validator.js"
import { imageUrlOf } from "@tahfeedz/fe-core/data/api.js"
import { twMerge } from "tailwind-merge"

type Props = {
    values: string[]
    onChange?: (v: string[]) => void
    label?: JSX.Element
    
    required?: boolean
    disabled?: boolean
    readonly?: boolean
    allowMultiple?: boolean
    
    validators?: Validator[],
    class?: string
}

export function ImageInput(props: Props) {
    let container: HTMLDivElement
    let input: HTMLInputElement
    
    const validation = validationContext.get()
        
    const required = derived(() => props.required ?? false)
    const disabled = derived(() => props.disabled ?? false)
    const readonly = derived(() => props.readonly ?? false)
    const allowMultiple = derived(() => props.allowMultiple ?? false)
    
    const field = validation ? createField(
        derived(() => props.values),
        derived(() => [
            ...(required.value ? [requiredValidator()] : []),
            ...(props.validators ?? [])
        ]),
        () => {
            container.scrollIntoView()
        }
    ) : null
    
    const isError = derived(() => (field?.errors?.value?.length ?? 0) > 0)
    const errMsg = derived(() => (field?.errors?.value?.length ?? 0) > 0 ? field!.errors.value[0] : null)
    
    function click() {
        input.click()
    }
    
    function fileChanged(e: Event) {
        const files: FileList = (e.target as any).files
        
        if (props.allowMultiple) {
            const newValues = [...props.values]
            
            for (const f of files) {
                newValues.push(URL.createObjectURL(f))
            }
            
            props.onChange?.(newValues)
        }
        else {
            if (files.length > 0) {
                props.onChange?.([URL.createObjectURL(files[0])])
            }
        }
    }
    
    function openImage(img: string) {
        window.open(img, '_blank')
    }
    
    function deleteImage(index: number) {
        const newValues = [...props.values]
        const deleteds = newValues.splice(index, 1)
        
        for (const d of deleteds) {
            if (d.startsWith("blob:")) {
                URL.revokeObjectURL(d)
            }
        }
        
        props.onChange?.(newValues)
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
    
    return <div
        ref={v => container = v}
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
        
        <input
            ref={v => input = v}
            type="file"
            class="hidden"
            onchange={fileChanged}
            multiple="true"
            accept="image/png, image/jpeg"
        />
        
        <div
            class={twMerge(
                "flex flex-col bg-white/80 border border-black-extra-light transition-colors rounded items-center p-4 cursor-pointer",
                isError.value && "border-red-500",
                readonly.value && "bg-white/10",
                disabled.value && "bg-gray-400/10",
            )}
            onclick={click}
        >
            <div class="flex flex-wrap gap-1 items-center justify-center">
                {foreach(props.values, (img, i) => (
                    <div class="relative group">
                        <img
                            class="aspect-square w-24 object-cover rounded-lg"
                            src={imageUrlOf(img)}
                            onclick={stop(() => openImage(imageUrlOf(img)))}
                        />
                        
                        <IconButton
                            class="absolute right-1.5 top-1.5 text-white bg-red-400 hover:bg-red-500 p-1 text-xl opacity-0 group-hover:opacity-100"
                            icon="icon-[material-symbols--delete]"
                            onclick={stop(() => deleteImage(i))}
                        />
                    </div>
                ))}
            
                <div class="flex flex-col items-center">
                    {props.values.length === 0 ? <>
                        <span
                            class={twMerge(
                                "icon-[ic--round-image] text-gray-300",
                                props.values.length > 0 ? "text-3xl mt-4" :  "text-7xl"
                            )}
                        />
                            
                        <span class="text-gray-400">Click atau drop di sini</span>
                    </> : allowMultiple.value ? <>
                        <Icon
                            icon="icon-[mdi--image-add]"
                            class="text-gray-300 text-6xl ml-4"
                        />
                    </> : null}
                </div>
            </div>
        </div>
        
        {errMsg.value && (
            <InputError
                class="mt-1"
                message={errMsg.value}
            />
        )}
    </div>
}