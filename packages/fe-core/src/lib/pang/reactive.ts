import { customStorage } from "@pang/storage.js"

type EffectRunner = () => void

export type Effect = {
    setDirty: () => void
    dispose: () => void
    run: () => void
    addChild: (child: Effect) => void
    removeChild: (child: Effect) => void
    clearChildren: () => void
    
    readonly root: Effect
    readonly parent: Effect | null
    readonly children?: Set<Effect>
}

type EffectMode = 'immediate' | 'batch'

type EffectConfig = {
    /**
     * Dependency untuk di awal
     */
    deps?: Set<Obs>,
    /**
     * Kalau true, pas awal runner akan dieksekusi
     * Kalau false, pas awal runner gak dieksekusi. Throw error kalau deps / initialDeps nya gak diset
     */
    runOnInit?: boolean,
    /**
     * Kalau true, dependency-nya dikalkukasi ulang tiap effect run
     */
    recalculateDeps?: boolean,
    mode?: EffectMode,
    shouldDiscard?: () => boolean,
    trackNested?: boolean,
}

type ObsImpl<T = any> = Obs<T> & {
    registerEffect: (effect: Effect) => void
    unregisterEffect: (effect: Effect) => void
}

type ObsConfig<T> = {
    equalFn: (prevValue: T, newValue: T) => boolean
}

type StateConfig<T> = ObsConfig<T>

export function state<T>(initial: T, configs?: StateConfig<T>): State<T> {
    return new StateImpl(initial, configs)
}

export function isAnyClassInstance(obj: any) {
    if (obj === null || typeof obj !== 'object' || Array.isArray(obj)) return false
    
    const proto = Object.getPrototypeOf(obj)
    return proto !== Object.prototype && proto !== null
}

export function deepState<T>(init: T): DeepState<T> {
    const target = {
        value: init as any
    }
    
    function createHandler(canIterate = true) {
        const effectsMap = new Map<string | Symbol, Set<Effect>>()
        const obsMap = new Map<string | Symbol, ObsImpl>()
        
        const h = {
            get(target, key) {
                if (key === '_$isProxy') return true
                
                const value = target[key]
                
                if (value === null || value === undefined) {}
                else if (!value._$isProxy && typeof value === 'object' && !isAnyClassInstance(value)) {
                    target[key] = new Proxy(value, createHandler())
                }
                
                if (depsStack.length > 0) {
                    let obs: ObsImpl
                    
                    if (!obsMap.has(key)) {
                        obs = {
                            get value() {
                                return ''
                            },
                            registerEffect(effect) {
                                let effects: Set<Effect>
                                
                                if (effectsMap.has(key)) {
                                    effects = effectsMap.get(key)!
                                }
                                else {
                                    effects = new Set()
                                    effectsMap.set(key, effects)
                                }
                                
                                effects.add(effect)
                            },
                            unregisterEffect(effect) {
                                effectsMap.get(key)?.delete(effect)
                            },
                        }
                        
                        obsMap.set(key, obs)
                    }
                    else {
                        obs = obsMap.get(key)!
                    }
                    
                    depsStack[depsStack.length - 1]?.add(obs)
                }
                
                return target[key]
            },
            set(target, key, newValue) {
                target[key] = newValue
                
                const effects = effectsMap.get(key)
                
                if (effects) {
                    const effs = [...effects]
                    
                    for (const effect of effs) {
                        effect.setDirty()
                    }
                }
                
                return true
            },
        } as ProxyHandler<any>
        
        if (!canIterate) {
            h.ownKeys = (target) => {
                throw new Error("Deep state cannot be iterated. Iterate the `.value` instead")
            }
        }
        
        return h
    }
    
    return new Proxy(target, createHandler(false))
}

export function persistentState<T>(id: string, initial: T, configs?: StateConfig<T>): State<T> {
    const actualId = `$$persistent-state-$$${id}`
    const prevValueStr = customStorage.getItem(actualId)
    
    const actualInitial = prevValueStr ? JSON.parse(prevValueStr) : initial
    const state = new StateImpl<T>(actualInitial, configs)
    
    effectInternal(() => {
        customStorage.setItem(actualId, JSON.stringify(state.value))
    }, {
        deps: new Set([state]),
        runOnInit: false,
        recalculateDeps: false,
    })
    
    return state
}

