import fs from "fs"

type Wilayah = {
    kode: string
    nama: string
}

const bentuks = ["SD", "MI", "SMP", "MTs", "SMA", "MA", "MAK", "SMK", "TPA"]

async function getSekolah(wilayah: Wilayah) {
    const file = `data/${wilayah.kode}-${wilayah.nama}.json`

    if (fs.existsSync(file)) {
        return
    }

    console.log("Ambil...", wilayah.nama)

    let got = 0
    let page = 0
    const collected: any[] = []

    while (true) {
        const res = await fetch("https://sekolah.data.kemendikdasmen.go.id/v1/sekolah-service/sekolah/cari-sekolah", {
            method: "POST",
            body: JSON.stringify({
                "page": page,
                "size": 10000,
                "keyword": "",
                "kabupaten_kota": wilayah.nama,
                "bentuk_pendidikan": bentuks.join(", "),
                "status_sekolah": ""
            }),
            headers: {
                "Content-Type": "application/json"
            }
        })

        const json = await res.json()
        const total = json.total as number

        collected.push(...json.data)

        if (total - got <= 10000) {
            break
        }

        got += json.data.length
        page++
    }

    fs.writeFileSync(file, JSON.stringify(collected))
    console.log("Done...")
}

async function main() {
    const wilayahs: Wilayah[] = JSON.parse(fs.readFileSync("data/wilayah.json").toString())

    for (const w of wilayahs) {
        await getSekolah(w)
    }
}

main()