import { onDestroy, onMount } from "@pang"
import { ElseIf, html, If } from "@pang/core.js"
import { self } from "@pang/event-utils.js"
import { derived, state } from "@pang/reactive.js"
import { fade, scale, slide } from "@pang/transition.js"
import { BenjolButton, Button } from "@tahfeedz/fe-core/components/Button.jsx"
import { addPopStateListener, historyPopWithoutEffect, historyPush, PopStateEvent, removePopStateListener } from "@tahfeedz/fe-core/lib/utils/history.js"
import { twJoin, twMerge } from "tailwind-merge"

type AlertPosition = 'middle' | 'bottom'

type AlertConfig = {
    title?: string
    message: string
    type: 'success' | 'info' | 'question' | 'warning' | 'error'
    position: AlertPosition
    okButton: boolean
    cancelButton: boolean
    okButtonText: string
    cancelButtonText: string
    dismissOnClickOutside: boolean
    onOk?: () => void
    onCancel?: () => void
    onDismiss?: () => void
}

type MakeAlertConfig = Optional<AlertConfig, 'okButton' | 'cancelButton' | 'okButtonText' | 'cancelButtonText' | 'dismissOnClickOutside' | 'position'>

const defConfig: Optional<AlertConfig, 'title' | 'message' | 'type'> = {
    okButton: true,
    cancelButton: true,
    okButtonText: "Iya",
    cancelButtonText: "Batal",
    dismissOnClickOutside: true,
    position: "middle",
}

const alertConfig = state<AlertConfig | null>(null)

export function showAlert(config: MakeAlertConfig) {
    if (config.okButton === undefined) config.okButton = defConfig.okButton
    if (config.cancelButton === undefined) config.cancelButton = defConfig.cancelButton
    if (config.okButtonText === undefined) config.okButtonText = defConfig.okButtonText
    if (config.cancelButtonText === undefined) config.cancelButtonText = defConfig.cancelButtonText
    if (config.dismissOnClickOutside === undefined) config.dismissOnClickOutside = defConfig.dismissOnClickOutside
    if (config.position === undefined) config.position = defConfig.position
    
    alertConfig.value = config as AlertConfig
}

export function showAlertInfo({ title, message, onDismiss }: { title?: string, message: string, onDismiss?: () => void }) {
    showAlert({
        title,
        message,
        type: 'info',
        cancelButton: false,
        onDismiss,
    })
}

export function showAlertWarning({ title, message }: { title?: string, message: string }) {
    showAlert({
        title,
        message,
        type: 'warning',
        cancelButton: false,
    })
}

export function showAlertSuccess({ title, message }: { title?: string, message: string }) {
    showAlert({
        title,
        message,
        type: 'success',
        cancelButton: false,
    })
}

export function showAlertQuestion({ title, message, onOk, onCancel, position, cancelButton, okButtonText, cancelButtonText }: {
    title?: string,
    message: string,
    onOk?: () => void,
    onCancel?: () => void,
    position?: AlertPosition,
    cancelButton?: boolean,
    okButtonText?: string,
    cancelButtonText?: string,
}) {
    showAlert({
        title: title ?? "Konfirmasi",
        message,
        type: 'question',
        onOk,
        onCancel,
        position,
        cancelButton,
        okButtonText,
        cancelButtonText,
    })
}

export function showAlertError({ title, message }: { title?: string, message: string }) {
    showAlert({
        title,
        message,
        type: 'error',
        cancelButton: false,
    })
}

export function showAlertConfirmDelete(onOk: () => void) {
    showAlert({
        title: "Konfirmasi",
        message: "Yakin ingin menghapus data?",
        type: "question",
        onOk,
    })
}

export function Alert(props: { isMobile?: boolean, zIndex?: number }) {
    const isMobile = derived(() => props.isMobile ?? false)
    
    function dismiss() {
        alertConfig.value?.onDismiss?.()
        alertConfig.value = null
    }
    
    function ok() {
        alertConfig.value?.onOk?.()
        dismiss()
    }
    
    function cancel() {
        alertConfig.value?.onCancel?.()
        dismiss()
    }
    
    function onClickOutside() {
        if (alertConfig.value?.dismissOnClickOutside) {
            dismiss()
        }
    }
    
    return <>
        {alertConfig.value && <>
            {isMobile.value ? (
                <MobileAlert
                    config={alertConfig.value}
                    onOk={ok}
                    onCancel={cancel}
                    onClickOutside={onClickOutside}
                    zIndex={props.zIndex}
                />
            ) : (
                <DesktopAlert
                    config={alertConfig.value}
                    onOk={ok}
                    onCancel={cancel}
                    onClickOutside={onClickOutside}
                    zIndex={props.zIndex}
                />
            )}
        </>}
    </>
}

