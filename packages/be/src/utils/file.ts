import fs from 'fs';
import { v4 } from 'uuid';

export async function saveBase64FileMany(base64s: string[], prefix: string): Promise<string[] | null> {
    const res: string[] = []
    
    for (const base64 of base64s) {
        const name = await saveBase64File(base64, prefix)
        
        if (name) {
            res.push(name)
        }
        else {
            // Kalau gagal simpan file, delete file-file yang sebelumnya udah kesimpan
            for (const r of res) {
                removeFileIfExists(r)
            }
            
            return null
        }
    }
    
    return res
}

export async function saveBase64File(base64: string, prefix: string): Promise<string | null> {    
    const parts = base64.split(';base64,')
    const ext = parts[0].split("/")[1]
    const base64Image = parts[1]

    const filePath = `${prefix ? prefix + "_" : ""}${v4()}.${ext}`;

    if (!base64Image) return null
    
    return new Promise((res, rej) => {
        fs.writeFile(`public/uploads/${filePath}`, base64Image, { encoding: 'base64' }, (err) => {
            if (err) {
                res(null)
            }
            else {
                res(filePath)
            }
        })
    })
}

export function removeFileIfExists(path: string) {
    if (!path) return
    
    const filePath = `public/uploads/${path}`
    if (fs.existsSync(filePath)) {
        fs.rmSync(filePath)
    }
}

export function removeFileIfExistsMany(paths: string[]) {
    for (const path of paths) {
        removeFileIfExists(path)
    }
}