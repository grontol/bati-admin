import { obs } from "@pang"
import { thousandSeparator } from "@tahfeedz/fe-core/utils/text.js"

export type Validator<T = any> = {
    validate: (value: T) => MayPromise<string | null>
    trigger?: () => any
}

export function requiredValidator(allowZero = true): Validator {
    const message = 'Harus diisi'
    
    return {
        validate(value) {
            if (value === null || value === undefined) return message
            if (typeof value === 'string' && value.length === 0) return message
            if (Array.isArray(value) && value.length === 0) return message
            if (!allowZero && typeof value === 'number' && value === 0) return message
            
            return null
        },
    }
}

export function minLengthValidator(length: number): Validator {
    const message = `Minimal ${length} karakter`
    
    return {
        validate(value) {
            if (value === null || value === undefined) return message
            if (typeof value === 'string' && value.length < length) return message
            if (Array.isArray(value) && value.length < length) return message
            
            return null
        },
    }
}

export function minValueValidator(amount: number, msg?: string): Validator {
    const message = msg ?? `Minimal ${thousandSeparator(amount)}`
    
    return {
        validate(value) {
            if (value === null || value === undefined || value === "") return null
            
            const valueNum = parseInt(value)
            
            if (isNaN(valueNum)) return message
            if (value < amount) return message
            
            return null
        },
    }
}

export function maxValueValidator(amount: number, msg?: string): Validator {
    const message = msg ?? `Maksimal ${thousandSeparator(amount)}`
    
    return {
        validate(value) {
            if (value === null || value === undefined || value === "") return null
            
            const valueNum = parseInt(value)
            
            if (isNaN(valueNum)) return message
            if (value > amount) return message
            
            return null
        },
    }
}

export function fnValidator(fn: (value: any) => boolean, msg: string | ((value: any) => string), trigger?: () => any): Validator {
    const message = msg
    
    return {
        validate(value) {
            if (!fn(value)) {
                if (typeof message === "string") return message
                else return message(value)
            }
            
            return null
        },
        trigger,
    }
}

export function timeValidator(allowEmpty: boolean = true, errMsg?: string): Validator {
    return regexValidator(/^[0-9]{2}\.[0-9]{2}$/, allowEmpty, errMsg ?? "Format harus 00.00")
}

export function regexValidator(regex: RegExp, allowEmpty?: boolean, errMsg?: string): Validator {
    const message = errMsg ?? `Harus sesuai pattern ${regex}`
    
    return {
        validate(value) {
            if (allowEmpty && !value) return null
            if (value === null || value === undefined) return message            
            if (!regex.test(value.toString())) return message
            
            return null
        },
    }
}

const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

export function emailValidator(): Validator {
    const message = "Harus berupa email"
    
    return {
        validate(value) {
            if (value === null || value === undefined) return message
            if (!emailRegex.test(value.toString())) return message
            
            return null
        },
    }
}

export function mustMatchValidator(value: MaybeObs<any>, errMsg?: string): Validator {
    const message = errMsg ?? "Harus sesuai"
    const valueObs = obs(value)
    
    return {
        validate(value) {
            if (value !== valueObs.value) return message
            
            return null
        },
    }
}