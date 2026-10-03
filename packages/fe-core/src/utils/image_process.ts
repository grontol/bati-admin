export class ImageProcessor {
    private _outputMaxWidth = 1024
    private _outputMaxHeight = 1024
    
    maxSize(width: number, height: number) {
        this._outputMaxWidth = width
        this._outputMaxHeight = height
        
        return this
    }
    
    async toDataUrl(src: string): Promise<string> {
        if (isBlob(src)) {
            const { dataUrl, mimeType } = await readDataUrlFromBlob(src)
            const img = await createImageFromDataUrl(dataUrl)
            
            if (img.naturalWidth > this._outputMaxWidth || img.naturalHeight > this._outputMaxHeight) {
                return resizeImage(img, this._outputMaxWidth, this._outputMaxHeight, mimeType)
            }
            else {
                return dataUrl
            }
        }
        
        return src
    }
}

async function readDataUrlFromBlob(blobUrl: string): Promise<{ dataUrl: string, mimeType: string }> {
    const res = await fetch(blobUrl)
    const blob = await res.blob()
    
    return new Promise((res, rej) => {
        const reader = new FileReader()
        
        reader.onload = () => {
            res({
                dataUrl: reader.result as any,
                mimeType: blob.type,
            })
        }
        
        reader.onerror = rej
        reader.readAsDataURL(blob)
    })
}

async function createImageFromDataUrl(dataUrl: string): Promise<HTMLImageElement> {
    return new Promise((res) => {
        const img = new Image()
        img.src = dataUrl
        
        img.onload = () => {
            res(img)
        }
    })
}

function resizeImage(img: HTMLImageElement, maxWidth: number, maxHeight: number, mimeType: string): string {
    const canvas = document.createElement("canvas")
    const ctx = canvas.getContext("2d")!
    
    const ratio = img.naturalWidth / img.naturalHeight
    
    let targetWidth = maxWidth
    let targetHeight = Math.round(maxWidth / ratio)
    
    if (targetHeight > maxHeight) {
        targetWidth = Math.round(maxHeight * ratio)
        targetHeight = maxHeight
    }
    
    canvas.width = targetWidth
    canvas.height = targetHeight
    
    ctx.drawImage(img, 0, 0, targetWidth, targetHeight)
    const dataUrl = canvas.toDataURL(mimeType, 90)
    
    canvas.remove()
    
    return dataUrl
}

function isBlob(src: string): boolean {
    return src.startsWith("blob:")
}

function isDataUrl(src: string): boolean {
    return src.startsWith("data:")
}