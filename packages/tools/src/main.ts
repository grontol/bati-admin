import _fs from "fs"
import path from "path"
import crypto from "crypto"
import zlib from "zlib"

const fs = _fs.promises

const gzippeds = [
    "html",
    "js",
    "mjs",
    "css",
    "wasm",
]

let baseDir = "../../packages/fe-app/"

type FileData = {
    path: string
    hash: string
    size: number
    gzipSize: number | null
}

async function collectFileRec(dir: string, out: FileData[]) {
    const files = await fs.readdir(dir, { withFileTypes: true })
    
    for (const file of files) {
        const fullPath = path.join(dir, file.name)
        
        if (file.isDirectory()) {
            await collectFileRec(fullPath, out)
        }
        else if (file.isFile()) {
            const buffer = await fs.readFile(fullPath)
            const hash = await hashFile(buffer)
            
            let gzipSize: number | null = null
            
            for (const g of gzippeds) {
                if (fullPath.endsWith(g)) {
                    gzipSize = zlib.gzipSync(buffer).length
                    
                    break
                }
            }
            
            out.push({
                hash,
                path: fullPath.replace(baseDir, ""),
                size: buffer.length,
                gzipSize,
            })
        }
    }
}

async function hashFile(buffer: Buffer) {
    const hash = crypto.createHash("sha256")
    hash.update(buffer)
    
    return hash.digest("hex")
}

const ignores: (string | RegExp)[] = [
    "list.json",
    "manifest.webmanifest",
    "sw.js",
    /workbox-.*\.js/,
    "registerSW.js",
]

async function main() {
    const buildFolder = process.argv[2] ?? "build"
    baseDir += buildFolder + '/'
    
    const files: FileData[] = []
    
    await collectFileRec(baseDir, files)
    
    const withHash = files
        .filter(x => {
            for (const i of ignores) {
                if (i instanceof RegExp) {
                    if (i.test(x.path)) {
                        return false
                    }
                }
                else {
                    if (i === x.path) {
                        return false
                    }
                }
            }
            
            return true
        })
        
    const data = {
        files: withHash
    }
    
    await fs.writeFile(path.join(baseDir, "list.json"), JSON.stringify(data))
    
    const totalSize = data.files.reduce((a, b) => a + (b.gzipSize ?? b.size), 0)
    console.log("Estimated size : ", Math.floor(totalSize / 1024), "KB")
}

main()