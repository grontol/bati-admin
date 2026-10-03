import { apiDelete, apiGet, ApiJob, apiPost, apiPut } from "@tahfeedz/fe-core/data/api.js"
import { UserData, UserInputData } from "@tahfeedz/shared/types.js"

class Api {
    getAll(school_id?: string | null, role?: string | null): ApiJob<UserData[]> {
        const query: string[] = []
        
        if (school_id) query.push(`school_id=${school_id}`)
        if (role) query.push(`role=${role}`)
        
        return apiGet(`user?${query.join("&")}`)
    }
    
    generateUserToken(userId: string): ApiJob<string> {
        return apiGet(`user/generate_user_token/${userId}`)
    }
    
    getInfo(userId: string): ApiJob<UserData> {
        return apiGet(`user/info/${userId}`)
    }
    
    insert(data: UserInputData): ApiJob<any> {
        return apiPost("user", data)
    }
    
    update(id: string, data: UserInputData): ApiJob<any> {
        return apiPut(`user/${id}`, data)
    }
    
    delete(id: string): ApiJob<any> {
        return apiDelete(`user/${id}`)
    }
}

export const UserApi = new Api()