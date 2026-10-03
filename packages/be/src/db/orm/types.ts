import { Db } from "@/db/db"
import { Transaction } from "@/db/transaction"
import { ReferenceData } from "@tahfeedz/shared/types.js"

export type ColumnTypeKind = "int" | "float" | "string" | "enum" | "date" | "boolean" | "json" | "string_array"

export type ColumnBase<Type, Req extends boolean = boolean, Gen extends boolean = boolean, NoSel extends boolean = boolean> = {
    type: Type
    typeStr: ColumnTypeKind
    required: Req
    generated: Gen
    noSelect: NoSel
    hidden: boolean
    primary: boolean
    foreignKey: ForeignKeyConfig | null
}

export type BaseColumnType<T extends ColumnBase<any>> = T['type']
    
export type ColumnTypeOf<T extends ColumnBase<any>> =
    T['required'] extends false ? BaseColumnType<T> | null : BaseColumnType<T>

export type ForeignKeyConfig = {
    target: Model<any> | string | Model<any>[] | string[]
    mode?: "restrict" | "cascade"
    errorMessage?: string
}

export type ForeignKey = {
    target: Model<any>
    targetColumn: string
    onUpdate: "restrict" | "cascade"
    onDelete: "restrict" | "cascade"
}
    
export interface ColumnBuilder<Type, Req extends boolean = boolean, Gen extends boolean = boolean, NoSel extends boolean = boolean> {
    optional(): ColumnBuilder<Type, false, Gen, NoSel>
    generated(): ColumnBuilder<Type, Req, true, NoSel>
    primary(): ColumnBuilder<Type, Req, Gen, NoSel>
    hidden(): ColumnBuilder<Type, Req, Gen, NoSel>
    noSelect(): ColumnBuilder<Type, Req, Gen, true>
    foreighKey(config: ForeignKeyConfig): ColumnBuilder<Type, Req, Gen, NoSel>
    build(): ColumnBase<Type, Req, Gen, NoSel>
}

export type MaybeBuilder = ColumnBase<any> | ColumnBuilder<any>

export type UnwrapBuilder<B> =
    B extends ColumnBuilder<infer Type, infer Req, infer Gen, infer Hid>
    ? ColumnBase<Type, Req, Gen, Hid>
    : B

export type ColumnLike = Record<string, MaybeBuilder>

type RemoveNever<T> = {
    [K in keyof T as T[K] extends never ? never : K]: T[K]
}

type RequiredKeys<T extends ColumnLike> = RemoveNever<{
    [K in keyof T]: UnwrapBuilder<T[K]>['required'] extends true ? K : never
}>

type OptionalKeys<T extends ColumnLike> = RemoveNever<{
    [K in keyof T]: UnwrapBuilder<T[K]>['required'] extends false ? K : never
}>

type GeneratedKeys<T extends ColumnLike> = RemoveNever<{
    [K in keyof T]: UnwrapBuilder<T[K]>['generated'] extends true ? K : never
}>

type RequiredNotGeneratedKeys<T extends ColumnLike> = RemoveNever<{
    [K in keyof T]: UnwrapBuilder<T[K]> extends { required: true, generated: false } ? K : never
}>

type NoSelectKeys<T extends ColumnLike> = RemoveNever<{
    [K in keyof T]: UnwrapBuilder<T[K]> extends { noSelect: true } ? K : never
}>

export type ModelInstanceFromCols<T extends ColumnLike> = Omit<{
    [K in keyof RequiredKeys<T>]: ColumnTypeOf<UnwrapBuilder<T[K]>>
} & {
    [K in keyof OptionalKeys<T>]: ColumnTypeOf<UnwrapBuilder<T[K]>> | null
}, keyof NoSelectKeys<T>>

type InsertModelInstanceFromCols<T extends ColumnLike> = {
    [K in keyof GeneratedKeys<T>]?: ColumnTypeOf<UnwrapBuilder<T[K]>> | null
} & {
    [K in keyof RequiredNotGeneratedKeys<T>]: ColumnTypeOf<UnwrapBuilder<T[K]>>
} & {
    [K in keyof OptionalKeys<T>]?: ColumnTypeOf<UnwrapBuilder<T[K]>> | null
}

export type OptionalModelInstanceFromCols<T extends ColumnLike> = {
    [K in keyof T]?: ColumnTypeOf<UnwrapBuilder<T[K]>> | null
}

export type RelationKeys<R extends Relations> = {
    [K in keyof R & string]:
        R[K] extends { model: () => Model<any, infer MR> }
            ? `${K}` | `${K}.${RelationKeys<MR>}`
            : `${K}` | `${K}.${string}`
}[keyof R & string]

