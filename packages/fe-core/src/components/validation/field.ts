import { effect, obs, state } from "@pang";
import { Validator } from "./validator.js";

export type Field = {
    validate: () => Promise<boolean>
    errors: Obs<string[]>
    focus?: () => void
}

export function createField(value: Obs, validators: MaybeObs<Validator[]>, focus?: () => void): Field {
    const errors = state<string[]>([])
    const obsValidators = obs(validators)
    
    const deps: (Obs | (() => any))[] = [value, obsValidators]
    
    for (const v of obsValidators.value) {
        if (v.trigger) {
            deps.push(v.trigger)
        }
    }
    
    async function validate() {
        const newValue = value.value
        const newErrors: string[] = []
        
        for (const v of obsValidators.value) {
            const res = await Promise.resolve(v.validate(newValue))
            
            if (res) {
                newErrors.push(res)
            }
        }
        
        errors.value = newErrors
        
        return newErrors.length === 0
    }
    
    effect(validate, deps, false)
    
    return {
        validate,
        errors,
        focus,
    }
}