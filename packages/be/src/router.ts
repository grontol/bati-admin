import { makeAuthController } from "@/controller/auth_controller"
import { makeSessionResultController } from "@/controller/session_result_controller"
import { DataProvider, Handler } from "@/ctx"
import { Db } from "@/db/db"
import { makeAuthService } from "@/db/models/auth_service"
import { $sessionResultDetails, $sessionResults } from "@/db/models/session_result"
import { $users } from "@/db/models/user_model"
import { registerModels } from "@/db/orm/registry"
import { makeSessionResultService } from "@/service/session_result_service"
import { makeUserService } from "@/service/user_service"
import { Express, Router } from "express"

export async function router(app: Express, db: Db) {
    const tm = db.makeTransactionManager()
    
    registerModels(db,
        $users,
        
        $sessionResults,
        $sessionResultDetails,
    )
    
    const authService = makeAuthService()
    const userService = makeUserService()
    const sessionResultService = makeSessionResultService()
    
    const authController = makeAuthController(tm, authService)
    const sessionResultController = makeSessionResultController(tm, sessionResultService)
    
    const dataProvider: DataProvider = {
        getUserById: userService.getById,
    }
    
    const handler = new Handler(dataProvider)
    
    group(app, "/api", api => {
        group(api, "/auth", r => {
            r.post("/login", handler.make(authController.login))
        })
        
        group(api, "/session_result", r => {
            r.get("/", handler.make(sessionResultController.getAll))
            r.post("/", handler.make(sessionResultController.insert))
            r.delete("/:id", handler.make(sessionResultController.delete))
        })
    })
}

function group(app: Router, path: string, setup: (r: Router) => void) {
    const router = Router()
    setup(router)
    app.use(path, router)
}