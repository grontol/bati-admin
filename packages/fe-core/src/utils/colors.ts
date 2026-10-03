
export const colors = ["#9260F4", "#F478B8", "#FF9142", "#329628", "#02929A"]
export const cssColors = {
    primary: "#02929A",
    kedua: "#D9EFF0",
}

type ColorRgb = { r: number, g: number, b: number }

export function colorLighten(color: string, amount: number) {
    const clampedAmount = Math.min(Math.max(amount, 0), 1)
    const rgb = parseColor(color)
    
    rgb.r = lighten(rgb.r, clampedAmount)
    rgb.g = lighten(rgb.g, clampedAmount)
    rgb.b = lighten(rgb.b, clampedAmount)
    
    return rgbToString(rgb)
}

export function colorDarken(color: string, amount: number) {
    const clampedAmount = Math.min(Math.max(amount, 0), 1)
    const rgb = parseColor(color)
    
    rgb.r = darken(rgb.r, clampedAmount)
    rgb.g = darken(rgb.g, clampedAmount)
    rgb.b = darken(rgb.b, clampedAmount)
    
    return rgbToString(rgb)
}

function parseColor(color: string): ColorRgb {
    if (color[0] !== "#") return { r: 0, g: 0, b: 0 }
    
    // #000000 or #00000000, ignoring alpha
    if (color.length >= 7) {
        const r = parseInt(color.substring(1, 3), 16)
        const g = parseInt(color.substring(3, 5), 16)
        const b = parseInt(color.substring(5, 7), 16)
        
        return { r, g, b }
    }
    // #000 or #0000, ignoring alpha
    else if (color.length >= 4) {
        const r = parseInt(color.substring(1, 2), 16)
        const g = parseInt(color.substring(2, 3), 16)
        const b = parseInt(color.substring(3, 4), 16)
        
        return { r, g, b }
    }
    else {
        return { r: 0, g: 0, b: 0 }
    }
}

function rgbToString(rgb: ColorRgb): string {
    const r = rgb.r.toString(16).padStart(2, '0')
    const g = rgb.g.toString(16).padStart(2, '0')
    const b = rgb.b.toString(16).padStart(2, '0')
    
    return `#${r}${g}${b}`
}

function lighten(v: number, amount: number): number {    
    return Math.floor((255 - v) * amount + v)
}

function darken(v: number, amount: number): number {
    return Math.floor(v * (1 - amount))
}