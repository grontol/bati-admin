import { cString, cTimestamps, makeModel } from "@/db/orm/model"

export const $users = makeModel("users", {
    id: cString(),
    name: cString(),
    username: cString(),
    email: cString(),
    password: cString().hidden().optional(),
    
    ...cTimestamps(),
}, {
    defaultOrder: "created_at",
})