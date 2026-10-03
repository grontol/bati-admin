import { derived, effect, fade, onDestroy, onMount, self, state, stop } from "@pang"
import { scale, slide } from "@pang/transition.js"
import { addPopStateListener, historyPopWithoutEffect, historyPush, PopStateEvent, removePopStateListener } from "@tahfeedz/fe-core/lib/utils/history.js"
import { twMerge } from "tailwind-merge"

export function MiddlePopup(props: {
    visible: boolean
    onClose?: () => void
    children?: JSX.Element
    cardClass?: string
    dissmissOnClickOutside?: boolean
}) {
    return <PopupInternal
        position="middle"
        visible={props.visible}
        onClose={props.onClose}
        cardClass={props.cardClass}
        dissmissOnClickOutside={props.dissmissOnClickOutside}
    >{props.children}</PopupInternal>
}

export function BottomPopup(props: {
    visible: boolean
    onClose?: () => void
    children?: JSX.Element
    cardClass?: string
    contentClass?: string
    dissmissOnClickOutside?: boolean
    handleEnabled?: boolean
    normalHeight?: string
    defaultHeight?: "normal" | "maximum" | "minimum"
}) {
    return <PopupInternal
        position="bottom"
        visible={props.visible}
        onClose={props.onClose}
        cardClass={props.cardClass}
        contentClass={props.contentClass}
        dissmissOnClickOutside={props.dissmissOnClickOutside}
        handleEnabled={props.handleEnabled}
        normalHeight={props.normalHeight}
        defaultHeight={props.defaultHeight}
    >{props.children}</PopupInternal>
}

function PopupInternal(props: {
    position: "bottom" | "middle"
    visible: boolean
    onClose?: () => void
    children?: JSX.Element
    cardClass?: string
    contentClass?: string
    dissmissOnClickOutside?: boolean
    handleEnabled?: boolean
    normalHeight?: string
    defaultHeight?: "normal" | "maximum" | "minimum"
}) {    
    effect(() => {
        if (props.visible) {
            historyPush("MiddlePopup")
        }
    })
    
    function close() {
        if (props.dissmissOnClickOutside ?? true) {
            historyPopWithoutEffect()
            props.onClose?.()
        }
    }
    
    function onPop(e: PopStateEvent) {
        if (props.visible) {
            e.stopPropagation()
            props.onClose?.()
        }
    }
    
    onMount(() => {
        addPopStateListener(onPop)
    })
    
    onDestroy(() => {
        removePopStateListener(onPop)
    })
    
    // Not reactive
    return props.position === "middle" ? <>
        {props.visible && (
            <pang:el id="app-root">
                <div
                    class="absolute inset-0 bg-black/60 z-10 flex flex-col justify-center"
                    onclick={stop(self(close))}
                    transition={fade()}
                >
                    <div
                        class={twMerge(
                            "bg-white rounded-2xl p-4 relative flex flex-col overflow-auto mx-4 max-h-[85%]",
                            props.cardClass,
                        )}
                        transition={scale()} 
                    >                    
                        {props.children}
                    </div>
                </div>
            </pang:el>
        )}
    </> : <>
        {props.visible && (
            <BottomPopupImpl
                onClose={props.onClose}
                cardClass={props.cardClass}
                contentClass={props.contentClass}
                handleEnabled={props.handleEnabled}
                children={props.children}
                normalHeight={props.normalHeight}
                defaultHeight={props.defaultHeight}
            />
        )}
    </>
}

