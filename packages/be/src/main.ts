import { config } from "dotenv"
config()

import { Db } from "@/db/db"
import { router } from "@/router"
import cors from "cors"
import express from "express"
import moment from "moment-timezone"

async function main() {
    moment.tz.setDefault("Asia/Jakarta")
    
    const app = express()
    
    app.enable("trust proxy")
    app.use(cors())
    app.use(express.static('public'))
    app.use(express.json({ limit: '50mb' }))

    const db = await Db.init()    
    await router(app, db)

    app.get("/", (req, res) => {
        res.send("BaTi API active...")
    })

    const host = process.env.APP_HOST ?? "0.0.0.0"
    const port = parseInt(process.env.APP_PORT ?? "8080")
    
    console.log(`Listening on http://${host}:${port}`)
    app.listen(port, host)
}

main()