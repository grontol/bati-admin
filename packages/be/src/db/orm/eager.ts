import { Model, ModelRegistry, RelationFunction, Relations, RelationValue } from "@/db/orm/types"
import { Transaction } from "@/db/transaction"
import { internalError } from "@/error"
import { ReferenceData } from "@tahfeedz/shared/types.js"

export class EagerLoader {
    private _name: string
    private _associations: Relations
    private _registry: () => ModelRegistry
    private _transformer: ((r: any) => any) | null
    
    constructor(name: string, associations: Relations, transformer: ((r: any) => any) | null, registry: () => ModelRegistry) {
        this._name = name
        this._associations = associations
        this._transformer = transformer
        this._registry = registry
    }
    
    async load(items: any[], relations: RelationValue<any>[], references: ReferenceData | null, referencePaths: string[] | null, tx: Transaction | null) {
        const relTree: Record<string, RelationValue<any>[]> = {}
        const fnMap: Record<string, RelationFunction<any>> = {}
        
        for (const rel of relations) {
            if (typeof rel === "string") {
                const [head, ...rest] = rel.split(".")
    
                if (!relTree[head]) relTree[head] = []
                if (rest.length) relTree[head].push(rest.join("."))
            }
            else {
                const [head, ...rest] = rel[0].split(".")
    
                if (!relTree[head]) relTree[head] = []
    
                if (rest.length) {
                    relTree[head].push([rest.join("."), rel[1]])
                }
                else {
                    fnMap[head] = rel[1]
                }
            }
        }
        
        for (const relName in relTree) {            
            const assoc = this._associations[relName]
            const fn: RelationFunction<any> | undefined = relName in fnMap ? fnMap[relName] : undefined
            const qfn = assoc.query
            
            if (!assoc) {
                throw new Error(`Relation '${relName}' not defined on model '${this._name}'`)
            }
    
            const targetModel = typeof assoc.model === "string"
                ? this._registry().get(assoc.model)
                : assoc.model()
            
            const localKey = assoc.localKey
            const foreignKey = assoc.foreignKey
        
            const nested: RelationValue<any>[] = relTree[relName]
    
            if (typeof localKey === "string" && typeof foreignKey === "string") {
                if (assoc.type === "hasOne") {
                    await this.oneToOne(targetModel, relName, items, localKey, foreignKey, fn, qfn, assoc.orderBy, nested, references, referencePaths, tx)
                }
                else if (assoc.type === "belongTo") {
                    await this.oneToOne(targetModel, relName, items, foreignKey, localKey, fn, qfn, assoc.orderBy, nested, references, referencePaths, tx)
                }
                else if (assoc.type === "hasMany") {
                    await this.oneToMany(targetModel, relName, items, localKey, foreignKey, fn, qfn, assoc.orderBy, nested, references, referencePaths, tx)
                }
                else if (assoc.type === "hasOneThrough") {
                    const throughModel = typeof assoc.throughModel === "string"
                        ? this._registry().get(assoc.throughModel)
                        : assoc.throughModel()
                    
                    if (typeof assoc.localThroughKey === "string" && typeof assoc.foreignThroughKey === "string") {       
                        await this.oneToOneThrough(
                            targetModel,
                            throughModel,
                            relName,
                            items,
                            localKey,
                            assoc.localThroughKey,
                            assoc.foreignThroughKey,
                            foreignKey,
                            fn,
                            qfn,
                            assoc.orderBy,
                            nested,
                            references,
                            referencePaths,
                            tx,
                        )
                    }
                    else {
                        internalError("localThroughKey and foreignThroughKey must be a string")
                    }
                }
                else if (assoc.type === "hasManyThrough") {
                    const throughModel = typeof assoc.throughModel === "string"
                        ? this._registry().get(assoc.throughModel)
                        : assoc.throughModel()
                    
                    if (typeof assoc.localThroughKey === "string" && typeof assoc.foreignThroughKey === "string") {       
                        await this.oneToManyThrough(
                            targetModel,
                            throughModel,
                            relName,
                            items,
                            localKey,
                            assoc.localThroughKey,
                            assoc.foreignThroughKey,
                            foreignKey,
                            fn,
                            qfn,
                            assoc.orderBy,
                            nested,
                            references,
                            referencePaths,
                            tx,
                        )
                    }
                    else {
                        internalError("localThroughKey and foreignThroughKey must be a string")
                    }
                }
                else if (assoc.type === "hasOneThrough2") {
                    const throughModel = typeof assoc.throughModel === "string"
                        ? this._registry().get(assoc.throughModel)
                        : assoc.throughModel()
                        
                    const through2Model = typeof assoc.through2Model === "string"
                        ? this._registry().get(assoc.through2Model)
                        : assoc.through2Model()
                    
                    if (typeof assoc.localThroughKey === "string"
                            && typeof assoc.foreignThroughKey === "string"
                            && typeof assoc.localThrough2Key === "string"
                            && typeof assoc.foreignThrough2Key === "string"
                        ) {
                        await this.oneToOneThrough2(
                            targetModel,
                            throughModel,
                            through2Model,
                            relName,
                            items,
                            localKey,
                            assoc.localThroughKey,
                            assoc.foreignThroughKey,
                            assoc.localThrough2Key,
                            assoc.foreignThrough2Key,
                            foreignKey,
                            fn,
                            qfn,
                            assoc.orderBy,
                            nested,
                            references,
                            referencePaths,
                            tx,
                        )
                    }
                    else {
                        internalError("localThroughKey and foreignThroughKey must be a string")
                    }
                }
            }
            else if (Array.isArray(localKey) && Array.isArray(foreignKey)) {
                if (assoc.type === "hasOne") {
                    await this.oneToOneManyCols(targetModel, relName, items, localKey, foreignKey, fn, qfn, assoc.orderBy, nested, references, referencePaths, tx)
                }
                else if (assoc.type === "belongTo") {
                    await this.oneToOneManyCols(targetModel, relName, items, foreignKey, localKey, fn, qfn, assoc.orderBy, nested, references, referencePaths, tx)
                }
                else if (assoc.type === "hasMany") {
                    await this.oneToManyManyCols(targetModel, relName, items, localKey, foreignKey, fn, qfn, assoc.orderBy, nested, references, referencePaths, tx)
                }
                else {
                    internalError(`'${assoc.type}' not implemented for array key`)
                }
            }
        }
        
        this.transform(items)
    }
    
