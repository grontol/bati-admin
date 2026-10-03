import { customStorage } from "@pang/storage.js"
import { ReferenceData } from "@tahfeedz/shared/types.js"
import { dereference } from "@tahfeedz/shared/utils.js"

export const baseUrl = import.meta.env.VITE_BE_BASE_URL
export const baseUrlApi = `${baseUrl}api/`
const logEnabled = import.meta.env.VITE_API_LOG_ENABLED === "true"
const origin = import.meta.env.VITE_FE_ORIGIN

export type ApiResponse<T = any> = {
    message: string
    status: string
} & ({
    success: true
    data: T
} | {
    success: false
})

export class ApiJob<T = any> {
    id: number
    method: "GET" | "POST" | "PUT" | "PATCH" | "DELETE"
    url: string
    data: any
    referenced: boolean
    cb: WeakRef<(data: ApiResponse<T>) => void> | null = null
    
    constructor(job: {
        id: number,
        method: "GET" | "POST" | "PUT" | "PATCH" | "DELETE",
        url: string,
        data: any,
        referenced: boolean,
    }) {
        this.id = job.id
        this.method = job.method
        this.url = job.url
        this.data = job.data
        this.referenced = job.referenced
    }
    
    async load(cb: (data: ApiResponse<T>) => void, onFailed?: () => void): Promise<boolean> {
        try {        
            const res = await this.exec()
            cb?.(res)
            
            return true
        }
        catch (e) {
            if (e instanceof SyntaxError) {
                cb?.({
                    success: false,
                    message: "Invalid JSON",
                    status: "error"
                })
                
                return true
            }
            
            console.log(e)
            this.cb = new WeakRef(cb)
            failedJobHandler?.(this)
            
            onFailed?.()
            
            return false
        }
    }
    
    async reload(): Promise<boolean> {
        try {
            const res = await this.exec()
            this.cb?.deref()?.(res)
            
            return true
        }
        catch (e) {            
            return false
        }
    }
    
    async tryExec(): Promise<ApiResponse<T>> {
        try {
            return this.exec()
        }
        catch (e: any) {
            return {
                success: false,
                message: (e?.message ?? e?.toString() ?? ""),
                status: "Error"
            }
        }
    }
    
    private async exec(): Promise<ApiResponse<T>> {
        let res: ApiResponse<T>
        
        if (this.method === "GET") {
            res = await doGet<T>(this.url, this.referenced)
        }
        else if (this.method === "POST") {
            res = await doPost<T>(this.url, this.data)
        }
        else if (this.method === "PUT") {
            res = await doPut<T>(this.url, this.data)
        }
        else if (this.method === "PATCH") {
            res = await doPatch<T>(this.url, this.data)
        }
        else {
            res = await doDelete<T>(this.url, this.data)
        }
        
        return res
    }
}

let jobCounter = 0
let failedJobHandler: ((job: ApiJob) => void) | null = null

export function imageUrlOf(image: string | null | undefined, placeholder?: string) {
    if (!image) return placeholder ?? "/images/user.webp"
    
    if (image.startsWith("http") || image.startsWith("blob:")) return image
    
    return `${baseUrl}uploads/${image}`
}

export function uploadUrlOf(file: string) {    
    return `${baseUrl}uploads/${file}`
}

export function setJobFailedHandler(handler: (job: ApiJob) => void) {
    failedJobHandler = handler
}

async function doGet<T>(url: string, referenced = false): Promise<ApiResponse<T>> {
    const res = await fetch(url, {
        method: "GET",
        headers: getHeaders(),
    })
    
    let json = await res.json()
    
    if (logEnabled) {
        console.log("[GET]", url)
        console.log("Response:", json)
    }
    
    if (referenced) {
        json = deref(json)
        
        if (logEnabled) {
            console.log("Dereferenced:", json)
        }
    }
    
    return json
}

export function apiGet<T>(path: string, referenced = false): ApiJob<T> {
    const url = new URL(path, baseUrlApi)
    
    return new ApiJob({
        id: jobCounter++,
        method: "GET",
        data: null,
        referenced,
        url: url.href,
    })
}

