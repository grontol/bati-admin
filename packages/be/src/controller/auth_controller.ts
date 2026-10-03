import { Ctx } from "@/ctx";
import { AuthService } from "@/db/models/auth_service";
import { TransactionManager } from "@/db/transaction";
import { z } from "zod";

const payloadLogin = z.object({
    username: z.string(),
    password: z.string(),
})

export function makeAuthController(tm: TransactionManager, authService: AuthService) {
    return {
        async login(ctx: Ctx) {
            const payload = payloadLogin.parse(ctx.body)
            return await authService.login(ctx.rctx(), payload.username, payload.password)
        },
    }
}

export type AuthController = ReturnType<typeof makeAuthController>