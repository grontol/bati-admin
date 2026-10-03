import { derived, state } from "@pang"
import { customStorage } from "@pang/storage.js"
import { UserData } from "@tahfeedz/shared/types.js"

class Cls {
    private _userData: State<UserData | null>
    private _name: Obs<string>
    
    private _logoutListeners = new Set<() => void>()
    
    _storage = customStorage
    
    constructor() {
        const s = this._storage.getItem("__tahf_user")
        this._userData = state(s ? JSON.parse(s) : null)
        
        this._name = derived(() => this._userData.value?.name ?? "")
    }
    
    isLogin(): boolean {
        return this._storage.getItem("__tahf_token") !== null
    }
    
    setToken(token: string) {
        this._storage.setItem("__tahf_token", token)
    }
    
    login(user: UserData, token: string) {
        if (this.isLogin()) {
            for (const l of this._logoutListeners) {
                l()
            }
        }
        
        this._storage.setItem("__tahf_user", JSON.stringify(user))
        this._storage.setItem("__tahf_token", token)
        
        this._userData.value = user
    }
    
    logout() {
        for (const l of this._logoutListeners) {
            l()
        }
        
        this._storage.removeItem("__tahf_user")
        this._storage.removeItem("__tahf_token")
        
        this._userData.value = null
    }
    
    get userData(): Obs<UserData | null> {
        return this._userData
    }
    
    get token(): string | null {
        return this._storage.getItem("__tahf_token")
    }
    
    get name(): Obs<string> {
        return this._name
    }
    
    addLogoutListener(listener: () => void) {
        this._logoutListeners.add(listener)
    }
    
    removeLogoutListener(listener: () => void) {
        this._logoutListeners.delete(listener)
    }
}

export const SessionManager = new Cls()