    private transform(items: any[]) {
        if (this._transformer) {            
            for (let a = 0; a < items.length; a++) {
                items[a] = this._transformer(items[a])
            }
        }
    }
    
    private async oneToOne(
        targetModel: Model<any>,
        relName: string,
        items: any[],
        localKey: string,
        foreignKey: string,
        fn: RelationFunction<any> | undefined,
        qfn: RelationFunction<any> | undefined,
        order: string | undefined,
        nested: RelationValue<any>[],
        references: ReferenceData | null,
        referencePaths: string[] | null,
        tx: Transaction | null,
    ) {        
        const fns: RelationFunction<any>[] = []
        if (fn) fns.push(fn)
        if (qfn) fns.push(qfn)
        
        const targetIds = Array.from(new Set(items.map(x => x[localKey]).filter(Boolean)))
        const relatedRows = await targetModel.whereIn(foreignKey, targetIds, { fns, order, noTransform: true }, tx ?? undefined) as any[]

        const map = new Map<any, any>()

        for (const r of relatedRows) {
            if (!map.has(r[foreignKey])) {
                map.set(r[foreignKey], r)
            }
        }
        
        if (references) {
            let includePath = relName
            let counter = 2
            
            while (includePath in references.includes) {
                includePath = `${relName}_${counter++}`
            }
            
            references.references.push({
                include_path: includePath,
                path: [...(referencePaths ?? []), relName].join("."),
            })
            
            if (referencePaths) {
                if (referencePaths[0] === "data") {
                    referencePaths = ["includes", relName, "{}"]
                }
                else {
                    referencePaths = [...referencePaths, relName]
                }
            }
            
            for (const it of items) {
                const r = map.get(it[localKey]) ?? null
                const id = r?.[foreignKey] ?? null
                
                it[relName] = id
                
                if (id) {
                    if (!references.includes[includePath]) {
                        references.includes[includePath] = {}
                    }
                    
                    if (!(id in references.includes[includePath])) {
                        references.includes[includePath][id] = r
                    }
                }
            }
        }
        else {
            for (const it of items) {
                it[relName] = map.get(it[localKey]) ?? null
            }
        }
        
        if (nested.length > 0) {
            await targetModel.__eagerLoad(relatedRows, nested, references, referencePaths, tx)
        }
        else {
            this.transform(relatedRows)
        }
    }
    
