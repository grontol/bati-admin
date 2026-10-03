import { Db } from "@/db/db"
import { EagerLoader } from "@/db/orm/eager"
import { makeQueryBuilder } from "@/db/orm/query_builder"
import { Column, ColumnBase, ColumnBuilder, ColumnLike, ColumnTypeKind, ForeignKey, ForeignKeyConfig, Model, ModelColumns, ModelInstanceFromCols, ModelRegistry, ModelResolver, OptionalModelInstanceFromCols, OrderByColumn, QueryBuilder, QueryConfig, Relation, RelationColumn, RelationFunction, Relations, RelationValue } from "@/db/orm/types"
import { Transaction } from "@/db/transaction"
import { appError, internalError } from "@/error"

function createColumnBuilder<Type>(type: ColumnTypeKind): ColumnBuilder<Type, true, false, false> {
    const column = {
        typeStr: type,
        required: true,
        generated: false,
        primary: false,
        hidden: false,
        noSelect: false,
        foreignKey: null,
    } as ColumnBase<Type, any, any, any>
    
    const builder: ColumnBuilder<Type, true, false, false> = {
        optional() {
            column.required = false
            return builder as any
        },
        
        generated() {
            column.generated = true
            return builder as any
        },
        
        primary() {
            column.primary = true
            return builder as any
        },
        
        hidden() {
            column.hidden = true
            return builder as any
        },
        
        noSelect() {
            column.noSelect = true
            return builder as any
        },
        
        foreighKey(config) {
            column.foreignKey = config
            
            return builder
        },
        
        build() {
            return column
        },
    }
    
    return builder
}

export function cInt() { return createColumnBuilder<number>("int") }
export function cFloat() { return createColumnBuilder<number>("float") }
export function cString() { return createColumnBuilder<string>("string") }
export function cEnum<T>() { return createColumnBuilder<T>("enum") }
export function cStringArray<T>() { return createColumnBuilder<T[]>("string_array") }
export function cDate() { return createColumnBuilder<Date>("date") }
export function cBool() { return createColumnBuilder<boolean>("boolean") }
export function cJson<T>() { return createColumnBuilder<T>("json") }

export function cTimestamps() {
    return {
        created_at: cString().generated().noSelect(),
        updated_at: cString().generated().noSelect(),
        deleted_at: cString().generated().noSelect().optional(),
    }
}

export function cTimestampsWithSelect() {    
    return {
        created_at: cString().generated(),
        updated_at: cString().generated(),
        deleted_at: cString().generated().noSelect().optional(),
    }
}

