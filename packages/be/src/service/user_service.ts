import { Rctx } from "@/ctx"
import { $users } from "@/db/models/user_model"
import { Transaction } from "@/db/transaction"
import { appError } from "@/error"
import { generateToken, hashPassword } from "@/utils/hash"
import { UserData, UserInputData } from "@tahfeedz/shared/types.js"
import { v4 } from "uuid"

export function makeUserService() {
    return {
        async getAll(rctx: Rctx): Promise<UserData[]> {
            return $users.find()
        },
        
        async generateUserToken(rctx: Rctx, userId: string): Promise<string> {
            return generateToken(userId)
        },
        
        async insert(rctx: Rctx, data: UserInputData) {
            await $users.insert({
                ...data,
                password: hashPassword(data.password),
                id: v4(),
            })
        },
        
        async update(rctx: Rctx, id: string, data: UserInputData) {
            await $users.update({
                ...data,
                password: data.password ? hashPassword(data.password) : undefined,
            }, {id})
        },
        
        async delete(rctx: Rctx, id: string, tx: Transaction) {
            await $users.delete({id}, tx)
        },
        
        // Helpers ----------------------------
        async getById(userId: string): Promise<UserData | null> {
            return await $users.findOne({ id: userId })
        },
        
        async getByIdOrErr(userId: string): Promise<UserData> {
            const res = await $users.findOne({ id: userId })
            
            if (!res) appError(`User not found : ${userId}`)
            
            return res
        },
    }
}

export type UserService = ReturnType<typeof makeUserService>