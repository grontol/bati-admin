import { Db } from "@/db/db"
import { EagerLoader } from "@/db/orm/eager"
import { Column, ColumnBase, ColumnLike, isColumn, isModel, isTable, Model, ModelInstanceFromCols, OptionalModelInstanceFromCols, OrderByColumn, QueryBuilder, Relations, RelationValue, Table } from "@/db/orm/types"
import { Transaction } from "@/db/transaction"
import { appError } from "@/error"
import { ReferenceData } from "@tahfeedz/shared/types.js"

export function makeQueryBuilder<T extends ColumnLike, R extends Relations>(config: {
    table: string,
    columns: Record<string, ColumnBase<any, any, any, any>>,
    selectColumns: string[],
    defaultOrder: string | null,
    eagerLoader: EagerLoader,
    eagerAssociations: string[],
    transformer?: (r: ModelInstanceFromCols<T>) => any

    db: () => Db
}) {
    type Instance = ModelInstanceFromCols<T>

    return class implements QueryBuilder<T, R> {
        private _tx?: Transaction
        
        private _selects: string[] = config.selectColumns.map(x => `${config.table}.${x}`)
        private _selectValues: any[] = []
        private _relations: RelationValue<R>[] = [...config.eagerAssociations] as any
        private _offset: number | null = null
        private _limit: number | null = null
        private _order: string | null = config.defaultOrder
        private _groupBy: string | null = null
        private _conds: string[] = []
        private _whereValues: any[] = []
        private _joins: { expr: string, cond: string, type: "LEFT" | "RIGHT" | "INNER" | "X" }[] = []
        private _joinValues: any[] = []
        private _raw: string | null = null
        private _noTransform = false

        constructor(tx?: Transaction) {
            this._tx = tx
        }
        
        noTransform() {
            this._noTransform = true
            return this
        }

        with(...relations: RelationValue<R>[]) {
            if (typeof relations === 'string') {
                this._relations.push(relations)
            }
            else {
                this._relations.push(...relations)
            }

            return this
        }

        orderBy(order: OrderByColumn<T> | null) {
            this._order = order
            return this
        }

        orderByAny(order: string) {
            this._order = order
            return this
        }

        offset(n: number) {
            this._offset = n
            return this
        }

        limit(n: number) {
            this._limit = n
            return this
        }

        select(...cols: string[]) {
            this._selects = cols
            return this
        }

        addSelect(...cols: string[]) {
            this._selects.push(...cols)
            return this
        }

        addSelectCol(...cols: Column[]) {
            this._selects.push(...cols.map(x => x.name))
            return this
        }
        
        addSelectColAlias(col: Column, alias: string) {
            this._selects.push(`${col.name} AS ${alias}`)
            return this
        }

        addSelectx(strings: TemplateStringsArray, ...values: any[]): QueryBuilder<T, R> {
            let res = ''

            for (let a = 0; a < strings.length; a++) {
                res += strings[a]

                if (a < values.length) {
                    const v = values[a]
                    
                    if (isModel(v)) {
                        if (v._aliased) {
                            res += `${v._originalTableName} ${v._table.name}`
                        }
                        else {
                            res += v._table.name
                        }
                    }
                    else if (isTableOrColumn(v)) {
                        res += v.name
                    }
                    else {
                        res += '?'
                        this._selectValues.push(v)
                    }
                }
            }

            this._selects.push(res)

            return this
        }

        where(cond: OptionalModelInstanceFromCols<T>) {
            for (const k in cond) {
                if ((cond as any)[k] === undefined) continue
                
                if (k in config.columns) {
                    this._conds.push(`${config.table}.${k} <=> ?`)
                }
                else {
                    this._conds.push(`${k} <=> ?`)
                }
                
                this._whereValues.push((cond as any)[k])
            }

            return this
        }

        whereRaw(cond: string, condValues?: any[]) {
            this._conds.push(cond)

            if (condValues) {
                this._whereValues.push(...condValues)
            }

            return this
        }

        wherex(strings: TemplateStringsArray, ...values: any[]): QueryBuilder<T, R> {
            let res = ''

            for (let a = 0; a < strings.length; a++) {
                res += strings[a]

                if (a < values.length) {
                    const value = values[a]

                    if (isModel(value)) {
                        if (value._aliased) {
                            res += `${value._originalTableName} ${value._table.name}`
                        }
                        else {
                            res += value._table.name
                        }
                    }
                    else if (isTableOrColumn(value)) {
                        res += value.name
                    }
                    else if (Array.isArray(value)) {
                        res += value.map(x => '?').join(",")
                        this._whereValues.push(...value)
                    }
                    else {
                        res += '?'
                        this._whereValues.push(value)
                    }
                }
            }

            this._conds.push(res)

            return this
        }

        whereValues(values: Record<string, any>) {
            for (const key in values) {
                this._conds.push(`${key} <=> ?`)
                this._whereValues.push(values[key])
            }

            return this
        }

        join(model: Model<any>, lcol: Column, rcol: Column) {
            this._joins.push({ expr: model._table.name, cond: `${lcol.name} = ${rcol.name}`, type: "INNER" })
            return this
        }

        leftJoin(model: Model<any>, lcol: Column, rcol: Column) {
            this._joins.push({ expr: model._table.name, cond: `${lcol.name} = ${rcol.name}`, type: "LEFT" })
            return this
        }

        rightJoin(model: Model<any>, lcol: Column, rcol: Column) {
            this._joins.push({ expr: model._table.name, cond: `${lcol.name} = ${rcol.name}`, type: "RIGHT" })
            return this
        }

        joinc(expr: string | Model<any> | Table, cond: string, condValues?: any[]) {
            let table: string
            
            if (typeof expr === "string") table = expr
            else if (isTable(expr)) {
                if (expr.aliased) {
                    table = `${expr.originalName} ${expr.name}`
                }
                else {
                    table = expr.name
                }
            }
            else {
                if (expr._table.aliased) {
                    table = `${expr._table.originalName} ${expr._table.name}`
                }
                else {
                    table = expr._table.name
                }
            }
            
            this._joins.push({ expr: table, cond, type: "INNER" })

            if (condValues) {
                this._joinValues.push(...condValues)
            }

            return this
        }

        joinx(strings: TemplateStringsArray, ...values: any[]): QueryBuilder<T, R> {
            let res = ''

            for (let a = 0; a < strings.length; a++) {
                res += strings[a]

                if (a < values.length) {
                    const v = values[a]
                    
                    if (isModel(v)) {
                        if (v._aliased) {
                            res += `${v._originalTableName} ${v._table.name}`
                        }
                        else {
                            res += v._table.name
                        }
                    }
                    else if (isTableOrColumn(v)) {
                        res += v.name
                    }
                    else {
                        res += '?'
                        this._joinValues.push(v)
                    }
                }
            }

            this._joins.push({ expr: res, cond: "", type: "X" })

            return this
        }

        leftJoinc(expr: string | Model<any> | Table, cond: string, condValues?: any[]) {
            let table: string
            
            if (typeof expr === "string") table = expr
            else if (isTable(expr)) {
                if (expr.aliased) {
                    table = `${expr.originalName} ${expr.name}`
                }
                else {
                    table = expr.name
                }
            }
            else {
                if (expr._table.aliased) {
                    table = `${expr._table.originalName} ${expr._table.name}`
                }
                else {
                    table = expr._table.name
                }
            }
            
            this._joins.push({ expr: table, cond, type: "LEFT" })

            if (condValues) {
                this._joinValues.push(...condValues)
            }

            return this
        }

        rightJoinc(expr: string | Model<any> | Table, cond: string, condValues?: any[]) {
            let table: string
            
            if (typeof expr === "string") table = expr
            else if (isTable(expr)) {
                if (expr.aliased) {
                    table = `${expr.originalName} ${expr.name}`
                }
                else {
                    table = expr.name
                }
            }
            else {
                if (expr._table.aliased) {
                    table = `${expr._table.originalName} ${expr._table.name}`
                }
                else {
                    table = expr._table.name
                }
            }
            
            this._joins.push({ expr: table, cond, type: "RIGHT" })

            if (condValues) {
                this._joinValues.push(...condValues)
            }

            return this
        }

        addParams(...params: any[]) {
            this._whereValues.push(...params)

            return this
        }
        
        raw(expr: string, values?: any[]) {
            this._raw = expr
            this._whereValues = [...values ?? []]
            
            return this
        }

        rawx(strings: TemplateStringsArray, ...values: any[]) {
            let res = ''

            for (let a = 0; a < strings.length; a++) {
                res += strings[a]

                if (a < values.length) {
                    const v = values[a]
                    
                    if (isModel(v)) {
                        if (v._aliased) {
                            res += `${v._originalTableName} ${v._table.name}`
                        }
                        else {
                            res += v._table.name
                        }
                    }
                    else if (isTableOrColumn(v)) {
                        res += v.name
                    }
                    else {
                        res += '?'
                        this._whereValues.push(values[a])
                    }
                }
            }

            this._raw = res

            return this
        }
        
        groupBy(expr: string): QueryBuilder<T, R> {
            this._groupBy = expr
            
            return this
        }

        processRowOne(item: any) {
            if (!item) return

            for (const k in config.columns) {
                const column = config.columns[k]
                
                if (item[k]) {
                    if (column.typeStr === "json") {
                        item[k] = JSON.parse(item[k])
                    }
                    else if (column.typeStr === "string_array") {
                        item[k] = item[k].split(",")
                    }
                }
                
                if (column.hidden) {

                    const value = item[k]
                    delete item[k]

                    Object.defineProperty(item, k, {
                        value,
                        enumerable: false,
                        writable: true,
                        configurable: true,
                    })
                }
            }
        }

        processRow(items: any[]) {
            for (const item of items) {
                this.processRowOne(item)
            }
        }

        async getAndPrint<U = Instance>(): Promise<U[]> {
            const q = this.buildQuery()

            const condValues = this.condValues()
            console.log(buildQueryWithValues(q, condValues))

            const res = await (this._tx ?? config.db()).select<U>(q, condValues)
            this.processRow(res)

            if (res.length > 0 && this._relations.length > 0) {
                await config.eagerLoader.load(res, this._relations, null, null, this._tx ?? null)
            }

            return res
        }

        async get<U = Instance>(): Promise<U[]> {
            const res = await (this._tx ?? config.db()).select<U>(this.buildQuery(), this.condValues())
            this.processRow(res)
            
            if (res.length > 0 && this._relations.length > 0) {
                await config.eagerLoader.load(res, this._relations, null, null, this._tx ?? null)
                return res
            }

            if (!this._noTransform && config.transformer) {
                for (let a = 0; a < res.length; a++) {
                    res[a] = config.transformer(res[a] as any)
                }
            }

            return res
        }

        async getReferenced<U = Instance>(): Promise<ReferenceData<U[]>> {
            const res = await (this._tx ?? config.db()).select<U>(this.buildQuery(), this.condValues())
            this.processRow(res)
            
            if (res.length > 0 && this._relations.length > 0) {
                const references: ReferenceData<U[]> = { data: res, includes: {}, references: [] }
                await config.eagerLoader.load(res, this._relations, references, ["data", "[]"], this._tx ?? null)
                
                return references
            }

            if (!this._noTransform && config.transformer) {
                for (let a = 0; a < res.length; a++) {
                    res[a] = config.transformer(res[a] as any)
                }
            }

            return {
                data: res,
                includes: {},
                references: [],
            }
        }

        async getOne<U = Instance>(): Promise<U | null> {
            this._limit = 1

            const res = await (this._tx ?? config.db()).selectOne<U>(this.buildQuery(), this.condValues())
            this.processRowOne(res)

            if (res && this._relations.length > 0) {
                await config.eagerLoader.load([res], this._relations, null, null, this._tx ?? null)
                return res
            }

            if (res && !this._noTransform && config.transformer) {
                return config.transformer(res as any)
            }

            return res
        }

        async getOneOrErr<U = Instance>(): Promise<U> {
            const res = await this.getOne<U>()

            if (!res) {
                appError("Record not found")
            }

            return res
        }

        async getOneField<U = any>(): Promise<U> {
            const res = await this.getOneOrErr() as any

            return res[Object.keys(res)[0]]
        }

        async count(): Promise<number> {
            const res = await (this._tx ?? config.db()).selectOne<{ count: number }>(this.buildQuery(true), this.condValues())
            return res?.count ?? 0
        }

        private condValues(): any[] {
            return [
                ...this._selectValues,
                ...this._joinValues,
                ...this._whereValues,
            ]
        }
        
        private buildQuery(isCount = false): string {
            if (this._raw) return this._raw

            let query = `SELECT ${isCount ? "COUNT(*) as count" : this._selects.join(", ")} FROM ${config.table}`

            if (this._joins.length > 0) {
                for (const j of this._joins) {
                    if (j.type === "X") {
                        query += ' '
                        query += j.expr
                    }
                    else {
                        if (j.type === "LEFT") {
                            query += " LEFT JOIN "
                        }
                        else if (j.type === "RIGHT") {
                            query += " RIGHT JOIN "
                        }
                        else if (j.type === "INNER") {
                            query += " JOIN "
                        }

                        query += `${j.expr} ON ${j.cond}`
                    }
                }
            }

            if (this._conds.length > 0) {
                query += ` WHERE ${this._conds.map(x => `(${x})`).join(' AND ')}`
            }
            
            if (this._groupBy) {
                query += ` GROUP BY ${this._groupBy}`
            }

            if (this._order) {
                query += ` ORDER BY ${this._order}`
            }

            if (this._limit !== null) {
                if (this._offset) {
                    query += ` LIMIT ${this._offset}, ${this._limit}`
                }
                else {
                    query += ` LIMIT ${this._limit}`
                }
            }

            return query
        }
    }
}

function isTableOrColumn(v: any): v is Column | Table {
    return isColumn(v) || isTable(v)
}

function buildQueryWithValues(q: string, values: any[]) {
    let res = ''
    let index = 0

    for (let a = 0; a < q.length; a++) {
        if (q[a] === '?') {
            res += `'${values[index++]}'`
        }
        else {
            res += q[a]
        }
    }

    return res
}