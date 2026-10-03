import { ApiJob, apiPost } from "@tahfeedz/fe-core/data/api.js"
import { UserData } from "@tahfeedz/shared/types.js"

class Api {
    login(username: string, password: string): ApiJob<UserData & { token: string }> {
        return apiPost("auth/login", { username, password })
    }
}

export const AuthApi = new Api()