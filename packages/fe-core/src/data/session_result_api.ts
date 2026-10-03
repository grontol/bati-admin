import { apiDelete, apiGet, ApiJob, apiPost } from "@tahfeedz/fe-core/data/api.js"
import { SessionResultData, UserInputData } from "@tahfeedz/shared/types.js"

class Api {
    getAll(): ApiJob<SessionResultData[]> {
        return apiGet("session_result")
    }
    
    insert(data: UserInputData): ApiJob<any> {
        return apiPost("session_result", data)
    }
    
    delete(id: string): ApiJob<any> {
        return apiDelete(`session_result/${id}`)
    }
}

export const SessionResultApi = new Api()