    private async oneToOneThrough(
        targetModel: Model<any>,
        throughModel: Model<any>,
        relName: string,
        items: any[],
        localKey: string,
        localThroughKey: string,
        foreignThroughKey: string,
        foreignKey: string,
        fn: RelationFunction<any> | undefined,
        qfn: RelationFunction<any> | undefined,
        order: string | undefined,
        nested: RelationValue<any>[],
        references: ReferenceData | null,
        referencePaths: string[] | null,
        tx: Transaction | null,
    ) {
        if (items.length === 0) return
        
        const ids = Array.from(new Set(items.map(x => x[localKey]).filter(Boolean)))
        const idsPlaceholder = ids.map(_ => '?').join(", ")
        
        const throughKey = `${throughModel._table}.${localThroughKey}`
        
        const q = targetModel
            .query(tx ?? undefined)
            .noTransform()
            .addSelect(throughKey)
            .joinc(throughModel._table, `${throughModel._table}.${foreignThroughKey} = ${targetModel._table}.${foreignKey}`)
            .whereRaw(`${throughKey} IN (${idsPlaceholder})`, ids)
        
        if (fn) fn(q)
        if (qfn) qfn(q)
        
        if (order) {
            q.orderBy(order)
        }
        
        const relatedRows: any[] = await q.get()
        const map = new Map<any, any>()
        
        for (const r of relatedRows) {
            const key = r[localThroughKey]
            if (!map.has(key)) map.set(key, r)
        }
        
        if (references) {
            let includePath = relName
            let counter = 2
            
            while (includePath in references.includes) {
                includePath = `${relName}_${counter++}`
            }
            
            references.references.push({
                include_path: includePath,
                path: [...(referencePaths ?? []), relName].join("."),
            })
            
            if (referencePaths) {
                if (referencePaths[0] === "data") {
                    referencePaths = ["includes", relName, "{}"]
                }
                else {
                    referencePaths = [...referencePaths, relName]
                }
            }
            
            for (const it of items) {
                const r = map.get(it[localKey]) ?? null
                const id = r?.[foreignKey] ?? null
                
                it[relName] = id
                
                if (id) {
                    if (!references.includes[includePath]) {
                        references.includes[includePath] = {}
                    }
                    
                    if (!(id in references.includes[includePath])) {
                        references.includes[includePath][id] = r
                    }
                }
            }
        }
        else {
            for (const it of items) {
                it[relName] = map.get(it[localKey]) ?? null
            }
        }
        
        if (nested.length > 0) {
            const allRelated = Array.from(map.values()).flatMap(x => x)
            await targetModel.__eagerLoad(allRelated, nested, references, referencePaths, tx)
        }
        else {
            this.transform(relatedRows)
        }
    }
    
    private async oneToOneThrough2(
        targetModel: Model<any>,
        throughModel: Model<any>,
        through2Model: Model<any>,
        relName: string,
        items: any[],
        localKey: string,
        localThroughKey: string,
        foreignThroughKey: string,
        localThrough2Key: string,
        foreignThrough2Key: string,
        foreignKey: string,
        fn: RelationFunction<any> | undefined,
        qfn: RelationFunction<any> | undefined,
        order: string | undefined,
        nested: RelationValue<any>[],
        references: ReferenceData | null,
        referencePaths: string[] | null,
        tx: Transaction | null,
    ) {
        if (items.length === 0) return
        
        const ids = Array.from(new Set(items.map(x => x[localKey]).filter(Boolean)))
        const idsPlaceholder = ids.map(_ => '?').join(", ")
        
        const throughKey = `${throughModel._table}.${localThroughKey}`
        
        const q = targetModel
            .query(tx ?? undefined)
            .noTransform()
            .addSelect(throughKey)
            .joinc(through2Model._table, `${through2Model._table}.${foreignThrough2Key} = ${targetModel._table}.${foreignKey}`)
            .joinc(throughModel._table, `${throughModel._table}.${foreignThroughKey} = ${through2Model._table}.${localThrough2Key}`)
            .whereRaw(`${throughKey} IN (${idsPlaceholder})`, ids)
        
        if (fn) fn(q)
        if (qfn) qfn(q)
        
        if (order) {
            q.orderBy(order)
        }
        
        const relatedRows: any[] = await q.get()
        
        const map = new Map<any, any>()
        
        for (const r of relatedRows) {
            const key = r[localThroughKey]
            if (!map.has(key)) map.set(key, r)
        }
        
        if (references) {
            let includePath = relName
            let counter = 2
            
            while (includePath in references.includes) {
                includePath = `${relName}_${counter++}`
            }
            
            references.references.push({
                include_path: includePath,
                path: [...(referencePaths ?? []), relName].join("."),
            })
            
            if (referencePaths) {
                if (referencePaths[0] === "data") {
                    referencePaths = ["includes", relName, "{}"]
                }
                else {
                    referencePaths = [...referencePaths, relName]
                }
            }
            
            for (const it of items) {
                const r = map.get(it[localKey]) ?? null
                const id = r?.[foreignKey] ?? null
                
                it[relName] = id
                
                if (id) {
                    if (!references.includes[includePath]) {
                        references.includes[includePath] = {}
                    }
                    
                    if (!(id in references.includes[includePath])) {
                        references.includes[includePath][id] = r
                    }
                }
            }
        }
        else {
            for (const it of items) {
                it[relName] = map.get(it[localKey]) ?? null
            }
        }
        
        if (nested.length > 0) {
            const allRelated = Array.from(map.values()).flatMap(x => x)
            await targetModel.__eagerLoad(allRelated, nested, references, referencePaths, tx)
        }
        else {
            this.transform(relatedRows)
        }
    }
    
