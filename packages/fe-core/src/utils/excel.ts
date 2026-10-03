import { read, utils } from "xlsx"

export type ReadExcelData = {
    data: string[][]
    filename: string
}

export async function readExcel(): Promise<ReadExcelData | null> {
    return new Promise((res) => {
        const el = document.createElement("input")
        el.type = "file"
        el.accept = ".xls,.xlsx,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        el.click()
        
        el.onchange = () => {
            if (el.files && el.files?.length > 0) {
                const file = el.files[0]
                const reader = new FileReader()
                
                reader.onload = (e) => {
                    const data = new Uint8Array(e.target!.result as any)
                    const workbook = read(data, { type: 'array' })
                    
                    const firstSheetName = workbook.SheetNames[0]
                    const worksheet = workbook.Sheets[firstSheetName]
                    
                    const jsonData = utils.sheet_to_json(worksheet, {
                        raw: false,
                        range: 1,
                        header: 1,
                        defval: "",
                    })
                    
                    res({
                        filename: file.name,
                        data: jsonData as any,
                    })
                }
                
                reader.readAsArrayBuffer(file)
            }
            else {
                return null
            }
        }
        
        el.oncancel = () => {
            res(null)
        }
    })
}