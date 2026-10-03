import { Rctx } from "@/ctx"
import { $sessionResultDetails, $sessionResults } from "@/db/models/session_result"
import { Transaction } from "@/db/transaction"
import { SessionResultData, SessionResultInputData } from "@tahfeedz/shared/types"
import { v4 } from "uuid"

export function makeSessionResultService() {
    return {
        async getAll(rctx: Rctx): Promise<SessionResultData[]> {            
            return await $sessionResults.query()
                .with("details")
                .get()
        },
        
        async insert(rctx: Rctx, data: SessionResultInputData, tx: Transaction) {
            const id = v4()
            
            await $sessionResults.insert({
                id,
                name: data.name,
                nis: data.nis,
            }, tx)
            
            await $sessionResultDetails.batchInsert(data.details.map(x => ({
                id: v4(),
                session_result_id: id,
                scene: x.scene,
                part: x.part,
                is_passed: x.is_passed,
                score: x.score,
                fluency: x.fluency,
                professionalism: x.professionalism,
                intonation: x.intonation,
                content: x.content,
                feedback: x.feedback,
                suggested_response: x.suggested_response,
            })), tx)
        },
        
        async delete(rctx: Rctx, id: string, tx: Transaction): Promise<any> {
            await $sessionResults.delete({ id }, tx)
            await $sessionResultDetails.delete({ session_result_id: id }, tx)
        },
    }
}

export type SessionResultService = ReturnType<typeof makeSessionResultService>