export function makeModel<T extends ColumnLike, R extends Relations<T> = {}>(
    table: string,
    columnDescs: T,
    config?: {
        relations?: R,
        defaultOrder?: OrderByColumn<T> | OrderByColumn<T>[],
        transformer?: (r: ModelInstanceFromCols<T>) => any,
        humanName?: string,
    }
): Model<T, R> {
    let db: Db | null = null
    let registry: ModelRegistry | null = null
    
    const columns: Record<string, ColumnBase<any>> = {}
    const columnNames: ModelColumns<T> = {} as any
    
    const foreignKeyConfigs: Record<string, ForeignKeyConfig> = {}
    
    for (const k in columnDescs) {
        const col = columnDescs[k]
        
        if ('build' in col) {
            columns[k] = col.build()
        }
        else {
            columns[k] = col
        }
        
        if (columns[k].foreignKey) {
            foreignKeyConfigs[k] = columns[k].foreignKey
        }
        
        (columnNames as any)[`$${k}`] = {
            kind: "$column",
            name: `${table}.${k}`,
            tableName: table,
            columnName: k,
            toString() {
                return this.name
            },
        } satisfies Column
    }
    
    const foreignKeys: ForeignKey[] = []
    
    const idKey = Object.keys(columns).find(key => columns[key].primary) ?? "id"
    const associations: Relations = config?.relations ?? {}
    const eagerAssociations = Object.keys(associations).filter(x => associations[x].eager)
    
    const selectColumns = Object.keys(columns).filter(k => !columns[k].noSelect)
    const eagerLoader = new EagerLoader(table, associations as any, config?.transformer ?? null, () => {
        return registry ?? appError(`Model '${table}' is not registered`, 500)
    })
    
    let defaultOrder: string | null = null
    
    if (config?.defaultOrder) {
        if (Array.isArray(config.defaultOrder)) {
            defaultOrder = config.defaultOrder.map(x => addTableToOrderByColumn(x, table)).join(", ")
        }
        else {
            defaultOrder = addTableToOrderByColumn(config.defaultOrder, table)
        }
    }
    
    function getDb() {
        return db ?? appError(`Model '${table}' is not registered`, 500)
    }
        
    const QueryBuilderImpl = makeQueryBuilder<T, R>({
        table,
        columns,
        selectColumns,
        defaultOrder,
        eagerLoader,
        eagerAssociations,
        db: getDb,
        transformer: config?.transformer,
    })
    
    function newQueryBuilderWithQuery(cond?: OptionalModelInstanceFromCols<T>, query?: QueryConfig<R>, tx?: Transaction) {
        const q = new QueryBuilderImpl(tx)
        
        if (cond) {
            q.where(cond)
        }
        
        const relations: RelationValue<R>[] = [...eagerAssociations] as any
        
        if (query?.relations) {
            relations.push(...query.relations)
        }
        
        if (relations.length > 0) {
            q.with(...relations)
        }
        
        return q
    }
    
    return {        
        _name: table,
        _humanName: config?.humanName ?? table,
        _table: {
            kind: "$table",
            name: table,
            aliased: false,
            originalName: table,
            toString() {
                return this.name
            },
        },
        _aliased: false,
        _originalTableName: table,
        _foreignKeyConfigs: foreignKeyConfigs,
        
        ...columnNames,
        
        __init(_db, _registry) {
            db = _db
            registry = _registry
        },
        
        async __eagerLoad(items, relations, references, referencePaths, tx) {
            const actualRelations = [...relations, ...eagerAssociations]
            await eagerLoader.load(items, actualRelations, references, referencePaths, tx)
        },
        
        __addForeignKey(fk: ForeignKey) {
            foreignKeys.push(fk)
        },
        
        aliased(name: string) {
            const newThis = {
                ...this,
            }
            
            newThis._aliased = true
            newThis._table = {
                kind: "$table",
                name,
                aliased: true,
                originalName: table,
                toString() {
                    return this.name
                },
            }
            
            for (const k in columnNames) {
                (newThis[k] as any) = {
                    kind: "$column",
                    name: `${name}.${(k as string).substring(1)}`,
                    tableName: name,
                    columnName: k,
                    toString() {
                        return this.name
                    },
                } satisfies Column
            }
            
            return newThis
        },
        
        async find(cond, query, tx) {
            return await newQueryBuilderWithQuery(cond, query, tx).get()
        },
        
        async findOne(cond, query, tx) {
            const actualCond = typeof cond === "string" || typeof cond === "number" ? { [idKey]: cond } as any : cond
            
            return await newQueryBuilderWithQuery(actualCond, query, tx).getOne()
        },
        
        async findOneOrErr(cond, query, tx) {
            const res = await this.findOne(cond, query, tx)
            
            if (!res) {
                console.error(`${table}: record '${JSON.stringify(cond)}' not found`)
                appError("Record not found")
            }
            
            return res
        },
        
        async insert(data, tx) {
            const insertColumns: string[] = []
            const insertValues: any[] = []
            
            for (const columnName in columns) {
                const column = columns[columnName]
                
                if (columnName in data) {
                    if ((data as any)[columnName] === undefined) continue
                    
                    let value: any
                    
                    if (column.typeStr === "json") {
                        value = JSON.stringify((data as any)[columnName])
                    }
                    else if (column.typeStr === "string_array") {
                        value = (data as any)[columnName].join(",")
                    }
                    else {
                        value = (data as any)[columnName]
                    }
                    
                    insertColumns.push(columnName)
                    insertValues.push(value)
                }
                else if (column.generated) {}
                else if (column.required) {
                    internalError(`No data for column '${columnName}' when inserting to '${table}'`)
                }
            }
            
            const insertQuery = `
                INSERT INTO \`${table}\` (${insertColumns.join(', ')})
                VALUES (${insertColumns.map(() => '?').join(', ')})
            `
            
            return await (tx ?? getDb()).write(insertQuery, insertValues)
        },
        
        async insertIgnore(data, tx) {
            const insertColumns: string[] = []
            const insertValues: any[] = []
            
            for (const columnName in columns) {
                const column = columns[columnName]
                
                if (columnName in data) {
                    if ((data as any)[columnName] === undefined) continue
                    
                    let value: any
                    
                    if (column.typeStr === "json") {
                        value = JSON.stringify((data as any)[columnName])
                    }
                    else if (column.typeStr === "string_array") {
                        value = (data as any)[columnName].join(",")
                    }
                    else {
                        value = (data as any)[columnName]
                    }
                    
                    insertColumns.push(columnName)
                    insertValues.push(value)
                }
                else if (column.generated) {}
                else if (column.required) {
                    internalError(`No data for column '${columnName}' when inserting to '${table}'`)
                }
            }
            
            const insertQuery = `
                INSERT IGNORE INTO ${table} (${insertColumns.join(', ')})
                VALUES (${insertColumns.map(() => '?').join(', ')})
            `
            
            return await (tx ?? getDb()).write(insertQuery, insertValues)
        },
        
        async insertOrUpdate(data, tx) {
            const insertColumns: string[] = []
            const insertValues: any[] = []
            const updateColumns: string[] = []
            const updateValues: any[] = []
            
            for (const columnName in columns) {
                const column = columns[columnName]
                
                if (columnName in data) {
                    if ((data as any)[columnName] === undefined) continue
                    
                    let value: any
                    
                    if (column.typeStr === "json") {
                        value = JSON.stringify((data as any)[columnName])
                    }
                    else if (column.typeStr === "string_array") {
                        value = (data as any)[columnName].join(",")
                    }
                    else {
                        value = (data as any)[columnName]
                    }
                    
                    insertColumns.push(columnName)
                    insertValues.push(value)
                    
                    if (!column.primary) {
                        updateColumns.push(columnName)
                        updateValues.push(value)
                    }
                }
                else if (column.generated) {}
                else if (column.required) {
                    internalError(`No data for column '${columnName}' when inserting to '${table}'`)
                }
            }
            
            const insertQuery = `
                INSERT INTO ${table} (${insertColumns.join(', ')})
                VALUES (${insertColumns.map(() => '?').join(', ')})
                ON DUPLICATE KEY UPDATE ${updateColumns.map(x => `${x} = ?`).join(", ")}
            `
            
            return await (tx ?? getDb()).write(insertQuery, [...insertValues, ...updateValues])
        },
        
        async batchInsert(datas, tx) {
            if (datas.length === 0) return
            
            const insertColumns: string[] = []
            const insertValues: any[][] = []
            
            for (let a = 0; a < datas.length; a++) {
                const data = datas[a]
                
                for (const columnName in columns) {
                    const column = columns[columnName]
                    
                    if (columnName in data) {
                        if ((data as any)[columnName] === undefined) continue
                        
                        if (a === 0) {
                            insertColumns.push(columnName)
                        }
                        
                        let value: any
                    
                        if (column.typeStr === "json") {
                            value = JSON.stringify((data as any)[columnName])
                        }
                        else if (column.typeStr === "string_array") {
                            value = (data as any)[columnName].join(",")
                        }
                        else {
                            value = (data as any)[columnName]
                        }
                        
                        insertValues.push(value)
                    }
                    else if (column.generated) {}
                    else if (column.required ?? true) {
                        internalError(`No data for column '${columnName}' when inserting to '${table}'`)
                    }
                }
            }
            
            const insertQuery = `
                INSERT INTO ${table} (${insertColumns.join(', ')})
                VALUES ${datas.map(_ => `(${insertColumns.map(_ => '?').join(", ")})`).join(", ")}
            `
            
            return await (tx ?? getDb()).write(insertQuery, insertValues)
        },
        
        async update(data, cond, tx) {
            const updateColumns: string[] = []
            const updateValues: any[] = []
            const condColumns: string[] = []
            const condValues: any[] = []
            
            for (const columnName in columns) {
                if (columnName in data && (data as any)[columnName] !== undefined) {
                    let value: any
                    
                    if (columns[columnName].typeStr === "json") {
                        value = JSON.stringify((data as any)[columnName])
                    }
                    else if (columns[columnName].typeStr === "string_array") {
                        value = (data as any)[columnName].join(",")
                    }
                    else {
                        value = (data as any)[columnName]
                    }
                    
                    updateColumns.push(columnName)
                    updateValues.push(value)
                }
            }
            
            for (const c in cond) {
                condColumns.push(c)
                condValues.push(cond[c])
            }
            
            let updateQuery = `
                UPDATE ${table}
                SET ${updateColumns.map(x => `${x} = ?`).join(", ")}
            `
            
            if (condColumns.length > 0) {
                updateQuery += `WHERE ${condColumns.map(x => `${x} <=> ?`).join(" AND ")}`
            }
            
            if (condValues) {
                updateValues.push(...condValues)
            }
            
            return await (tx ?? getDb()).write(updateQuery, updateValues)
        },
        
        async delete(cond, tx) {
            const conds: string[] = []
            const condValues: any[] = []
            
            for (const k in cond) {
                conds.push(`${k} <=> ?`)
                condValues.push(cond[k])
            }
            
            if (foreignKeys.length > 0) {
                const s = await this.find(cond)
                const ids = s.map(x => (x as any)[idKey])
                
                for (const fk of foreignKeys) {
                    const exists = await fk.target.whereIn(fk.targetColumn, ids)
                    
                    if (exists.length > 0) {
                        if (fk.onDelete === "restrict") {    
                            appError(`Data masih dipakai di ${fk.target._humanName}`)
                        }
                        else {
                            fk.target.deleteRaw(`${fk.targetColumn} IN (${ids.map(_ => '?').join(', ')})`, ids, tx)
                        }
                    }
                }
            }
            
            let q = `DELETE FROM ${table}`
            
            if (conds.length > 0) {
                q += ` WHERE ${conds.join(" AND ")}`
            }
            
            return await (tx ?? getDb()).write(q, condValues)
        },
        
        async deleteRaw(cond, values, tx) {
            if (foreignKeys.length > 0) {
                const s = await this.query().whereRaw(cond, values).get()
                const ids = s.map(x => (x as any)[idKey])
                
                for (const fk of foreignKeys) {
                    const exists = await fk.target.whereIn(fk.targetColumn, ids)
                
                    if (exists.length > 0) {
                        if (fk.onDelete === "restrict") {    
                            appError(`Data masih dipakai di ${fk.target._humanName}`)
                        }
                        else {
                            fk.target.deleteRaw(`${fk.target._table.name}.${fk.targetColumn} IN (${ids.map(_ => '?').join(', ')})`, ids, tx)
                        }
                    }
                }
            }
            
            let q = `DELETE FROM ${table} WHERE ${cond}`
            return await (tx ?? getDb()).write(q, values)
        },
        
        async whereIn(column, values, config?: { relations?: RelationValue<R>[], order?: string, fns?: RelationFunction<R>[], noTransform?: boolean }, tx?: Transaction) {
            if (values.length === 0) return []
        
            const relations = config?.relations ?? []
            const placeholder = values.map(_ => '?').join(", ")
            
            const q = new QueryBuilderImpl(tx)
                .with(...relations)
                .whereRaw(`${column} IN (${placeholder})`, values)
                
            if (config?.order) {
                q.orderBy(config.order)
            }
            
            if (config?.fns) {
                for (const fn of config.fns) {
                    fn(q)
                }
            }
            
            if (config?.noTransform) {
                q.noTransform()
            }
            
            return await q.get()
        },
        
        async whereInMultiColumns(columns, values, config?: { relations?: RelationValue<R>[], order?: string, fns?: RelationFunction<R>[], noTransform?: boolean }, tx?: Transaction) {
            if (values.length === 0) return []
        
            const relations = config?.relations ?? []
            const placeholder = values.map(x => `(${x.map(_ => '?').join(", ")})`).join(", ")
            
            const q = new QueryBuilderImpl(tx)
                .with(...relations)
                .whereRaw(`(${columns.join(", ")}) IN (${placeholder})`, values.flatMap(x => x))
            
            if (config?.order) {
                q.orderBy(config.order)
            }
                
            if (config?.fns) {
                for (const fn of config.fns) {
                    fn(q)
                }
            }
            
            if (config?.noTransform) {
                q.noTransform()
            }
                
            return await q.get()
        },
        
        async lock(cb, tx) {
            return await getDb().lock(table, true, cb, tx)
        },
        
        query(tx) {
            return new QueryBuilderImpl(tx)
        },
        
        toString() {
            return table
        }
    } as const
}

