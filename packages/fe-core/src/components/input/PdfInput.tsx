import { effect, state } from "@pang"
import { Icon, IconButton } from "@tahfeedz/fe-core/components/Icon.jsx"
import { InputLabel } from "@tahfeedz/fe-core/components/input/InputLabel.jsx"
import { uploadUrlOf } from "@tahfeedz/fe-core/data/api.js"
import { fileToBase64 } from "@tahfeedz/fe-core/utils/file.js"
import { twMerge } from "tailwind-merge"

let count = 0

export function PdfInput(props: {
    label: string
    urlValue?: string | null
    onChange?: (file: string | null) => void
    class?: string
}) {
    const id = `pdf-input-${count++}`
    
    const file = state<File | null>(null)
    const fileName = state<string | null>(null)
    
    effect(() => {
        if (props.urlValue) {
            fileName.value = props.urlValue
        }
    })
    
    async function handleChange(e: Event) {
        const files: FileList = (e.target as any).files
        if (files.length === 0) return
        
        file.value = files[0]        
        fileName.value = file.value.name
        props.onChange?.(await fileToBase64(file.value))
    }
    
    function view() {
        if (file.value) {        
            window.open(URL.createObjectURL(file.value), "_blank")
        }
        else if (props.urlValue) {
            window.open(uploadUrlOf(props.urlValue), "_blank")
        }
    }
    
    function remove() {
        file.value = null
        fileName.value = null
        props.onChange?.(null)
    }
    
    return <div
        class={twMerge(
            "flex flex-col",
            props.class,
        )}
    >
        <InputLabel
            label={props.label}
        />
        
        <label for={id}>
            <div
                class={twMerge(
                    "flex items-center gap-2 border border-black-extra-light rounded px-3 py-1.5 cursor-pointer",
                    fileName.value ? "bg-primary/10" : "bg-white",
                )}
            >
                <Icon
                    icon="icon-[bi--file-earmark-pdf-fill]"
                    class={twMerge(
                        "text-lg",
                        fileName.value ? "text-red-400" : "text-black-light"
                    )}
                />
                
                {fileName.value ? <>
                    <span class="flex-1">{fileName.value}</span>
                    
                    <IconButton
                        icon="icon-[mdi--eye]"
                        class="p-1 -m-1 text-primary"
                        onclick={view}
                    />
                    
                    <IconButton
                        icon="icon-[mdi--trash]"
                        class="p-1 -m-1 -mr-2 text-pink"
                        onclick={remove}
                    />
                </> : (
                    <span class="text-black-light flex-1">Pilih File Pdf</span>
                )}
            </div>
        </label>
        
        <input
            id={id}
            type="file"
            class="hidden"
            accept="application/pdf"
            onchange={handleChange}
        />
    </div>
}