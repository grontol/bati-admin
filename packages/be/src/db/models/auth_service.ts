import { Rctx } from "@/ctx"
import { $users } from "@/db/models/user_model"
import { appError } from "@/error"
import { generateToken, hashPassword } from "@/utils/hash"
import { UserData } from "@tahfeedz/shared/types"

export function makeAuthService() {
    return {
        async login(rctx: Rctx, username: string, password: string | null): Promise<UserData & { token: string }> {
            const res: UserData & { password: string } | null = await $users
                .query()
                .whereRaw("username = ? OR email = ?", [username, username])
                .getOne<{ password: string }>()
            
            if (!res) appError("Username atau password salah", 401)
            if (password !== null && res.password !== hashPassword(password)) appError("Username atau password salah", 401)
            
            const data: any = {
                ...res,
                token: generateToken(res.id),
            }
            
            return data
        },
    }
}

export type AuthService = ReturnType<typeof makeAuthService>