import { Transaction, TransactionManager } from "@/db/transaction";
import { appError, internalError } from "@/error";
import { Pool, PoolConnection, createPool } from "mysql2/promise";

export class Db {
    pool: Pool
    name: string
    
    private useQueryInsteadOfExecute: boolean
    private tm: TransactionManager | null = null
    
    static async init(config?: {
        allowMultipleStatements?: boolean
    }): Promise<Db> {
        const pool = await createPool({
            user: process.env.DB_USER,
            password: process.env.DB_PASS,
            database: process.env.DB_NAME,
            port: parseInt(process.env.DB_PORT ?? "3306"),
            dateStrings: true,
            typeCast(field, next) {
                if (field.type === "TINY" && field.length === 1) {
                    return field.string() === '1'
                }
                
                return next()
            },
            multipleStatements: config?.allowMultipleStatements ?? false,
        
        })
        
        await pool.query("SELECT 1;")
        
        return new Db(pool, process.env.DB_NAME ?? "", config?.allowMultipleStatements ?? false)
    }
    
    private constructor(pool: Pool, name: string, useQueryInsteadOfExecute: boolean) {
        this.pool = pool
        this.name = name
        this.useQueryInsteadOfExecute = useQueryInsteadOfExecute
    }
    
    deinit() {
        try {
            this.pool.end()
        }
        catch(e) {
            
        }
    }
    
    async select<T>(query: string, values?: any[]): Promise<T[]> {
        return await printAndRethrow(query, async () => {
            const conn = await this.createConnection()
            
            try {
                const [rows, fields] = await conn.query(query, values)
                
                return rows as T[]
            }
            finally {
                conn.release()
            }
        })
    }
    
    async selectOne<T>(query: string, values?: any[]): Promise<T | null> {
        return await printAndRethrow(query, async () => {
            const conn = await this.createConnection()
            
            try {
                const [rows, fields] = await conn.query(query, values)
                
                return Array.isArray(rows) && rows.length > 0 ? rows[0] as T : null
            }
            finally {
                conn.release()
            }
        })
    }
    
    async write(query: string, values?: any[]) {        
        return await printAndRethrow(query, async () => {
            const conn = await this.createConnection()
            
            try {
                const [res, fields] = this.useQueryInsteadOfExecute
                    ? await conn.query(query, values)
                    : await conn.execute(query, values)
                
                return res
            }
            finally {
                conn.release()
            }
        })
    }
    
    async lock(table: string, exclusive: boolean, cb: (tx: Transaction) => Promise<any>, tx?: Transaction): Promise<any> {
        if (tx) {
            try {
                await tx.write(`LOCK TABLES ${table} ${exclusive ? 'WRITE' : 'READ'}`)
                return await cb(tx)
            }
            finally {
                await tx.write("UNLOCK TABLES")
            }
        }
        else {
            return await this.makeTransactionManager().runInTransaction(async tx => {
                try {
                    await tx.write(`LOCK TABLES ${table} ${exclusive ? 'WRITE' : 'READ'}`)
                    return await cb(tx)
                }
                finally {
                    await tx.write("UNLOCK TABLES")
                }
            })
        }
    }
    
    private async createConnection(): Promise<PoolConnection> {
        const conn = await this.pool.getConnection()
        await conn.query("SET time_zone='+07:00';")
        
        return conn
    }
    
    makeTransactionManager(): TransactionManager {
        if (this.tm !== null) return this.tm
        
        this.tm = this._makeTransactionManager()
        return this.tm
    }
    
    private _makeTransactionManager(): TransactionManager {
        const thiz = this
        
        return {
            async runInTransaction(fn) {
                const conn = await thiz.createConnection()
                let isRolledBack = false
                
                const tx: Transaction = {
                    async select(query, values) {
                        return await printAndRethrow(query, async () => {
                            const [rows, fields] = await conn.query(query, values)
                            return rows as any[]
                        })
                    },
                    
                    async selectOne(query, values) {
                        return await printAndRethrow(query, async () => {
                            const [rows, fields] = await conn.query(query, values)
                            return Array.isArray(rows) && rows.length > 0 ? rows[0] as any : null
                        })
                    },
                    
                    async write(query, values) {
                        await printAndRethrow(query, async () => {
                            const [res, fields] = thiz.useQueryInsteadOfExecute
                                ? await conn.query(query, values)
                                : await conn.execute(query, values)
                            
                            return res
                        })
                    },
                    
                    async rollback() {
                        await conn.rollback()
                        isRolledBack = true
                    },
                    
                    async commit() {
                        await conn.commit()
                    }
                }
                
                try {
                    conn.beginTransaction()
                    const res = await fn(tx)
                    
                    if (!isRolledBack) {
                        conn.commit()
                    }
                    
                    return res
                }
                catch (e) {
                    conn.rollback()
                    throw e
                }
                finally {
                    conn.release()
                }
            },
        }
    }
}

async function printAndRethrow<T>(q: string, f: () => Promise<T>): Promise<T> {
    try {
        // console.log()
        // console.log("Executing query :")
        // console.log(q)
        // console.log()
        
        return await f()
    }
    catch (e: any) {
        internalError(`\nQuery error :\n${e}\n\nQuery :\n${q}`)
    }
}