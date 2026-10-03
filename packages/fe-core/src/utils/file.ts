export function readFileInput(accept: string): Promise<File | null> {
    const el = document.createElement("input")
    el.type = "file"
    el.accept = accept
    el.click()
    
    return new Promise((res, rej) => {
        el.onchange = () => {
            if (el.files && el.files?.length > 0) {
                res(el.files[0])
            }
            else {
                res(null)
            }
        }
        
        el.oncancel = () => {
            res(null)
        }
    })
}

export async function fileToBase64(file: File): Promise<string> {
    return new Promise((res) => {
        const reader = new FileReader()
        
        reader.onload = e => {
            res(e.target?.result as string)
        }
        
        reader.readAsDataURL(file)
    })
}