export type RelationColumn<T extends ColumnLike> = keyof T & string | (keyof T & string)[]
export type OrderByColumn<T extends ColumnLike> = keyof T & string | `${keyof T & string} DESC`

export type QueryConfig<R extends Relations = any> = {
    relations?: RelationValue<R>[]
}

export type ModelRegistry = {
    get(name: string): Model<any>
    getAll(): Map<string, Model<any>>
}

export type Table = {
    kind: "$table"
    name: string
    toString(): string
    aliased: boolean
    originalName: string
}

export type Column = {
    kind: "$column"
    name: string
    tableName: string
    columnName: string
    toString(): string
}

export function isTable(value: any): value is Table {
    if (!value) return false
    return typeof value === "object" && "kind" in value && value.kind === "$table"
}

export function isColumn(value: any): value is Column {
    if (!value) return false
    return typeof value === "object" && "kind" in value && value.kind === "$column"
}

export function isModel(value: any): value is Model<any> {
    if (!value) return false
    return typeof value === "object" && "_table" in value && isTable(value._table)
}

export type ModelColumns<T> = {
    [K in keyof T as `$${K & string}`]: Column
}

export type Model<T extends ColumnLike, R extends Relations = any> = {
    _name: string
    _humanName: string
    _table: Table
    _aliased: boolean
    _originalTableName: string
    _foreignKeyConfigs: Record<string, ForeignKeyConfig>
    
    __init(db: Db, registry: ModelRegistry): void
    __eagerLoad(items: any[], relations: RelationValue<any>[], references: ReferenceData | null, referencePaths: string[] | null, tx: Transaction | null): Promise<void>
    __addForeignKey(fk: ForeignKey): void,
    
    aliased(name: string): Model<T, R>
    
    find(cond?: OptionalModelInstanceFromCols<T>, query?: QueryConfig<R>, tx?: Transaction): Promise<ModelInstanceFromCols<T>[]>
    findOne(cond: OptionalModelInstanceFromCols<T> | string | number, query?: QueryConfig<R>, tx?: Transaction): Promise<ModelInstanceFromCols<T> | null>
    findOneOrErr(cond: OptionalModelInstanceFromCols<T> | string | number, query?: QueryConfig<R>, tx?: Transaction): Promise<ModelInstanceFromCols<T>>
    
    whereIn(column: string | Column, values: any[], config?: { relations?: RelationValue<R>[], order?: string, fns?: RelationFunction<R>[], noTransform?: boolean }, tx?: Transaction): Promise<ModelInstanceFromCols<T>[]>
    whereInMultiColumns(columns: string[], values: any[][], config?: { relations?: RelationValue<R>[], order?: string, fns?: RelationFunction<R>[], noTransform?: boolean }, tx?: Transaction): Promise<ModelInstanceFromCols<T>[]>
    
    insert(data: InsertModelInstanceFromCols<T>, tx?: Transaction): Promise<any>
    insertIgnore(data: InsertModelInstanceFromCols<T>, tx?: Transaction): Promise<any>
    insertOrUpdate(data: InsertModelInstanceFromCols<T>, tx?: Transaction): Promise<any>
    batchInsert(datas: InsertModelInstanceFromCols<T>[], tx?: Transaction): Promise<any>
    update(data: OptionalModelInstanceFromCols<T>, cond: OptionalModelInstanceFromCols<T>, tx?: Transaction): Promise<any>
    delete(cond: OptionalModelInstanceFromCols<T>, tx: Transaction): Promise<any>
    deleteRaw(cond: string, values: any[], tx: Transaction): Promise<any>
    
    lock(cb: (tx: Transaction) => Promise<any>, tx?: Transaction): Promise<any>
    
    query(tx?: Transaction): QueryBuilder<T, R>
} & ModelColumns<T>

export type ModelInsertInstance<T> = T extends Model<infer U> ? InsertModelInstanceFromCols<U> : never

export type RelationType = "hasOne" | "hasMany" | "belongTo" | "hasManyThrough"
export type ModelResolver<T extends ColumnLike, R extends Relations> = (() => Model<T, R>) | string
    
export type Relation<
    Own extends ColumnLike = any,
    Target extends ColumnLike = any,
    TR extends Relations = any,
    Through extends ColumnLike = any,
    ThR extends Relations = any,
    Through2 extends ColumnLike = any,
    ThR2 extends Relations = any,
    Resolver extends ModelResolver<Target, TR> = ModelResolver<Target, TR>,
    ThResolver extends ModelResolver<Through, ThR> = ModelResolver<Through, ThR>,
    Th2Resolver extends ModelResolver<Through2, ThR2> = ModelResolver<Through2, ThR2>,
