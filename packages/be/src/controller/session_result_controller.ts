import { Ctx } from "@/ctx";
import { TransactionManager } from "@/db/transaction";
import { SessionResultService } from "@/service/session_result_service";
import z from "zod";

const payloadSessionResult = z.object({
    name: z.string(),
    nis: z.string(),
    details: z.array(z.object({
        scene: z.number(),
        part: z.number(),
        is_passed: z.number(),
        score: z.number(),
        fluency: z.number(),
        professionalism: z.number(),
        intonation: z.number(),
        content: z.string(),
        feedback: z.string(),
        suggested_response: z.string(),
    }))
})

export function makeSessionResultController(tm: TransactionManager, sessionResultService: SessionResultService) {
    return {
        async getAll(ctx: Ctx) {
            return sessionResultService.getAll(ctx.rctx())
        },
        
        async insert(ctx: Ctx) {
            const payload = payloadSessionResult.parse(ctx.body)
            
            return tm.runInTransaction(async tx => {
                return sessionResultService.insert(ctx.rctx(), payload, tx)
            })
        },
        
        async delete(ctx: Ctx) {
            const id = ctx.params['id']
            
            return tm.runInTransaction(async tx => {
                return sessionResultService.delete(ctx.rctx(), id, tx)
            })
        },
    }
}