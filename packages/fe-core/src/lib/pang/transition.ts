export function scale({
    delay = 0,
    duration = 150,
    from = 0,
    to = 1,
    easing = easeDefault,
}: {
    delay?: number
    duration?: number
    from?: number
    to?: number
    easing?: Easing,
} = {}): TransitionRunner {
    return (node) => {
        // const style = getComputedStyle(node)
	    // const transform = style.transform === 'none' ? '' : style.transform
        // const el = node instanceof HTMLElement ? node as HTMLElement : null
        
        // if (el) {
            // el.style.transform = `scale(0)`
        // }
        
        return {
            delay,
            duration,
            easing,
            frame(t) {
                const value = from + (to - from) * t
                
                return {
                    opacity: value,
                    scale: value,
                }
            },
        }
    }
}

export function slide({
    fromDirection = "bottom",
    delay = 0,
    duration = 250,
    from = 0,
    to = 1,
    easing = easeDefault,
}: {
    fromDirection?: "bottom" | "left" | "right" | "top",
    delay?: number
    duration?: number
    from?: number
    to?: number
    easing?: Easing,
} = {}): TransitionRunner {
    return () => {
        return {
            delay,
            duration,
            easing,
            frame(t) {
                const value = from + (to - from) * t
                
                let transform: string
                
                if (fromDirection === "bottom") {
                    transform = `translateY(${(1 - value) * 100}%)`
                }
                else if (fromDirection === "left") {
                    transform = `translateX(${-100 + value * 100}%)`
                }
                else if (fromDirection === "right") {
                    transform = `translateX(${(1 - value) * 100}%)`
                }
                else {
                    transform = `translateY(${-100 + value * 100}%)`
                }
                
                return {
                    transform,
                }
            },
        }
    }
}

export function fade({
    delay = 0,
    duration = 150,
    from = 0,
    to = 1,
    easing = easeDefault,
}: {
    delay?: number
    duration?: number
    from?: number
    to?: number
    easing?: Easing,
} = {}): TransitionRunner {    
    return (node) => {
        const el = node instanceof HTMLElement ? node as HTMLElement : null
        
        return {
            delay,
            duration,
            easing,
            frame(t) {
                return {
                    opacity: t,
                }
            },
        }
    }
}

export function curtain({
    delay = 0,
    duration = 150,
    easing = easeLinear,
    direction = 'vertical',
    scale = "none",
    mode,
}: {
    delay?: number
    duration?: number
    easing?: Easing,
    direction?: 'vertical' | 'horizontal',
    scale?: "x" | "y" | "both" | "none",
    mode?: Transition['mode'],
} = {}): TransitionRunner {
    return (node) => {
        const el = node instanceof HTMLElement ? node as HTMLElement : null
        
        let originalSize = 0
        let originalPaddingStart = 0
        let originalPaddingEnd = 0
        let originalMarginStart = 0
        let originalMarginEnd = 0
        let originalBorderStartSize = 0
        let originalBorderEndSize = 0
        
        if (el) {
            const computedStyle = getComputedStyle(el)
            
            if (direction === 'vertical') {
                originalSize = parseFloat(computedStyle.height)
                originalPaddingStart = parseFloat(computedStyle.paddingTop)
                originalPaddingEnd = parseFloat(computedStyle.paddingBottom)
                originalMarginStart = parseFloat(computedStyle.marginTop)
                originalMarginEnd = parseFloat(computedStyle.marginBottom)
                originalBorderStartSize = parseFloat(computedStyle.borderTopWidth)
                originalBorderEndSize = parseFloat(computedStyle.borderBottomWidth)
            }
            else {
                originalSize = parseFloat(computedStyle.width)
                originalPaddingStart = parseFloat(computedStyle.paddingLeft)
                originalPaddingEnd = parseFloat(computedStyle.paddingRight)
                originalMarginStart = parseFloat(computedStyle.marginLeft)
                originalMarginEnd = parseFloat(computedStyle.marginRight)
                originalBorderStartSize = parseFloat(computedStyle.borderLeftWidth)
                originalBorderEndSize = parseFloat(computedStyle.borderRightWidth)
            }
            
            if (isNaN(originalSize)) originalSize = 0
            if (isNaN(originalPaddingStart)) originalPaddingStart = 0
            if (isNaN(originalPaddingEnd)) originalPaddingEnd = 0
            if (isNaN(originalMarginStart)) originalMarginStart = 0
            if (isNaN(originalMarginEnd)) originalMarginEnd = 0
            if (isNaN(originalBorderStartSize)) originalBorderStartSize = 0
            if (isNaN(originalBorderEndSize)) originalBorderEndSize = 0
        }
        
        let transformScale: string | null
        
        if (scale === "x") {
            transformScale = `scaleX`
        }
        else if (scale === "y") {
            transformScale = `scaleY`
        }
        else if (scale === "both") {
            transformScale = `scale`
        }
        else if (scale === "none") {
            transformScale = null
        }
        else if (scale === undefined) {
            if (direction === "vertical") {
                transformScale = "scaleY"
            }
            else {
                transformScale = "scaleX"
            }
        }
        
        return {
            fillMode: "none",
            delay,
            duration,
            easing,
            mode,
            frame(t) {
                const transform = transformScale ? `${transformScale}(${t})` : undefined
                
                if (direction === 'vertical') {
                    const x: any = {
                        minHeight: `${originalSize * t}px`,
                        height: `${originalSize * t}px`,
                        paddingTop: `${originalPaddingStart * t}px`,
                        paddingBottom: `${originalPaddingEnd * t}px`,
                        marginTop: `${originalMarginStart * t}px`,
                        marginBottom: `${originalMarginEnd * t}px`,
                        borderTopWidth: `${originalBorderStartSize * t}px`,
                        borderBottomWidth: `${originalBorderEndSize * t}px`,
                    }
                    
                    if (transform) {
                        x['transform'] = transform
                    }
                    
                    return x
                }
                else {
                    const x: any = {
                        minWidth: `${originalSize * t}px`,
                        width: `${originalSize * t}px`,
                        paddingLeft: `${originalPaddingStart * t}px`,
                        paddingRight: `${originalPaddingEnd * t}px`,
                        marginLeft: `${originalMarginStart * t}px`,
                        marginRight: `${originalMarginEnd * t}px`,
                        borderLeftWidth: `${originalBorderStartSize * t}px`,
                        borderRightWidth: `${originalBorderEndSize * t}px`,
                    }
                    
                    if (transform) {
                        x['transform'] = transform
                    }
                    
                    return x
                }
            },
        }
    }
}

