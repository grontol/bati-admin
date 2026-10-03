import { derived, state } from "@pang";

const windowWidth = state(window.innerWidth)
const isMobileState = state(isMobileInternal())
const isMobileSizeState = state(isMobileSizeInternal())

export const windowSize = {
    isAtLeastSm: derived(() => windowWidth.value >= 640),
    isAtLeastMd: derived(() => windowWidth.value >= 768),
    isAtLeastLg: derived(() => windowWidth.value >= 1024),
    isAtLeastXl: derived(() => windowWidth.value >= 1280),
    isAtLeast2Xl: derived(() => windowWidth.value >= 1536),
    
    isLessThanSm: derived(() => windowWidth.value < 640),
    isLessThanMd: derived(() => windowWidth.value < 768),
    isLessThanLg: derived(() => windowWidth.value < 1024),
    isLessThanXl: derived(() => windowWidth.value < 1280),
    isLessThan2Xl: derived(() => windowWidth.value < 1536),
}

function isMobileByUserAgent() {
    const regex = /Mobi|Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i;
    return regex.test(navigator.userAgent);
}

function isMobileInternal() {
    return isMobileByUserAgent()
}

function isMobileSizeInternal() {
    return isMobileByUserAgent() || window.innerWidth < 600
}

export function isMobile(): Obs<boolean> {
    return isMobileState
}

export function isMobileSize(): Obs<boolean> {
    return isMobileSizeState
}

function onResize() {
    windowWidth.value = window.innerWidth
    isMobileSizeState.value = isMobileSizeInternal()
    isMobileState.value = isMobileInternal()
}

window.addEventListener('resize', onResize)

export function isSandboxed() {
    return window.name.startsWith("inst-") || window.name.startsWith("dev-inst-")
}