    private async oneToMany(
        targetModel: Model<any>,
        relName: string,
        items: any[],
        localKey: string,
        foreignKey: string,
        fn: RelationFunction<any> | undefined,
        qfn: RelationFunction<any> | undefined,
        order: string | undefined,
        nested: RelationValue<any>[],
        references: ReferenceData | null,
        referencePaths: string[] | null,
        tx: Transaction | null,
    ) {
        const fns: RelationFunction<any>[] = []
        if (fn) fns.push(fn)
        if (qfn) fns.push(qfn)
        
        const ids = Array.from(new Set(items.map(x => x[localKey]).filter(Boolean)))
        const relatedRows = await targetModel.whereIn(foreignKey, ids, { fns, order, noTransform: true }, tx ?? undefined) as any[]

        const map = new Map<any, any[]>()

        for (const r of relatedRows) {
            const key = r[foreignKey]
            if (!map.has(key)) map.set(key, [])
            map.get(key)!.push(r)
        }

        if (references) {
            if (referencePaths) {
                if (referencePaths[0] === "data") {
                    referencePaths = ["includes", relName, "{}"]
                }
                else {
                    referencePaths = [...referencePaths, relName]
                }
            }
        }
        
        for (const it of items) {
            it[relName] = map.get(it[localKey]) ?? []
        }

        if (nested.length > 0) {
            const allRelated = Array.from(map.values()).flatMap(x => x)
            await targetModel.__eagerLoad(allRelated, nested, references, referencePaths, tx)
        }
        else {
            this.transform(relatedRows)
        }
    }
    
    private async oneToManyThrough(
        targetModel: Model<any>,
        throughModel: Model<any>,
        relName: string,
        items: any[],
        localKey: string,
        localThroughKey: string,
        foreignThroughKey: string,
        foreignKey: string,
        fn: RelationFunction<any> | undefined,
        qfn: RelationFunction<any> | undefined,
        order: string | undefined,
        nested: RelationValue<any>[],
        references: ReferenceData | null,
        referencePaths: string[] | null,
        tx: Transaction | null,
    ) {
        if (items.length === 0) return
        
        const ids = Array.from(new Set(items.map(x => x[localKey]).filter(Boolean)))
        const idsPlaceholder = ids.map(_ => '?').join(", ")
        
        const throughKey = `${throughModel._table}.${localThroughKey}`
        
        const q = targetModel
            .query(tx ?? undefined)
            .noTransform()
            .addSelect(throughKey)
            .joinc(throughModel._table, `${throughModel._table}.${foreignThroughKey} = ${targetModel._table}.${foreignKey}`)
            .whereRaw(`${throughKey} IN (${idsPlaceholder})`, ids)
        
        if (fn) fn(q)
        if (qfn) qfn(q)
        
        if (order) {
            q.orderBy(order)
        }
        
        const relatedRows: any[] = await q.get()
        const map = new Map<any, any[]>()
        
        for (const r of relatedRows) {
            const key = r[localThroughKey]
            if (!map.has(key)) map.set(key, [])
            map.get(key)?.push(r)
        }
        
        if (references) {
            if (referencePaths) {
                if (referencePaths[0] === "data") {
                    referencePaths = ["includes", relName, "{}"]
                }
                else {
                    referencePaths = [...referencePaths, relName]
                }
            }
        }
        
        for (const it of items) {
            it[relName] = map.get(it[localKey]) ?? null
        }
        
        if (nested.length > 0) {
            const allRelated = Array.from(map.values()).flatMap(x => x)
            await targetModel.__eagerLoad(allRelated, nested, references, referencePaths, tx)
        }
        else {
            this.transform(relatedRows)
        }
    }
    