export async function apiGetBlob<T>(path: string): Promise<Blob> {
    const url = new URL(path, baseUrlApi)
    
    const res = await fetch(url.href, {
        method: "GET",
        headers: getHeaders(),
    })
    
    const blob = await res.blob()
    
    if (logEnabled) {
        console.log("[GET]", url.href)
        console.log("Response:", blob)
    }
    
    return blob
}

async function doPost<T>(path: string, payload: any): Promise<ApiResponse<T>> {
    const url = new URL(path, baseUrlApi)
    
    const res = await fetch(url.href, {
        method: "POST",
        headers: getHeaders(),
        body: JSON.stringify(payload),
    })
    
    const json = await res.json()
    
    if (logEnabled) {
        console.log("[POST]", url.href)
        console.log("Payload:", payload)
        console.log("Response:", json)
    }
    
    return json
}

export function apiPost<T>(path: string, payload: any): ApiJob<T> {
    console.log(baseUrlApi)
    const url = new URL(path, baseUrlApi)
    
    return new ApiJob({
        id: jobCounter++,
        method: "POST",
        data: payload,
        referenced: false,
        url: url.href,
    })
}

async function doPut<T>(path: string, payload: any): Promise<ApiResponse<T>> {
    const url = new URL(path, baseUrlApi)
    
    const res = await fetch(url.href, {
        method: "PUT",
        headers: getHeaders(),
        body: JSON.stringify(payload),
    })
    
    const json = await res.json()
    
    if (logEnabled) {
        console.log("[PUT]", url.href)
        console.log("Payload:", payload)
        console.log("Response:", json)
    }
    
    return json
}

export function apiPut<T>(path: string, payload: any): ApiJob<T> {
    const url = new URL(path, baseUrlApi)
    
    return new ApiJob({
        id: jobCounter++,
        method: "PUT",
        data: payload,
        referenced: false,
        url: url.href,
    })
}

async function doPatch<T>(path: string, payload: any): Promise<ApiResponse<T>> {
    const url = new URL(path, baseUrlApi)
    
    const res = await fetch(url.href, {
        method: "PATCH",
        headers: getHeaders(),
        body: JSON.stringify(payload),
    })
    
    const json = await res.json()
    
    if (logEnabled) {
        console.log("[PATCH]", url.href)
        console.log("Payload:", payload)
        console.log("Response:", json)
    }
    
    return json
}

export function apiPatch<T>(path: string, payload: any): ApiJob<T> {
    const url = new URL(path, baseUrlApi)
    
    return new ApiJob({
        id: jobCounter++,
        method: "PATCH",
        data: payload,
        referenced: false,
        url: url.href,
    })
}

async function doDelete<T>(path: string, payload?: any): Promise<ApiResponse<T>> {
    const url = new URL(path, baseUrlApi)
    
    const res = await fetch(url.href, {
        method: "DELETE",
        headers: getHeaders(),
        body: payload === undefined ? undefined : JSON.stringify(payload),
    })
    
    const json = await res.json()
    
    if (logEnabled) {
        console.log("[DELETE]", url.href)
        if (payload) {
            console.log("Payload:", payload)
        }
        console.log("Response:", json)
    }

    return json
}

export function apiDelete<T>(path: string, payload?: any): ApiJob<T> {
    const url = new URL(path, baseUrlApi)
    
    return new ApiJob({
        id: jobCounter++,
        method: "DELETE",
        data: payload,
        referenced: false,
        url: url.href,
    })
}

function getHeaders() {
    const header: HeadersInit = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-Origin': origin ?? (window as any).x_origin ?? window.location.origin
    }
    
    const token = customStorage.getItem(`__tahf_token`)
    
    if (token) {
        header['Authorization'] = `Bearer ${token}`
    }
    
    return header
}

function deref(data: ApiResponse<ReferenceData>) {
    const res = structuredClone(data)
    
    if (res.success) {
        res.data = dereference(res.data)
    }
    
    return res
}