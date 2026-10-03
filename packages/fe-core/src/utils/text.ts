export function thousandSeparator(value: number): string {
    const str = value.toString()
    let res = ''
    
    for (let a = 0; a < str.length; a++) {
        if (a > 0 && (str.length - a) % 3 === 0) {
            res += '.'
        }
        
        res += str[a]
    }
    
    return res
}

export function rpize(value: number): string {
    return `Rp ${thousandSeparator(value)}`
}

export function arabicSafeTextLimit(text: string, n = 40) {
    if (text.length > n) {
        return arabicSafeTextLimitInternal(text, n) + "﮳﮳﮳إلخ"
    }
    else {
        return text
    }
}

function arabicSafeTextLimitInternal(text: string, n = 40) {
    let s = ''
    let limitReached = false
    
    for (let a = 0; a < text.length; a++) {
        if (a === n) {
            limitReached = true
        }
        
        const ch = text[a]
        
        if (nextTextIs(text, a, "<span")) {
            while (a < text.length && !nextTextIs(text, a, "</span>")) {
                s += text[a]
                a++
            }
            
            s += "</span>"
            a += 6
            
            if (limitReached) break
        }
        else if (ch === ' ') {
            s += ' '
            if (limitReached) break
        }
        else {
            s += ch
        }
    }
    
    return s
}

function nextTextIs(input: string, index: number, search: string): boolean {
    for (let a = index; a < index + search.length; a++) {
        if (a >= input.length) return false
        if (input[a] !== search[a - index]) return false
    }
    
    return true
}