function BottomPopupImpl(props: {
    onClose?: () => void
    cardClass?: string
    contentClass?: string
    handleEnabled?: boolean
    normalHeight?: string
    children?: JSX.Element
    defaultHeight?: "normal" | "maximum" | "minimum"
}) {
    let popupEl: HTMLDivElement
    let contentEl: HTMLDivElement // Tambahkan ref untuk memantau scroll konten anak
    
    const isDragging = state(false)
    const startY = state(0)
    const startHeight = state(0)
    
    const lastY = state(0)
    const lastTime = state(0)
    const velocity = state(0)
    
    const heightState = state<"normal" | "maximum" | "minimum">(props.defaultHeight ?? "normal")
    const currentHeight = state<number | null>(null)
    
    const normalHeight = derived(() => props.handleEnabled ? (props.normalHeight ?? "60%") : "auto")
    
    let isScrollable = false
    
    function getScreenY(e: MouseEvent | TouchEvent): number {
        if ("touches" in e && e.touches.length > 0) {
            return e.touches[0].screenY
        }
        if ("changedTouches" in e && e.changedTouches.length > 0) {
            return e.changedTouches[0].screenY
        }
        return (e as MouseEvent).screenY
    }
    
    // Pindahkan logic down ke seluruh area popup
    function onPopupDown(e: MouseEvent | TouchEvent) {
        if (!props.handleEnabled) return
        
        // Jika target klik adalah komponen interaktif (tombol/input), jangan ganggu
        // const target = e.target as HTMLElement
        // if (target.closest("input, textarea, select, a")) return

        isScrollable = contentEl.scrollHeight > contentEl.clientHeight
        
        const screenY = getScreenY(e)
        
        isDragging.value = true
        startY.value = screenY
        lastY.value = screenY
        lastTime.value = performance.now()
        startHeight.value = popupEl.offsetHeight
        velocity.value = 0
        
        // Jangan default preventElemen di sini agar scroll konten asli bawaan browser tetap jalan jika dibutuhkan
    }
    
    function onHandleMove(e: MouseEvent | TouchEvent) {
        if (!isDragging.value) return
            
        const screenY = getScreenY(e)
        const deltaY = screenY - startY.value // Positif artinya ditarik ke bawah, Negatif ke atas
        
        // --- KUNCI UTAMA MOBILE SMART SWIPE ---
        if (contentEl && isScrollable) {
            const isAtTop = contentEl.scrollTop === 0
            
            // Jika konten bisa di-scroll dan user narik ke ATAS (mau nge-scroll ke bawah), batalkan drag popup
            if (deltaY < 0 && heightState.value === "maximum") {
                isDragging.value = false
                return
            }
            // Jika user narik ke bawah tapi posisi scroll konten belum mentok atas, biarkan konten nge-scroll dulu
            if (deltaY > 0 && !isAtTop) {
                // Update startY secara real-time mengikuti cursor agar pas mentok atas tidak ada lonjakan (jank)
                startY.value = screenY
                startHeight.value = popupEl.offsetHeight
                return
            }
        }
        
        // Jika lolos seleksi scroll di atas, jalankan kalkulasi perpindahan tinggi seperti biasa
        const now = performance.now()
        const deltaT = now - lastTime.value
        
        if (deltaT > 0) {
            const currentVelocity = (screenY - lastY.value) / deltaT
            velocity.value = currentVelocity
        }
        
        lastY.value = screenY
        lastTime.value = now
        
        const newHeight = startHeight.value - deltaY
        const windowHeight = window.innerHeight
        
        currentHeight.value = Math.round(Math.max(100, Math.min(newHeight, windowHeight * 0.95)))
        
        // Cegah browser melakukan bouncing/overscroll bawaan sistem saat area popup diseret
        if (e.cancelable) e.preventDefault()
    }
    
    function onHandleUp(e: MouseEvent | TouchEvent) {
        if (!isDragging.value) return
        
        const windowHeight = window.innerHeight
        const inertiaFactor = 150 
        const projectedDeltaY = velocity.value * inertiaFactor
        
        const currentH = currentHeight.value ?? popupEl.offsetHeight
        const projectedHeight = currentH - projectedDeltaY
        const finalHeightRatio = projectedHeight / windowHeight
        
        if (finalHeightRatio > 0.70) {
            heightState.value = "maximum"
        }
        else if (finalHeightRatio < 0.35) {
            heightState.value = "minimum"
            if (props.onClose) props.onClose()
        }
        else {
            heightState.value = "normal"
        }

        currentHeight.value = null
        
        setTimeout(() => {
            isDragging.value = false
        }, 0)
    }
    
    function onBackdropClick(e: MouseEvent) {
        if (isDragging.value) return
        if (props.onClose) props.onClose()
    }
    
    const heightProps = derived<{ style: string, class: string }>(() => {
        if (currentHeight.value !== null) {
            return { style: `height: ${currentHeight.value}px; max-height: 95%;`, class: "" }
        }
        
        if (heightState.value === "normal") {
            return { class: "max-h-[85%]", style: `height: ${normalHeight.value}` }
        }
        else if (heightState.value === "maximum") {
            return { style: "", class: "h-[calc(100%_-_45px)]" }
        }
        else {
            return { style: "", class: "h-[15%]" }
        }
    })
    
    onMount(() => {
        window.addEventListener("mousemove", onHandleMove)
        window.addEventListener("mouseup", onHandleUp)
        
        window.addEventListener("touchmove", onHandleMove, { passive: false })
        window.addEventListener("touchend", onHandleUp)
        window.addEventListener("touchcancel", onHandleUp)
    })
    
    onDestroy(() => {
        window.removeEventListener("mousemove", onHandleMove)
        window.removeEventListener("mouseup", onHandleUp)
        
        window.removeEventListener("touchmove", onHandleMove)
        window.removeEventListener("touchend", onHandleUp)
        window.removeEventListener("touchcancel", onHandleUp)
    })
    
    return <div
        class="absolute inset-0 bg-black/60 z-10 flex flex-col justify-end"
        onclick={self(onBackdropClick)}
        transition={fade()}
    >
        <div
            ref={v => popupEl = v}
            class={twMerge(
                "bg-white rounded-t-2xl relative flex flex-col overflow-auto cubic-bezier(0.25, 1, 0.5, 1)",
                currentHeight.value !== null ? "transition-none" : "transition-all duration-75",
                isDragging.value ? "transition-none" : "transition-all",
                props.cardClass,
                heightProps.value.class,
            )}
            onclick={e => e.stopPropagation()}
            onmousedown={onPopupDown} // Pasang listener down di seluruh container popup
            ontouchstart={onPopupDown} // Pasang listener touchstart di seluruh container popup
            transition={slide()}
            style={heightProps.value.style}
        >
            {props.handleEnabled && (
                <div class="flex items-center justify-center py-4 -mb-4 cursor-pointer touch-none">
                    <div class="w-12 h-1 bg-black-extra-light/60 rounded-full"/>
                </div>
            )}
            
            {/* Berikan ref ke pembungkus children yang memiliki overflow scroll */}
            <div
                ref={v => contentEl = v}
                class={twMerge(
                    "flex-1 overflow-y-auto flex flex-col w-full p-4",
                    props.contentClass,
                )}
            >
                {props.children}
            </div>
        </div>
    </div>
}