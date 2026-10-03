import { cInt, cString, cTimestamps, hasMany, makeModel } from "@/db/orm/model";

export const $sessionResults = makeModel("session_result", {
    id: cString().primary(),
    name: cString(),
    nis: cString(),
    date: cString().generated(),
    
    ...cTimestamps(),
}, {
    defaultOrder: "created_at DESC",
    
    relations: {
        details: hasMany(() => $sessionResultDetails, { localKey: "id", foreignKey: "session_result_id" })
    }
})

export const $sessionResultDetails = makeModel("session_result_detail", {
    id: cString().primary(),
    session_result_id: cString(),
    scene: cInt(),
    part: cInt(),
    is_passed: cInt(),
    score: cInt(),
    fluency: cInt(),
    professionalism: cInt(),
    intonation: cInt(),
    content: cString(),
    feedback: cString(),
    suggested_response: cString(),
    
    ...cTimestamps(),
})

