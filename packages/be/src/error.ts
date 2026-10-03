export class AppError {
    code: number
    message: string
    detail: any
    
    constructor(message: string, code = 400, detail = undefined) {
        this.message = message
        this.code = code
        this.detail = detail
    }
}

export function appError(message: string, code = 400, detail = undefined): never {
    throw new AppError(message, code, detail)
}

export function internalError(message: string): never {
    throw new AppError(message, 500)
}

export function forbiddenError(message?: string): never {
    throw new AppError(message ?? "Forbidden resource", 403)
}

export function testError(message: string) {
    throw new AppError(message)
}