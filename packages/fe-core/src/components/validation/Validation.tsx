import { createContext } from "@pang/context.js"
import { Field } from "./field.js"

export type ValidationRef = {
    validate: () => Promise<boolean>
}

export type ValidationContext = {
    addField(field: Field): void
    removeField(field: Field): void
}

type Props = Refable<{
    children?: JSX.Element
}, ValidationRef>

export const validationContext = createContext<ValidationContext>()

export function Validation(props: Props) {
    props.ref?.({
        validate,
    })
    
    validationContext.set({
        addField,
        removeField,
    })
    
    const fields: Field[] = []
    
    function addField(field: Field) {
        fields.push(field)
    }
    
    function removeField(field: Field) {
        const index = fields.indexOf(field)
        
        if (index >= 0) {
            fields.splice(index, 1)
        }
    }
    
    async function validate() {
        let res = true
        
        for (const field of fields) {
            if (!await field.validate()) {
                if (res) {
                    field.focus?.()
                    res = false
                }
            }
        }
        
        return res
    }
    
    return <>
        {props.children}
    </>
}