> = {
    model: Resolver
    localKey: RelationColumn<Own>
    foreignKey: RelationColumn<Target>
    eager?: boolean
    orderBy?: OrderByColumn<Target>
    query?: (q: QueryBuilder<Target, TR>) => void
} & ({
    type: "hasOne" | "hasMany" | "belongTo"
} | {
    type: "hasManyThrough" | "hasOneThrough"
    throughModel: ThResolver
    localThroughKey: RelationColumn<Through>
    foreignThroughKey: RelationColumn<Through>
} | {
    type: "hasManyThrough2" | "hasOneThrough2"
    throughModel: ThResolver
    through2Model: Th2Resolver
    localThroughKey: RelationColumn<Through>
    foreignThroughKey: RelationColumn<Through>
    localThrough2Key: RelationColumn<Through2>
    foreignThrough2Key: RelationColumn<Through2>
})

export type Relations<T extends ColumnLike = any> = Record<string, Relation<T, any, any>>
export type RelationFunction<R extends Relations> = (q: QueryBuilder<any, R>) => void
export type RelationValueTuple<R extends Relations> = [RelationKeys<R>, RelationFunction<R>]
export type RelationValue<R extends Relations> = RelationKeys<R> | RelationValueTuple<R>

export type ModelDesc<T extends ColumnLike, R extends Relations<T>> = {
    table: string
    columns: T
    relations?: R
    defaultOrder?: keyof T & string,
}

export type ModelInstance<T> = T extends { find: () => Promise<Array<infer A>> } ? A : never

export interface QueryBuilder<T extends ColumnLike, R extends Relations> {
    noTransform(): QueryBuilder<T, R>
    with(...relations: RelationValue<R>[]): QueryBuilder<T, R>
    orderBy(order: OrderByColumn<T> | null): QueryBuilder<T, R>
    orderByAny(order: string): QueryBuilder<T, R>
    offset(n: number): QueryBuilder<T, R>
    limit(n: number): QueryBuilder<T, R>
    select(...cols: string[]): QueryBuilder<T, R>
    addSelect(...cols: string[]): QueryBuilder<T, R>
    addSelectCol(...cols: Column[]): QueryBuilder<T, R>
    addSelectColAlias(col: Column, alias: string): QueryBuilder<T, R>
    addSelectx(strings: TemplateStringsArray, ...values: any[]): QueryBuilder<T, R>
    where(cond: OptionalModelInstanceFromCols<T>): QueryBuilder<T, R>
    whereRaw(cond: string, condValues?: any[]): QueryBuilder<T, R>
    wherex(strings: TemplateStringsArray, ...values: any[]): QueryBuilder<T, R>
    join<X extends ColumnLike>(model: Model<X>, lcol: Column, rcol: Column): QueryBuilder<X & T, R>
    leftJoin<X extends ColumnLike>(model: Model<X>, lcol: Column, rcol: Column): QueryBuilder<T & X, R>
    rightJoin<X extends ColumnLike>(model: Model<X>, lcol: Column, rcol: Column): QueryBuilder<T & X, R>
    joinc<X extends ColumnLike>(expr: string | Model<X> | Table, cond: string, condValues?: any[]): QueryBuilder<T & X, R>
    joinx(strings: TemplateStringsArray, ...values: any[]): QueryBuilder<T, R>
    leftJoinc<X extends ColumnLike>(expr: string | Model<X> | Table, cond: string, condValues?: any[]): QueryBuilder<T & X, R>
    rightJoinc<X extends ColumnLike>(expr: string | Model<X> | Table, cond: string, condValues?: any[]): QueryBuilder<T & X, R>
    groupBy(expr: string): QueryBuilder<T, R>
    addParams(...params: any[]): QueryBuilder<T, R>
    raw(expr: string, values?: any[]): QueryBuilder<T, R>
    rawx(strings: TemplateStringsArray, ...values: any[]): QueryBuilder<T, R>
    
    get<ADD = {}, U = ModelInstanceFromCols<T>>(): Promise<(U & ADD)[]>
    getReferenced<ADD = {}, U = ModelInstanceFromCols<T>>(): Promise<ReferenceData<(U & ADD)[]>>
    getAndPrint<ADD = {}, U = ModelInstanceFromCols<T>>(): Promise<(U & ADD)[]>
    getOne<ADD = {}, U = ModelInstanceFromCols<T>>(): Promise<(U & ADD) | null>
    getOneOrErr<ADD = {}, U = ModelInstanceFromCols<T>>(): Promise<(U & ADD)>
    getOneField<U = any>(): Promise<U>
    
    count(): Promise<number>
}