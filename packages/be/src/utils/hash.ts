import crypto from "crypto"
import jwt from "jsonwebtoken"

export type TokenResult = {
    success: true,
    data: {
        id: string,
    }
} | {
    success: false,
}

const xxx = "Th1s1sM03ny03q"

export function hashPassword(pass: string): string {
    const hash = crypto.createHash("sha256")
    hash.update(pass, 'utf-8')
    
    return hash.digest('hex')
}

export function generateToken(id: string): string {
    return jwt.sign({ id }, xxx)
}

export function verifyToken(token: string): TokenResult {
    try {
        if (!token.startsWith("Bearer ")) {
            return {
                success: false
            }
        }
        
        const formattedToken = token.substring("Bearer ".length)
        const data = jwt.verify(formattedToken, xxx) as any
        
        return {
            success: true,
            data
        }
    }
    catch (e) {
        return {
            success: false
        }
    }
}