export function hasOne<
    const Own extends ColumnLike,
    const Target extends ColumnLike,
    const TR extends Relations,
    const Res extends ModelResolver<Target, TR>,
>(
    model: Res & ModelResolver<Target, TR>,
    config: {
        localKey: RelationColumn<Own>,
        foreignKey: RelationColumn<Target>,
        eager?: boolean,
        orderBy?: OrderByColumn<Target>,
        query?: (q: QueryBuilder<Target, TR>) => void,
    }
): Relation<Own, Target, TR, any, any, any, any, Res> {
    return {
        model,
        type: "hasOne",
        localKey: config.localKey,
        foreignKey: config.foreignKey,
        eager: config.eager,
        orderBy: config.orderBy,
        query: config.query,
    }
}

export function belongTo<
    const Own extends ColumnLike,
    const Target extends ColumnLike,
    const TR extends Relations,
    const Res extends ModelResolver<Target, TR> = ModelResolver<Target, TR>,
>(
    model: Res & ModelResolver<Target, TR>,
    config: {
        localKey: RelationColumn<Target>,
        foreignKey: RelationColumn<Own>,
        eager?: boolean,
        orderBy?: OrderByColumn<Target>,
        query?: (q: QueryBuilder<Target, TR>) => void,
    }
): Relation<Own, Target, TR, any, any, any, any, Res> {
    return {
        model,
        type: "belongTo",
        localKey: config.localKey,
        foreignKey: config.foreignKey,
        eager: config.eager,
        orderBy: config.orderBy,
        query: config.query,
    }
}

