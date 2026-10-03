export interface Transaction {
    select<T>(query: string, values?: any[]): Promise<T[]>
    selectOne<T>(query: string, values?: any[]): Promise<T | null>
    write(query: string, values?: any[]): Promise<any>
    rollback(): Promise<any>
    commit(): Promise<any>
}

export interface TransactionManager {
    runInTransaction<T>(fn: (tx: Transaction) => Promise<T>): Promise<T>
}