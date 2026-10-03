let isInit = false
let pendingManualPopTrigger = 0
let length = 1

export type PopStateEvent = { stopPropagation(): void }
export type PopStateListener = (e: PopStateEvent) => void

const listeners: PopStateListener[] = []

export function addPopStateListener(listener: PopStateListener) {
    if (!isInit) {
        window.addEventListener("popstate", () => {
            if (pendingManualPopTrigger > 0) {
                pendingManualPopTrigger--
                return
            }
            
            let isStopped = false
            
            const event: PopStateEvent = {
                stopPropagation() {
                    isStopped = true
                },
            }
            
            for (let a = listeners.length - 1; a >= 0; a--) {
                listeners[a](event)
                if (isStopped) break
            }
        })
        
        isInit = true
    }
    
    listeners.push(listener)
}

export function removePopStateListener(listener: PopStateListener) {
    const index = listeners.indexOf(listener)
    if (index >= 0) listeners.splice(index, 1)
}

export function historyPush(name: string) {
    if (window.name) return
    
    history.pushState({ name }, "")
    length++
}

export function historyPop() {
    if (window.name) return
    
    length--
    history.back()
}

export function historyPopWithoutEffect() {
    if (window.name) return
    
    pendingManualPopTrigger++
    length--
    history.back()
}

(window as any).historyLength = () => {
    return length
}

(window as any).historyPop = historyPop