export function hasMany<
    const Own extends ColumnLike,
    const Target extends ColumnLike,
    const TR extends Relations,
    const Res extends ModelResolver<Target, TR> = ModelResolver<Target, TR>,
>(
    model: Res & ModelResolver<Target, TR>,
    config: {
        localKey: RelationColumn<Own>,
        foreignKey: RelationColumn<Target>,
        eager?: boolean,
        orderBy?: OrderByColumn<Target>,
        query?: (q: QueryBuilder<Target, TR>) => void,
    }
): Relation<Own, Target, TR, any, any, any, any, Res> {
    return {
        model,
        type: "hasMany",
        localKey: config.localKey,
        foreignKey: config.foreignKey,
        eager: config.eager,
        orderBy: config.orderBy,
        query: config.query,
    }
}

export function hasOneThrough<
    Own extends ColumnLike,
    Target extends ColumnLike,
    TR extends Relations,
    Through extends ColumnLike,
    ThR extends Relations,
    const Res extends ModelResolver<Target, TR> = ModelResolver<Target, TR>,
>(
    model: Res & ModelResolver<Target, TR>,
    throughModel: ModelResolver<Through, ThR>,
    config: {
        localKey: RelationColumn<Own>,
        localThroughKey: RelationColumn<Through>,
        foreignThroughKey: RelationColumn<Through>,
        foreignKey: RelationColumn<Target>,
        eager?: boolean,
        orderBy?: OrderByColumn<Target>,
        query?: (q: QueryBuilder<Target, TR>) => void,
    }
): Relation<Own, Target, TR, Through, any, any, ThR, Res, any> {
    return {
        model,
        throughModel,
        type: "hasOneThrough",
        localKey: config.localKey,
        localThroughKey: config.localThroughKey,
        foreignThroughKey: config.foreignThroughKey,
        foreignKey: config.foreignKey,
        eager: config.eager,
        orderBy: config.orderBy,
        query: config.query,
    }
}