    private async oneToOneManyCols(
        targetModel: Model<any>,
        relName: string,
        items: any[],
        localKey: string[],
        foreignKey: string[],
        fn: RelationFunction<any> | undefined,
        qfn: RelationFunction<any> | undefined,
        order: string | undefined,
        nested: RelationValue<any>[],
        references: ReferenceData | null,
        referencePaths: string[] | null,
        tx: Transaction | null,
    ) {
        const fns: RelationFunction<any>[] = []
        if (fn) fns.push(fn)
        if (qfn) fns.push(qfn)
        
        const targetIds = Array.from(new Set(items.map(x => makeKey(x, localKey))
            .filter(Boolean)))
            .map(x => demakeKey(x))
            
        const relatedRows = await targetModel.whereInMultiColumns(foreignKey, targetIds, { fns, order, noTransform: true }, tx ?? undefined)
        
        const map = new Map<any, any>()
        
        for (const r of relatedRows) {
            const key = makeKey(r, foreignKey)
            
            if (!map.has(key)) {
                map.set(key, r)
            }
        }
        
        if (references) {
            if (referencePaths) {
                if (referencePaths[0] === "data") {
                    referencePaths = ["includes", relName, "{}"]
                }
                else {
                    referencePaths = [...referencePaths, relName]
                }
            }
        }
        
        for (const it of items) {
            it[relName] = map.get(makeKey(it, localKey)) ?? null
        }
        
        if (nested.length > 0) {
            await targetModel.__eagerLoad(relatedRows, nested, references, referencePaths, tx)
        }
        else {
            this.transform(relatedRows)
        }
    }
    
    private async oneToManyManyCols(
        targetModel: Model<any>,
        relName: string,
        items: any[],
        localKey: string[],
        foreignKey: string[],
        fn: RelationFunction<any> | undefined,
        qfn: RelationFunction<any> | undefined,
        order: string | undefined,
        nested: RelationValue<any>[],
        references: ReferenceData | null,
        referencePaths: string[] | null,
        tx: Transaction | null,
    ) {
        const fns: RelationFunction<any>[] = []
        if (fn) fns.push(fn)
        if (qfn) fns.push(qfn)
        
        const ids = Array.from(new Set(items.map(x => makeKey(x, localKey))
            .filter(Boolean)))
            .map(x => demakeKey(x))
            
        const relatedRows = await targetModel.whereInMultiColumns(foreignKey, ids, { fns, order, noTransform: true }, tx ?? undefined)
        
        const map = new Map<any, any[]>()
        
        for (const r of relatedRows) {
            const key = makeKey(r, foreignKey)
            if (!map.has(key)) map.set(key, [])
            map.get(key)!.push(r)
        }
        
        if (references) {
            if (referencePaths) {
                if (referencePaths[0] === "data") {
                    referencePaths = ["includes", relName, "{}"]
                }
                else {
                    referencePaths = [...referencePaths, relName]
                }
            }
        }
        
        for (const it of items) {
            it[relName] = map.get(makeKey(it, localKey)) ?? []
        }
        
        if (nested.length > 0) {
            const allRelated = Array.from(map.values()).flatMap(x => x)
            await targetModel.__eagerLoad(allRelated, nested, references, referencePaths, tx)
        }
        else {
            this.transform(relatedRows)
        }
    }
}

function makeKey(item: any, key: string[]): string {
    const tuple = key.map(x => item[x])
    return tuple.map(x => typeof x === "object" ? JSON.stringify(x) : String(x)).join("|::|")
}

function demakeKey(key: string): any[] {
    return key.split("|::|")
}