export async function runTransition(node: Element, transition: Transition, mode: 'in' | 'out') {    
    const frames: Keyframe[] = []
    let easing: string | undefined
    
    if (typeof transition.easing === 'function') {
        // 60 FPS
        const inc = 1000 / 60
        let curTime = 0
        
        while (curTime < transition.duration) {
            frames.push(transition.frame(transition.easing(curTime / transition.duration)))
            curTime += inc
        }
        
        frames.push(transition.frame(transition.easing(1)))
        
        if (mode === 'out') {
            frames.reverse()
        }
    }
    else if (transition.easing.type === 'cubic') {
        const startFrame = transition.frame(0)
        const endFrame = transition.frame(1)
        
        frames.push(startFrame)
        frames.push(endFrame)
        
        const value = [...transition.easing.value]
        
        if (mode === 'out') {
            frames.reverse()
            value.reverse()
        }
        
        easing = `cubic-bezier(${value.join(',')})`
    }
    else if (transition.easing.type === "css") {
        const startFrame = transition.frame(0)
        const endFrame = transition.frame(1)
        
        frames.push(startFrame)
        frames.push(endFrame)
        
        if (mode === 'out') {
            frames.reverse()
        }
        
        easing = transition.easing.value
    }
    else {
        for (const f of transition.easing.values) {
            const frame = transition.frame(f.value)
            frame.offset = mode === 'in' ? f.frame : 1 - f.frame
            
            frames.push(frame)
        }
        
        if (mode === 'out') {
            frames.reverse()
        }
    }
    
    const anim = node.animate(frames, {
        duration: transition.duration,
        fill: transition.fillMode ?? "both",
        easing,
    })
    
    return new Promise<void>((res) => {
        anim.onfinish = () => {
            // NOTE: Animasi gak akan kelepas (gak bisa set style) walaupun animation udah finish
            //       Harus di-cancel dulu kalau mau ngelepas effect dari animasi (kalau fill = "both" | "forwards")
            // anim.cancel()
            transition.onFinish?.(mode)
            res()
        }
    })
}

export const easeLinear: Easing = { type: 'cubic', value: [0, 0, 1, 1] }
export const easeCubicOut: Easing = { type: 'cubic', value: [0.66, 0, 0.34, 1] }
export const easeBounceOut: Easing = {
    type: 'frames',
    values: [
        { frame: 0, value: 0 },
        { frame: 0.12, value: 0.10999999999999999 },
        { frame: 0.24, value: 0.43999999999999995 },
        { frame: 0.36, value: 0.98 },
        { frame: 0.54, value: 0.75 },
        { frame: 0.74, value: 0.98 },
        { frame: 0.82, value: 0.94 },
        { frame: 0.92, value: 0.99 },
        { frame: 0.96, value: 0.98 },
        { frame: 1, value: 1 }
    ]
}
export const easeElasticOut: Easing = {
    type: 'frames',
    values: [
        { frame: 0, value: 0 },
        { frame: 0.16, value: 1.32 },
        { frame: 0.28, value: 0.87 },
        { frame: 0.44, value: 1.05 },
        { frame: 0.59, value: 0.98 },
        { frame: 0.73, value: 1.01 },
        { frame: 0.88, value: 1 },
        { frame: 1, value: 1 }
    ]
}
export const easeCircOut: Easing = { type: 'cubic', value: [0, 0.55, 0.45, 1] }
export const easeExpoInOut: Easing = { type: 'cubic', value: [0.87, 0, 0.13, 1] }
export const easeSpring: Easing = { type: 'css', value: "linear(0, 0.01 0.7%, 0.046 1.5%, 0.192 3.2%, 0.391 4.8%, 0.954 8.8%, 1.201 11%, 1.347 13%, 1.388 14%, 1.41 15.1%, 1.411 15.9%, 1.4 16.8%, 1.342 18.6%, 1.256 20.3%, 1.013 24.5%, 0.913 26.7%, 0.857 28.6%, 0.831 30.6%, 0.833 32.1%, 0.851 33.7%, 1.024 41.6%, 1.055 43.8%, 1.069 46%, 1.061 49.3%, 0.991 57.1%, 0.972 61.4%, 0.974 64.8%, 1.011 76.7%, 0.996 91.2%, 1)" }
export const easeDefault = easeCubicOut