export function hasManyThrough<
    Own extends ColumnLike,
    Target extends ColumnLike,
    TR extends Relations,
    Through extends ColumnLike,
    ThR extends Relations,
    const Res extends ModelResolver<Target, TR> = ModelResolver<Target, TR>,
>(
    model: Res & ModelResolver<Target, TR>,
    throughModel: ModelResolver<Through, ThR>,
    config: {
        localKey: RelationColumn<Own>,
        localThroughKey: RelationColumn<Through>,
        foreignThroughKey: RelationColumn<Through>,
        foreignKey: RelationColumn<Target>,
        eager?: boolean,
        orderBy?: OrderByColumn<Target>,
        query?: (q: QueryBuilder<Target, TR>) => void,
    }
): Relation<Own, Target, TR, Through, any, any, ThR, Res, any> {
    return {
        model,
        throughModel,
        type: "hasManyThrough",
        localKey: config.localKey,
        localThroughKey: config.localThroughKey,
        foreignThroughKey: config.foreignThroughKey,
        foreignKey: config.foreignKey,
        eager: config.eager,
        orderBy: config.orderBy,
        query: config.query,
    }
}

export function hasOneThrough2<
    Own extends ColumnLike,
    Target extends ColumnLike,
    TR extends Relations,
    Through extends ColumnLike,
    ThR extends Relations,
    Through2 extends ColumnLike,
    ThR2 extends Relations,
    const Res extends ModelResolver<Target, TR> = ModelResolver<Target, TR>,
    const ResT extends ModelResolver<Through, ThR> = ModelResolver<Through, ThR>,
    const ResT2 extends ModelResolver<Through2, ThR2> = ModelResolver<Through2, ThR2>,
