import { appError, AppError } from "@/error";
import { verifyToken } from "@/utils/hash";
import { UserData } from "@tahfeedz/shared/types";
import { Request, Response } from "express";
import { ZodError } from "zod";

export interface Ctx {
    readonly body: any
    readonly params: Record<string, string>
    readonly query: Record<string, any>
    readonly userId?: string
    
    rctx: () => Rctx
}

export interface Rctx {
    readonly userId: string
    readonly user: UserData
    readonly userOrNull: UserData | null
    
    readonly origin: string
    
    setData: (key: string, value: any) => void
    getData: (key: string) => any
}

export type DataProvider = {
    getUserById: (userId: string) => Promise<UserData | null>
}

async function makeCtx(
    req: Request,
    dataProvider: DataProvider,
    _userId?: string,
): Promise<Ctx> {
    let userId = _userId
    let user = userId ? await dataProvider.getUserById(userId) : null
    
    return {
        body: req.body ?? {},
        query: req.query ?? {},
        params: req.params,
        userId,
        
        rctx() {
            const data = new Map<string, any>()
            
            return {
                origin: req.get("x-origin") ?? req.get("origin") ?? req.get("referer") ?? "",
                
                get userId() {
                    if (!userId) appError("UserId is null")
                    
                    return userId
                },
                
                get user() {
                    return user ?? appError("Invalid user")
                },
                
                get userOrNull() {
                    return user
                },
                
                
                setData(key, value) {
                    data.set(key, value)
                },
                
                getData(key) {
                    return data.get(key)
                },
            }
        },
    }
}

export class Handler {
    private dataProvider: DataProvider
    
    constructor(dataProvider: DataProvider) {
        this.dataProvider = dataProvider
    }
    
    make(handler: (ctx: Ctx) => any | Promise<any>) {
        return async (req: Request, res: Response) => {
            try {
                const token = req.header("Authorization")
                let userId: string | undefined = undefined
                
                if (token) {
                    const authData = verifyToken(token)
                    
                    if (authData.success) {
                        userId = authData.data.id
                    }
                }
                
                const ctx = await makeCtx(req, this.dataProvider)
                const result = await Promise.resolve(handler(ctx))
                
                if (result instanceof Blob) {
                    res.set('Content-Type', result.type)
                    res.send(Buffer.from(await result.arrayBuffer()))
                }
                else if (result instanceof Redirect) {
                    res.redirect(301, result.to)
                }
                else {
                    res.json({
                        success: true,
                        message: "Success",
                        data: addHostUrl(`${req.protocol}://${req.host}`, result),
                    })
                }
            }
            catch (e: any) {
                let status = 400
                let message: string
                let detail: any
                
                if (e instanceof ZodError) {
                    message = formatZodError(e)
                }
                else if (e instanceof AppError) {
                    if (e.code === 500) {
                        status = e.code
                        message = "Internal server error"
                        
                        console.error("Internal server error", e.message)
                    }
                    else {
                        status = e.code
                        message = e.message
                        detail = e.detail
                    }
                }
                else {
                    message = e?.message ?? e?.toString() ?? ''
                    detail = e?.detail
                    
                    console.error(message, detail)
                    console.error(e.stack)
                }
                
                res.status(status).json({
                    success: false,
                    message,
                    detail,
                })
            }
        }
    }
}

function formatZodError(e: ZodError, path?: string): string {
    const parentPath = path ? [path] : []
    
    return e.issues.map(x => {
        const path = [...parentPath, x.path].join(".")
        
        // if (x.code === 'invalid_type') {
        //     if (x.received === 'undefined') {
        //         return `'${path}' harus diisi`
        //     }
        //     else {
        //         return `'${path}' harus bertipe ${x.expected}`
        //     }
        // }
        // else if (x.code === 'invalid_enum_value') {
        //     const options = x.options.map(x => `'${x}'`).join(' | ')
        //     return `'${path}' harus berisi ${options}`
        // }
        
        return x.message
    }).join("\n")
}

function addHostUrl(host: string, value: any): any {
    if (value === null) return null
    if (value === undefined) return undefined
    if (typeof value === "string") {
        if (value.startsWith(HOST_PLACEHOLDER)) {
            const ori = value.substring(HOST_PLACEHOLDER.length)
            
            if (ori.startsWith('/')) {
                return host + ori
            }
            else {
                return host + '/' + ori
            }
        }
        else {
            return value
        }
    }
    if (value instanceof Blob) {
        return value
    }
    if (Array.isArray(value)) {
        for (let a = 0; a < value.length; a++) {
            value[a] = addHostUrl(host, value[a])
        }
    }
    if (typeof value === 'object') {
        for (const k in value) {
            value[k] = addHostUrl(host, value[k])
        }
        
        return value
    }
    return value
}

const HOST_PLACEHOLDER = "__$$HOST$$__"
export function hostUrl(path: string) {
    return HOST_PLACEHOLDER + path
}

class Redirect {
    to: string
    
    constructor(to: string) {
        this.to = to
    }
}

export function redirect(to: string) {
    return new Redirect(to)
}