export function effect(fn: EffectRunner, deps?: (Obs | (() => any))[], runOnInit?: boolean): Effect {
    return new EffectImpl(fn, {
        deps: deps ? new Set(deps.map(x => typeof x === "function" ? derived(x) : x)) : undefined,
        runOnInit: runOnInit ?? true,
        recalculateDeps: !deps,
        trackNested: true,
    })
}

export function effectInternal(
    fn: () => void,
    config: EffectConfig
) {
    return new EffectImpl(fn, config)
}

export function effectEmpty(config?: EffectConfig): Effect {
    return new EffectImpl(undefined, config)
}

export function derived<T>(fn: () => T, config?: ObsConfig<T>, deps?: Obs<any>[], noRunOnInitValue?: T): Obs<T> {
    return new DerivedImpl(fn, config, deps ? new Set(deps) : undefined, noRunOnInitValue)
}

export function derivedAsync<T>(fn: () => Promise<T>, fallbackValue: T, deps: (Obs<any> | (() => any))[]): Obs<T> {
    const actualDeps: Obs<any>[] = deps.map(x => typeof x === 'function' ? { get value() { return x() } } : x)
    let lastValue = fallbackValue
    
    const d = new DerivedImpl(() => {
        fn().then(v => {
            d.setLateValue(v)
            lastValue = v
        })
        
        return lastValue
    }, undefined, new Set(actualDeps), fallbackValue, true, false)
    
    return d
}

export function flushPendingEffects() {
    executeEffect()
}

type ObsOf<T extends Record<string, any>> = {
    [K in keyof T]: Obs<T[K]>
}

export function obsify<T extends Record<string, any>>(props: T): ObsOf<T> {
    const res = {} as any
    
    for (const key of Object.getOwnPropertyNames(props)) {
        pushDeps()
        const getter = Object.getOwnPropertyDescriptor(props, key)?.['get']
        const value = getter ? getter() : props[key]
        const deps = popDeps()!
        
        if (deps.size > 0) {
            res[key] = derived(getter ? getter : () => props[key], undefined, [...deps], value)
        }
        else {
            res[key] = new DummyObs(value)
        }
    }
    
    return res
}

export function obs<T>(mayObs: MaybeObs<T>): Obs<T> {
    if (isObs(mayObs)) return mayObs
    else {
        return new DummyObs(mayObs)
    }
}

export function isObs<T>(value: MaybeObs<T>): value is Obs<T> {
    return value instanceof StateImpl || value instanceof DerivedImpl || value instanceof DummyObs
}

export function valueOf<T>(mayObs: MaybeObs<T>): T {
    if (isObs(mayObs)) {
        const value = mayObs.value
        
        if (value === null) return null as T
        if (value === undefined) return undefined as T
        
        return value
    }
    else {
        return mayObs
    }
}

export async function tick() {
    return new Promise(res => {
        setTimeout(res, 0)
    })
}

class StateImpl<T> implements State<T>, ObsImpl {
    private $value: T
    private $effects = new Set<Effect>()
    private $equalFn: (p: T, n: T) => boolean
    
    constructor(initial: T, configs?: StateConfig<T>) {
        if (Array.isArray(initial)) {
            makeArrayProxy(initial, this)
        }
        
        this.$value = initial
        this.$equalFn = configs?.equalFn ?? defaultEqualFn
    }
    
    get value() {
        if (depsStack.length > 0) {
            depsStack[depsStack.length - 1]?.add(this)
        }
        
        return this.$value
    }
    
    set value(newValue: T) {
        if (this.$equalFn(this.$value, newValue)) {
            return
        }
        
        this.$value = newValue
        
        if (Array.isArray(newValue)) {
            makeArrayProxy(newValue, this)
        }
        
        this.trigger()
    }
    
    trigger() {
        const effects = [...this.$effects]
        
        for (const effect of effects) {
            effect.setDirty()
        }
    }
    
    registerEffect(effect: Effect) {
        this.$effects.add(effect)
    }
    
    unregisterEffect(effect: Effect) {
        this.$effects.delete(effect)
    }
}

