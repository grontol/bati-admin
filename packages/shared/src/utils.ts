import { ReferenceData } from "./types"

export function dereference<T>(data: ReferenceData<T>): T {
    const derefed = data.data
    const includesMap = new Map<string, any>()
    
    for (const ref of data.references) {
        const includes = data.includes[ref.include_path]
        
        const paths = ref.path.split(".")
        
        dereferenceAction(data, paths, (obj, key) => {
            if (obj[key]) {
                const combinedKey = `${ref.include_path}::${obj[key]}`
                const cached = includesMap.get(combinedKey)
                
                if (cached) {
                    obj[key] = cached
                }
                else {
                    const include = includes[obj[key]]
                    obj[key] = include
                    includesMap.set(combinedKey, include)
                }
            }
        })
    }
    
    return derefed
}

function dereferenceAction(obj: any, paths: string[], cb: (obj: any, key: string) => void) {
    let cur: any = obj
    let last: any = obj
    let key: string | null = null
    
    for (let a = 0; a < paths.length; a++) {
        const path = paths[a]
        
        if (path === "[]") {
            const curAr = cur as Array<any>
            
            for (let b = 0; b < curAr.length; b++) {
                dereferenceAction(curAr[b], paths.slice(a + 1), cb)
            }
            
            return
        }
        else if (path === "{}") {
            const curObj = cur as Record<string, any>
            
            for (const k in curObj) {
                dereferenceAction(curObj[k], paths.slice(a + 1), cb)
            }
            
            return
        }
        else {
            key = path
            last = cur
            cur = cur[path]
        }
    }
    
    cb(last, key ?? "")
}