function DesktopAlert(props: {
    config: AlertConfig | null,
    onClickOutside?: () => void
    onOk?: () => void
    onCancel?: () => void
    zIndex?: number
}) {
    return <div
        class={twMerge(
            "fixed bg-black/60 top-0 left-0 right-0 bottom-0 flex flex-row items-center justify-center",
        )}
        onclick={self(props.onClickOutside)}
        transition={fade({ duration: 75 })}
        style={{
            zIndex: `${props.zIndex ?? 999}`
        }}
    >
        <div
            class="flex flex-col overflow-hidden bg-white rounded-md p-4 mx-4"
            style={{ minWidth: `min(500px, 90%)`, maxWidth: '900px' }}
            transition={scale({ duration: 75 })}
        >
            <h1 class="text-xl font-bold text-black-medium">{props.config?.title}</h1>
            
            <div class="py-2 flex flex-row items-center">
                <If cond={props.config?.type === "info"}>
                    <span class="icon-[fluent--info-24-filled] text-primary text-4xl shrink-0"></span>
                </If>
                <ElseIf cond={props.config?.type === "success"}>
                    <span class="icon-[prime--check-circle] text-primary text-4xl shrink-0"></span>
                </ElseIf>
                <ElseIf cond={props.config?.type === "question"}>
                    <span class="icon-[fluent--question-circle-24-filled] text-blue-400 text-4xl shrink-0"></span>
                </ElseIf>
                <ElseIf cond={props.config?.type === "error"}>
                    <span class="icon-[fluent--error-circle-24-filled] text-red-400 text-4xl shrink-0"></span>
                </ElseIf>
                <ElseIf cond={props.config?.type === "warning"}>
                    <span class="icon-[fluent--warning-24-filled] text-yellow-500 text-4xl shrink-0"></span>
                </ElseIf>
                
                <h2 class="text-black-medium ml-5">{html(props.config?.message ?? '')}</h2>
            </div>

            <div class="flex flex-row justify-end mt-2">
                <If cond={props.config?.cancelButton}>
                    <Button class="w-24" style="outline" size="sm" onclick={props.onCancel}>{props.config?.cancelButtonText}</Button>
                </If>
                
                <If cond={props.config?.okButton}>
                    <Button class="w-24 ml-2" size="sm" onclick={props.onOk}>{props.config?.okButtonText}</Button>
                </If>
            </div>
        </div>
    </div>
}

function MobileAlert(props: {
    config: AlertConfig | null,
    onClickOutside?: () => void
    onOk?: () => void
    onCancel?: () => void
    zIndex?: number
}) {
    function ok() {
        historyPopWithoutEffect()
        props.onOk?.()
    }
    
    function cancel() {
        historyPopWithoutEffect()
        props.onCancel?.()
    }
    
    function clickOutside() {
        historyPopWithoutEffect()
        props.onClickOutside?.()
    }
    
    function onPop(e: PopStateEvent) {
        e.stopPropagation()
        props.onCancel?.()
    }
    
    onMount(() => {
        addPopStateListener(onPop)
        historyPush("MiddlePopup")
    })
    
    onDestroy(() => {
        removePopStateListener(onPop)
    })
    
    return <div
        class={twMerge(
            "absolute bg-black/60 top-0 left-0 right-0 bottom-0 flex flex-col items-center",
            props.config?.position === "bottom" ? "justify-end" : "justify-center"
        )}
        onclick={self(clickOutside)}
        transition={fade({ duration: 75 })}
        style={{
            zIndex: `${props.zIndex ?? 999}`
        }}
    >
        <div
            class={twJoin(
                "flex flex-col items-center overflow-hidden bg-white rounded-2xl p-4",
                props.config?.position === "bottom" ? "self-stretch" : "mx-8"
            )}
            style={{
                minWidth: props.config?.position === "bottom" ? undefined : `min(500px, 90%)`,
            }}
            transition={props.config?.position === "bottom" ? slide({ duration: 75 }) : scale({ duration: 75 })}
        >
            <h1 class="text-xl font-bold text-black-medium">{props.config?.title}</h1>
            
            <div class="mt-7 mb-4">
                <If cond={props.config?.type === "info"}>
                    <span class="icon-[fluent--info-24-filled] text-[80px] text-primary"></span>
                </If>
                <ElseIf cond={props.config?.type === "success"}>
                    <span class="icon-[prime--check-circle] text-[80px] text-primary"></span>
                </ElseIf>
                <ElseIf cond={props.config?.type === "question"}>
                    <span class="icon-[fluent--question-circle-24-filled] text-blue-400 text-[80px]"></span>
                </ElseIf>
                <ElseIf cond={props.config?.type === "error"}>
                    <span class="icon-[fluent--error-circle-24-filled] text-red-400 text-[80px]"></span>
                </ElseIf>
                <ElseIf cond={props.config?.type === "warning"}>
                    <span class="icon-[fluent--warning-24-filled] text-yellow-500 text-[80px]"></span>
                </ElseIf>
            </div>
            
            <h2 class="text-black-medium text-center">{html(props.config?.message ?? '')}</h2>

            <div class="flex flex-col gap-1 self-stretch mt-4 mx-2">
                <If cond={props.config?.okButton}>
                    <BenjolButton class="flex-1 ml-2" size="sm" onclick={ok}>{props.config?.okButtonText}</BenjolButton>
                </If>
                
                <If cond={props.config?.cancelButton}>
                    <Button class="flex-1" style="none" onclick={cancel}>{props.config?.cancelButtonText}</Button>
                </If>
            </div>
        </div>
    </div>
}