class EffectImpl implements Effect {
    private $dirty = false
    private $mode: EffectMode
    private $deps?: Set<Obs>
    
    private $fn?: EffectRunner
    private $clientFn?: EffectRunner
    private $shouldDiscard?: () => boolean
    
    private $parent?: Effect
    private $children?: Set<Effect>
    private $manualChildren?: Set<Effect>
    
    private $isDisposed = false
    private $trackNested = false
    
    constructor(fn?: EffectRunner, config?: EffectConfig) {
        this.$mode = config?.mode ?? 'batch'
        this.$shouldDiscard = config?.shouldDiscard
        this.$trackNested = config?.trackNested ?? false
        
        if (fn) {
            if (config?.deps) {
                this.registerDeps(new Set(config.deps))
                
                if (config.runOnInit) {
                    if (config.trackNested) pushEffects()
                    noDeps()
                    fn()
                    popDeps()
                    if (config.trackNested) this.$manualChildren = popEffects() ?? undefined
                }
            }
            else {
                if (!config?.runOnInit) {
                    throw new Error("Effect must have dependencies or runOnInit = true")
                }
                
                if (config.trackNested) pushEffects()
                pushDeps()
                fn()
                this.registerDeps(popDeps()!)
                if (config.trackNested) this.$manualChildren = popEffects() ?? undefined
            }
            
            if (config.recalculateDeps) {
                this.$fn = this.recalculateDeps.bind(this)
            }
            else {
                this.$fn = fn
            }
        }
        
        this.$clientFn = fn
        
        if (effectStack.length > 0) {
            effectStack[effectStack.length - 1]?.add(this)
        }
    }
    
    setDirty() {
        if (this.$mode === 'batch') {
            this.$dirty = true
            queueEffect(this)
        }
        else if (this.$mode === 'immediate') {
            this.$fn?.()
        }
    }
    
    run() {
        if (this.$dirty) {
            this.$dirty = false
            this.$fn?.()
        }
        
        if (this.$children) {
            if (this.$shouldDiscard && this.$shouldDiscard()) {
                for (const c of this.$children) {
                    (c as EffectImpl).discard()
                }
            }
            else {
                for (const c of this.$children) {
                    c.run()
                }
            }
        }
    }
    
    discard() {
        this.$dirty = false
        
        if (this.$children) {
            for (const c of this.$children) {
                (c as EffectImpl).discard()
            }
        }
    }
    
    dispose() {
        if (this.$isDisposed) return
        
        this.unregisterDeps()
        
        if (this.$children) {
            for (const c of this.$children) {
                c.dispose()
            }
            
            this.$children = undefined
        }
        
        this.$isDisposed = true
    }
    
    addChild(child: Effect) {
        if (!this.$children) {
            this.$children = new Set()
        }
        
        this.$children.add(child);
        (child as EffectImpl).$parent = this
    }
    
    removeChild(child: Effect) {
        (child as EffectImpl).$parent = undefined
        
        if (!this.$children) return
        
        this.$children.delete(child)
    }
    
    clearChildren() {
        if (this.$children) {
            for (const c of this.$children) {
                (c as EffectImpl).$parent = undefined
            }
        }
        
        this.$children?.clear()
    }
    
    get children(): Set<Effect> | undefined {
        return this.$children
    }
    
    get parent() {
        return this.$parent ?? null
    }
    
    get root(): Effect {
        if (this.$parent) {
            return this.$parent.root
        }
        else {
            return this
        }
    }
    
    private unregisterDeps() {
        if (this.$deps) {   
            for (const dep of this.$deps) {
                (dep as ObsImpl).unregisterEffect(this)
            }
            
            this.$deps = undefined
        }
    }
    
    private registerDeps(deps: Set<Obs>) {
        for (const dep of deps) {
            (dep as ObsImpl).registerEffect(this)
        }
        
        this.$deps = deps
    }
    
    private recalculateDeps() {
        if (this.$manualChildren) {
            for (const c of this.$manualChildren) {
                c.dispose()
            }
            
            this.$manualChildren = undefined
        }
        
        this.unregisterDeps()
        if (this.$trackNested) pushEffects()
        pushDeps()
        this.$clientFn?.()
        this.registerDeps(popDeps()!)
        if (this.$trackNested) this.$manualChildren = popEffects() ?? undefined
    }
}

