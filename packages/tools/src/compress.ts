import fs from "fs"
import { execSync } from "child_process"
import path from "path"

function main() {
    const BASE_DIR = "../fe-app/public/images"
    const files = fs.readdirSync(BASE_DIR)
    
    for (const file of files) {
        if (file.endsWith(".jpg")) {
            console.log("Converting", file)
            execSync(`ffmpeg -i ${path.join(BASE_DIR, file)} -c:v libwebp ${path.join(BASE_DIR, file.replace(".jpg", ".webp"))}`)
        }
    }
}

main()