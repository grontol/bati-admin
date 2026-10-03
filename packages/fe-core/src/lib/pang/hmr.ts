import { deepState, isAnyClassInstance, state } from "./reactive.js"

type CompCb = { hotReload: (old: PComponent, newComp: PComponent, changed: boolean) => void }
const compCbMap = new Map<any, Set<CompCb>>()
const newestCompMap = new Map<any, any>()
let _hotReloadId = 0

export function registerCompCb(comp: PComponent, node: CompCb) {
    if (!compCbMap.has(comp)) {
        compCbMap.set(comp, new Set())
    }
    
    compCbMap.get(comp)!.add(node)
}

export function unregisterCompCb(comp: PComponent, node: CompCb) {
    if (!compCbMap.has(comp)) return
    compCbMap.get(comp)!.delete(node)
}

export function updateComp(oldComp: PComponent, newComp: PComponent, hotReload: boolean, invalidate: boolean) {
    if (!oldComp || !newComp || oldComp === newComp) {
        return
    }
    
    newestCompMap.set(oldComp, newComp)
    
    const nodes = [...compCbMap.get(oldComp) ?? []]
    for (const n of nodes) {
        n.hotReload(oldComp, newComp, hotReload || invalidate)
    }
}

export function hotReloadComp(comp: PComponent) {
    const nodes = [...compCbMap.get(comp) ?? []]
    for (const n of nodes) {
        n.hotReload(comp, comp, true)
    }
}

export function getNewestComp(comp: PComponent) {
    let curComp = comp
    
    while (newestCompMap.has(curComp)) {
        let c = newestCompMap.get(curComp)
        if (c === curComp) break
        
        curComp = c
    }
    
    return curComp
}

export function createHmrContext(fileName: string) {
    const w = window as any
    
    return {
        data: { stateMap: {} as any, deepStateMap: {} as any },
        compCountMap: {} as any,
        curCompName: "",
        hotReloadId: 0,
        invalidateId: 0,
        fileName,

        enter(name: string) {
            if (w._$$hotReloadId !== this.hotReloadId) {
                this.hotReloadId = w._$$hotReloadId
                this.compCountMap = {}
            }
        
            if (!(name in this.compCountMap)) {
                this.compCountMap[name] = 0
            }
            else {
                this.compCountMap[name]++
            }
            
            this.curCompName = name + '__' + this.compCountMap[name]
        },

        state(name: string, initial: any) {
            const actualName = this.curCompName + '__' + name
            
            if (w._$$hotReload && actualName in this.data.stateMap && JSON.stringify(this.data.stateMap[actualName].initial) === JSON.stringify(initial)) {
                return this.data.stateMap[actualName].state
            }
            else {
                const s = state(evaluateProxy(initial))
                this.data.stateMap[actualName] = { initial, state: s }
                
                return s
            }
        },

        deepState(name: string, initial: any) {
            const actualName = this.curCompName + '__' + name
            
            if (w._$$hotReload && actualName in this.data.deepStateMap && JSON.stringify(this.data.deepStateMap[actualName].initial) === JSON.stringify(initial)) {
                return this.data.deepStateMap[actualName].state
            }
            else {
                const s = deepState(evaluateProxy(initial))
                this.data.deepStateMap[actualName] = { initial: evaluateProxy(initial), state: s }
                
                return s
            }
        },
        
        startHotReload() {
            w._$$hotReload = true
            w._$$hotReloadId = ++_hotReloadId
        },
        
        endHotReload() {
            w._$$hotReload = undefined
            w._$$hotReloadId = undefined
        },
        
        invalidate() {
            const w = window as any
            
            if (!w._$$invalidateId) {
                w._$$invalidateId = 1
                w._$$invalidateFile = this.fileName
            }
            
            w._$$invalidateId++
        },
            
        shouldInvalidate() {
            if (w._$$invalidateId !== this.invalidateId) {
                this.invalidateId = w._$$invalidateId
                
                return !!w._$$invalidateFile && (w._$$invalidateFile !== this.fileName)
            }
            
            return false
        },
    }
}

export function evaluateProxy(p: any): any {
    if (p === null) return null
    if (p === undefined) return undefined
    
    if (Array.isArray(p)) {
        const ar = []
        
        for (const x of p) {
            ar.push(evaluateProxy(x))
        }
        
        return ar
    }
    
    if (typeof p === "object" && !isAnyClassInstance(p)) {
        const o = {} as any
        
        for (const k in p) {
            o[k] = evaluateProxy(p[k])
        }
        
        return o
    }
    
    return p
}