class DerivedImpl<T> implements ObsImpl<T> {
    private $value: T | undefined = undefined
    private $selfEffect: Effect
    private $effects = new Set<Effect>()
    private $equalFn: (p: T, n: T) => boolean
    
    constructor(fn: () => T, config?: ObsConfig<T>, deps?: Set<Obs>, noRunOnInitValue?: T, runOnInit?: boolean, recalculateDeps?: boolean) {
        this.$equalFn = config?.equalFn ?? defaultEqualFn
        
        if (noRunOnInitValue !== undefined) {
            this.$value = noRunOnInitValue
        }
        
        let firstRun = true
        
        this.$selfEffect = new EffectImpl(() => {
            const newValue = fn()
            
            if (firstRun || !this.$equalFn(this.$value!, newValue)) {
                this.$value = newValue
                this.trigger()
            }
            else {
                this.$value = newValue
            }
            
            firstRun = false
        }, {
            deps,
            runOnInit: runOnInit ?? noRunOnInitValue === undefined,
            recalculateDeps: recalculateDeps ?? true,
            mode: 'batch',
        })
    }
    
    get value() {
        if (depsStack.length > 0) {
            depsStack[depsStack.length - 1]?.add(this)
        }
        
        return this.$value!
    }
    
    setLateValue(value: T) {
        if (!this.$equalFn(this.$value!, value)) {
            this.$value = value
            this.trigger()
        }
    }
    
    registerEffect(effect: Effect) {
        this.$effects.add(effect)
    }
    
    unregisterEffect(effect: Effect) {
        this.$effects.delete(effect)
    }
    
    private trigger() {
        const effects = [...this.$effects]
        
        for (const effect of effects) {
            effect.setDirty()
        }
    }
}

class DummyObs<T> implements ObsImpl<T> {
    private $value: T
    
    constructor(value: T) {
        this.$value = value
    }
    
    get value() {
        return this.$value
    }
    
    registerEffect(effect: Effect) {}
    unregisterEffect(effect: Effect) {}
    
}

const depsStack: (Set<Obs> | null)[] = []

export function pushDeps() {
    depsStack.push(new Set())
}

export function noDeps() {
    depsStack.push(null)
}

export function popDeps() {
    return depsStack.pop() ?? null
}

export function untrack(cb: () => void) {
    noDeps()
    cb()
    popDeps()
}

const effectStack: (Set<Effect> | null)[] = []

export function pushEffects() {
    effectStack.push(new Set())
}

export function noEffects() {
    effectStack.push(null)
}

export function popEffects() {
    return effectStack.pop() ?? null
}

const effectQueue = new Set<Effect>()

function queueEffect(effect: Effect) {
    if (effectQueue.size === 0) {
        setTimeout(executeEffect, 0)
    }
    
    effectQueue.add(effect.root)
}

function executeEffect() {
    for (const e of effectQueue) {
        e.run()
    }
    
    effectQueue.clear()
}

function defaultEqualFn(prevValue: any, newValue: any): boolean {
    return prevValue === newValue
}

function makeArrayProxy<T>(arr: Array<T>, state: StateImpl<T>): Array<T> {
    const oriPush = arr.push.bind(arr)
    const oriPop = arr.pop.bind(arr)
    const oriSplice = arr.splice.bind(arr)
    
    const oriProto = Array.prototype as any
    const newProto = {} as any
    
    for (const k of Object.getOwnPropertyNames(oriProto)) {
        newProto[k] = oriProto[k]
    }
    
    newProto.push = (...items: T[]) => {
        const res = oriPush(...items)
        state.trigger()
        return res
    }
    
    newProto.pop = () => {
        const res = oriPop()
        state.trigger()
        return res
    }
    
    newProto.splice = (start: number, deleteCount: number, ...items: T[]) => {
        const res = oriSplice(start, deleteCount, ...items)
        state.trigger()
        return res
    }
    
    newProto[Symbol.iterator] = oriProto[Symbol.iterator]
    
    Object.setPrototypeOf(arr, newProto)
    
    return arr
}