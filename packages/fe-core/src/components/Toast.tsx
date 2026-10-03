import { Icon } from "@tahfeedz/fe-core/components/Icon.jsx"
import { derived, fade, state } from "@pang"
import { foreach } from "@pang/core.js"
import { twMerge } from "tailwind-merge"

type ToastType = "success" | "warning" | "danger"

type ToastData = {
    index: number,
    message: string,
    type: ToastType
}

let index = 0
const toastItems = state<ToastData[]>([])

export function removeToast(index: number) {
    const datas = [...toastItems.value]
    const arIndex = datas.findIndex(x => x.index === index)
    
    if (arIndex >= 0) {
        datas.splice(arIndex, 1)
        toastItems.value = datas
    }
}

export function showToast(message: string, type: ToastType) {
    const idx = index++
    
    const datas = [{
        index: idx,
        message,
        type,
    }, ...toastItems.value]
    
    toastItems.value = datas
    
    setTimeout(() => {
        removeToast(idx)
    }, type === 'success' ? 2000 : type === 'warning' ? 3000 : 5000)
}

export function showToastError(e: any) {
    let message: string
    
    if (e.errorField) {
        message = `Field ${e.errorField} ${e.message}`
    }
    else if (e.message) {
        message = e.message
    }
    else {
        message = String(e)
    }
    
    showToast(message, "danger")
}

export function showToastSuccess(message: string) {
    showToast(message, "success")
}

export function showToastSaveSuccess() {
    showToast("Data berhasil disimpan", "success")
}

export function showToastInsertSuccess() {
    showToast("Data berhasil ditambahkan", "success")
}

export function showToastUpdateSuccess() {
    showToast("Data berhasil diubah", "success")
}

export function showToastDeleteSuccess() {
    showToast("Data berhasil dihapus", "success")
}

export function showToastSaveFailed(message?: string) {
    showToast("Gagal menyimpan data" + (message ? `. ${message}` : ""), "danger")
}

export function showToastInsertFailed(message?: string) {
    showToast("Gagal menambahkan data" + (message ? `. ${message}` : ""), "danger")
}

export function showToastUpdateFailed(message?: string) {
    showToast("Gagal mengubah data" + (message ? `. ${message}` : ""), "danger")
}

export function showToastDeleteFailed(message?: string) {
    showToast("Gagal menghapus data" + (message ? `. ${message}` : ""), "danger")
}

export function Toast(props: { isMobile?: boolean }) {
    const isMobile = derived(() => props.isMobile ?? false)
    
    return <>
        {isMobile.value ? <ToastMobile/> : <ToastDesktop/>}
    </>
}

function ToastMobile() {
    const toast = derived(() => toastItems.value.length > 0 ? toastItems.value[toastItems.value.length - 1] : null)
    
    return <>
        {toast.value && (
            <div class="absolute bottom-20 left-0 right-0 flex flex-col items-center gap-y-2 z-888 select-none">
                <div 
                    class={twMerge("flex items-center text-white px-4 py-1 rounded-full",
                        toast.value.type === "success" ? "bg-[#37a561]" :
                        toast.value.type === "warning" ? "bg-[#97890d]" :
                        "bg-rose-400"
                    )}
                    // transition:fly={{ duration: 250, x: 500, opacity: 1, easing: cubicOut }}
                    transition={fade()}
                >
                    <Icon 
                        icon={ toast.value.type === "success" ? "mdi:check" : toast.value.type === "warning" ? "mdi:warning-outline" : "mdi:error-outline" } 
                        class="text-2xl mr-2"
                    />
                    
                    <span>{toast.value.message}</span>
                </div>
            </div>
        )}
    </>
}

function ToastDesktop() {
    return <>
        {toastItems.value.length > 0 && (
            <div class="fixed right-3 top-3 flex flex-col gap-y-2 items-end z-1000">
                {foreach(toastItems.value, (toast, index) => (
                    <div 
                        class={twMerge("flex items-center text-white px-4 py-4 rounded-lg",
                            toast.type === "success" ? "bg-[#37a561]" :
                            toast.type === "warning" ? "bg-[#97890d]" :
                            "bg-rose-400"
                        )}
                        // transition:fly={{ duration: 250, x: 500, opacity: 1, easing: cubicOut }}
                        // transition={fade()}
                    >
                        <Icon 
                            icon={ toast.type === "success" ? "mdi:check" : toast.type === "warning" ? "mdi:warning-outline" : "mdi:error-outline" } 
                            class="text-2xl mr-2"
                        />
                        
                        <span>{toast.message}</span>
                        <button on:click={() => removeToast(toast.index)}>
                            <Icon icon={ "mdi:close" } class="text-2xl ml-2 hover:text-white/90"/>
                        </button>
                    </div>
                ))}
            </div>
        )}
    </>
}