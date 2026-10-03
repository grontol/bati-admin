import { state } from "@pang"
import { Icon } from "@tahfeedz/fe-core/components/Icon.jsx"

const loadingCounter = state(0)
const softLoadingCounter = state(0)

export function Loading() {
    return <>
        {loadingCounter.value > 0 && (
            <div class="fixed bg-black/50 inset-0 z-100 flex items-center justify-center">
                <img src="/images/loading.gif" class="w-24"/>
            </div>
        )}
        
        {softLoadingCounter.value > 0 && (
            <div class="absolute top-15 left-0 right-0 z-100 flex justify-center pointer-events-none">
                <div class="bg-black/20 rounded-full w-9 h-9 flex items-center justify-center">
                    <Icon
                        icon="icon-[eos-icons--bubble-loading]"
                        class="text-white text-2xl"
                    />
                </div>
            </div>
        )}
    </>
}

export function showLoading() {
    loadingCounter.value++
}

export function hideLoading() {
    loadingCounter.value--
}

export function showSoftLoading() {
    softLoadingCounter.value++
}

export function hideSoftLoading() {
    if (softLoadingCounter.value > 0)
        softLoadingCounter.value--
}