>(
    model: Res & ModelResolver<Target, TR>,
    throughModel: ResT & ModelResolver<Through, ThR>,
    through2Model: ResT2 & ModelResolver<Through2, ThR2>,
    config: {
        localKey: RelationColumn<Own>,
        localThroughKey: RelationColumn<Through>,
        foreignThroughKey: RelationColumn<Through>,
        localThrough2Key: RelationColumn<Through2>,
        foreignThrough2Key: RelationColumn<Through2>,
        foreignKey: RelationColumn<Target>,
        eager?: boolean,
        orderBy?: OrderByColumn<Target>,
        query?: (q: QueryBuilder<Target, TR>) => void,
    }
): Relation<Own, Target, TR, Through, ThR, Through2, ThR2, Res, ResT, ResT2> {
    return {
        model,
        throughModel,
        through2Model,
        type: "hasOneThrough2",
        localKey: config.localKey,
        localThroughKey: config.localThroughKey,
        foreignThroughKey: config.foreignThroughKey,
        localThrough2Key: config.localThrough2Key,
        foreignThrough2Key: config.foreignThrough2Key,
        foreignKey: config.foreignKey,
        eager: config.eager,
        orderBy: config.orderBy,
        query: config.query,
    }
}

export function hasManyThrough2<
    Own extends ColumnLike,
    Target extends ColumnLike,
    TR extends Relations,
    Through extends ColumnLike,
    ThR extends Relations,
    Through2 extends ColumnLike,
    ThR2 extends Relations,
    const Res extends ModelResolver<Target, TR> = ModelResolver<Target, TR>,
    const ResT extends ModelResolver<Through, ThR> = ModelResolver<Through, ThR>,
    const ResT2 extends ModelResolver<Through2, ThR2> = ModelResolver<Through2, ThR2>,
>(
    model: Res & ModelResolver<Target, TR>,
    throughModel: ResT & ModelResolver<Through, ThR>,
    through2Model: ResT2 & ModelResolver<Through2, ThR2>,
    config: {
        localKey: RelationColumn<Own>,
        localThroughKey: RelationColumn<Through>,
        foreignThroughKey: RelationColumn<Through>,
        localThrough2Key: RelationColumn<Through2>,
        foreignThrough2Key: RelationColumn<Through2>,
        foreignKey: RelationColumn<Target>,
        eager?: boolean,
        orderBy?: OrderByColumn<Target>,
        query?: (q: QueryBuilder<Target, TR>) => void,
    }
): Relation<Own, Target, TR, Through, ThR, Through2, ThR2, Res, ResT, ResT2> {
    return {
        model,
        throughModel,
        through2Model,
        type: "hasManyThrough2",
        localKey: config.localKey,
        localThroughKey: config.localThroughKey,
        foreignThroughKey: config.foreignThroughKey,
        localThrough2Key: config.localThrough2Key,
        foreignThrough2Key: config.foreignThrough2Key,
        foreignKey: config.foreignKey,
        eager: config.eager,
        orderBy: config.orderBy,
        query: config.query,
    }
}

function addTableToOrderByColumn(column: string, table: string): string {
    const parts = column.split(' ')
    
    if (parts.length === 1) return `${table}.${parts[0]}`
    else return `${table}.${parts[0]} ${parts[1]}`
}