export function makeDebounce<T = void>(cb: (payload: T) => void, delay = 500) {
    let timeoutId: any = null
    
    return (payload: T) => {
        if (timeoutId) clearTimeout(timeoutId)
            
        timeoutId = setTimeout(() => cb(payload), delay)
    }
}