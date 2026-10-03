import fs from "fs"
import { Db } from "@/db/db"
import { cInt, cString, makeModel } from "@/db/orm/model"
import { registerModels } from "@/db/orm/registry"

const migrationModel = makeModel("migrations", {
    id: cInt().generated().primary(),
    migration: cString(),
    batch: cInt(),
})

async function main() {
    const command = process.argv[2]

    if (command === "create") {
        const name = process.argv[3]
        if (!name) err("Migration create must have a name")
        
        create(name)
    }
    else if (command === "up" || command === "down" || command === "save") {
        const db = await Db.init({
            allowMultipleStatements: true,
        })
        
        await prepareMigrationTable(db)
        registerModels(db, migrationModel)
        
        if (command === "up") {
            await up(db)
        }
        else if (command === "down") {
            const count = process.argv[3] ? parseInt(process.argv[3]) : 1
            await down(db, count)
        }
        else {
            await save(db)
        }
        
        db.deinit()
    }
    else {
        console.error("Unknown command")
    }
}

main()

function create(name: string) {
    const timestamp = new Date().getTime()
    const filename = `src/migrations/${timestamp}_${name}.sql`
    
    fs.writeFileSync(filename, "")
    
    console.log("Migration created:")
    console.log('-', filename)
}

async function up(db: Db) {    
    const files = fs.readdirSync("src/migrations")
        .sort((a, b) => a.localeCompare(b, "en", { numeric: true }))
        .filter(x => x.endsWith(".sql"))
        .map(x => ({
            name: x.slice(0, -4),
            path: `src/migrations/${x}`
        }))
    
    const placeholders = files.map(() => '?').join(",")
    const values = files.map(x => x.name)
        
    const exists = await db.select<{ migration: string }>(`SELECT * FROM migrations WHERE migration IN(${placeholders})`, values)
    
    const toMigrate = files
        .filter(x => !exists.some(y => y.migration === x.name))
    
    const lastBatch = await db.selectOne<{ batch: number }>(`SELECT IFNULL(MAX(batch), 0) as batch FROM migrations`)
    const newBatch = lastBatch!.batch + 1
    
    if (toMigrate.length === 0) {
        console.log("Nothing to migrate")
        
        return
    }
    
    const tm = db.makeTransactionManager()
    try {
        await tm.runInTransaction(async tx => {
            for (const i of toMigrate) {
                await migrationModel.insert({
                    migration: i.name,
                    batch: newBatch,
                }, tx)
                
                const query = fs.readFileSync(i.path).toString()
                const up = query.split("---###---")[0].trim()
                
                if (up) {
                    try {
                        console.log("\u001b[96mMigrating", i.name)
                        
                        await tx.write(up)
                    }
                    catch (e: any) {
                        console.log()
                        console.log("\u001b[31m-----------------------")
                        console.log("Migration failed")
                        console.log("-----------------------")
                        console.log(e?.message)
                        
                        console.log("\nAt:")
                        console.log(i.path)
                        
                        throw e
                    }
                }
            }
        })
        
        console.log()
        console.log("\u001b[32m-----------------------")
        console.log("Migration success")
        console.log("-----------------------")
    }
    catch (e: any) {
        console.error(e)
    }
}

async function down(db: Db, count: number) {
    let where = ''
    
    if (count > 0) {
        where = `
            WHERE batch > (
                SELECT max_batch FROM (
                    SELECT MAX(batch) AS max_batch FROM migrations
                ) AS temp
            ) - ${count}
        `
    }
    
    const migrations = await db.select<{ migration: string }>(`SELECT * FROM migrations ${where} ORDER BY migration DESC`)
    
    if (migrations.length === 0) {
        console.log("Nothing to migrate down")
        return
    }
    
    const tm = db.makeTransactionManager()
    try {
        await tm.runInTransaction(async tx => {
            await tx.write(`DELETE FROM migrations ${where}`)
            
            for (const m of migrations) {
                const path = `src/migrations/${m.migration}.sql`
                if (!fs.existsSync(path)) continue
                
                const query = fs.readFileSync(path).toString()
                const down = query.split("---###---")[1]?.trim()
                
                if (down) {
                    try {
                        console.log("\u001b[96mMigrating down", m.migration)
                        await tx.write(down)
                    }
                    catch (e: any) {
                        console.log()
                        console.log("\u001b[31m-----------------------")
                        console.log("Migration failed")
                        console.log("-----------------------")
                        console.log(e?.message)
                        
                        console.log("\nAt:")
                        console.log(path)
                        
                        throw e
                    }
                }
            }
        })
        
        console.log()
        console.log("\u001b[32m-----------------------")
        console.log("Migration down success")
        console.log("-----------------------")
    }
    catch (e: any) {
        console.error(e)
    }
}

async function save(db: Db) {
    const files = fs.readdirSync("src/migrations")
        .sort((a, b) => a.localeCompare(b, "en", { numeric: true }))
        .filter(x => x.endsWith(".sql"))
        .map(x => ({
            name: x.slice(0, -4),
            path: `src/migrations/${x}`
        }))
    
    const placeholders = files.map(() => '?').join(",")
    const values = files.map(x => x.name)
        
    const exists = await db.select<{ migration: string }>(`SELECT * FROM migrations WHERE migration IN(${placeholders})`, values)
    
    const toMigrate = files.filter(x => !exists.some(y => y.migration === x.name))
    
    const lastBatch = await db.selectOne<{ batch: number }>(`SELECT IFNULL(MAX(batch), 0) as batch FROM migrations`)
    const newBatch = lastBatch!.batch + 1
    
    if (toMigrate.length === 0) {
        console.log("Nothing to migrate")
        
        return
    }
    
    await migrationModel.batchInsert(toMigrate.map(x => ({ batch: newBatch, migration: x.name })))
    
    console.log("\u001b[32m-----------------------")
    console.log("Migration save success")
    console.log("-----------------------")
}

async function prepareMigrationTable(db: Db) {
    const res = await db.selectOne<{ count: number }>(`
        SELECT COUNT(*) as count
        FROM information_schema.TABLES
        WHERE TABLE_SCHEMA = ?
        AND TABLE_NAME = 'migrations'
    `, [db.name])
    
    if (!res?.count) {
        await db.write(`
            CREATE TABLE migrations (
                id INT PRIMARY KEY AUTO_INCREMENT,
                migration VARCHAR(255) NOT NULL,
                batch INT NOT NULL
            )
        `)
    }
}

function err(message: string): never {
    console.error(message)
    process.exit(1)
}