export const months = [
    "Januari", "Februari", "Maret", "April", "Mei", "Juni",
    "Juli", "Agustus", "September", "Oktober", "November", "Desember",
]

export const days = ["Minggu", "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"] as const
export const daysFromSen = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu"] as const
export const daysShort = ["Min", "Sen", "Sel", "Rab", "Kam", "Jum", "Sab"] as const
export const daysShortFromSen = ["Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Min"] as const

export const daysIndexed = [
    { day: 0, text: "Minggu" },
    { day: 1, text: "Senin" },
    { day: 2, text: "Selasa" },
    { day: 3, text: "Rabu" },
    { day: 4, text: "Kamis" },
    { day: 5, text: "Jumat" },
    { day: 6, text: "Sabtu" },
] as const

export const daysFromSenIndexed = [
    { day: 1, text: "Senin" },
    { day: 2, text: "Selasa" },
    { day: 3, text: "Rabu" },
    { day: 4, text: "Kamis" },
    { day: 5, text: "Jumat" },
    { day: 6, text: "Sabtu" },
    { day: 0, text: "Minggu" },
] as const

export const daysShortIndexed = [
    { day: 0, text: "Min" },
    { day: 1, text: "Sen" },
    { day: 2, text: "Sel" },
    { day: 3, text: "Rab" },
    { day: 4, text: "Kam" },
    { day: 5, text: "Jum" },
    { day: 6, text: "Sab" },
] as const

export const daysShortFromSenIndexed = [
    { day: 1, text: "Sen" },
    { day: 2, text: "Sel" },
    { day: 3, text: "Rab" },
    { day: 4, text: "Kam" },
    { day: 5, text: "Jum" },
    { day: 6, text: "Sab" },
    { day: 0, text: "Min" },
] as const

type DateFormat = "y-m-d" | "d/m/y" | "timestamp" | "time" | "time-dot" |
    "indo-date" | "indo-date-short" | "indo-date-with-day" | "indo-date-short-with-day" | "indo-date-complete" |
    "ago" | "indo-date-ago" | "future-day" | "hms" | "day"
    
const SECONDS_MS = 1000
const MINUTES_MS = 60 * SECONDS_MS
const HOURS_MS = 60 * MINUTES_MS
const DAYS_MS = 24 * HOURS_MS
const WEEKS_MS = 7 * DAYS_MS
const MONTHS_MS = 30 * DAYS_MS

function dateFormatYMD(date: Date) {
    return `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, '0')}-${date.getDate().toString().padStart(2, '0')}`
}

function dateFormatDMY(date: Date) {
    return `${date.getDate().toString().padStart(2, '0')}/${(date.getMonth() + 1).toString().padStart(2, '0')}/${date.getFullYear()}`
}

function dateFormatTimestamp(date: Date) {
    return `${dateFormatYMD(date)} ${date.getHours().toString().padStart(2, '0')}:${date.getMinutes().toString().padStart(2, '0')}:${date.getSeconds().toString().padStart(2, '0')}`
}

function dateFormatTime(date: Date) {
    const h = date.getHours()
    const m = date.getMinutes()
    
    return `${h}:${m.toString().padStart(2, '0')}`
}

function dateFormatTimeDot(date: Date) {
    const h = date.getHours()
    const m = date.getMinutes()
    
    return `${h}.${m.toString().padStart(2, '0')}`
}

function dateFormatIndoDate(date: Date) {
    const y = date.getFullYear()
    const m = months[date.getMonth()]
    const d = date.getDate()
    
    return `${d} ${m} ${y}`
}

function dateFormatIndoDateShort(date: Date) {
    const y = date.getFullYear()
    const m = months[date.getMonth()].substring(0, 3)
    const d = date.getDate()
    
    return `${d} ${m} ${y}`
}

function dateFormatIndoDateWithDay(date: Date) {
    const day = days[date.getDay()]
    const y = date.getFullYear()
    const m = months[date.getMonth()]
    const d = date.getDate()
    
    return `${day}, ${d} ${m} ${y}`
}

function dateFormatIndoDateShortWithDay(date: Date) {
    const day = days[date.getDay()]
    const y = date.getFullYear()
    const m = months[date.getMonth()].substring(0, 3)
    const d = date.getDate()
    
    return `${day}, ${d} ${m} ${y}`
}

function dateFormatIndoDateComplete(date: Date) {
    const day = days[date.getDay()]
    const y = date.getFullYear()
    const m = months[date.getMonth()]
    const d = date.getDate()
    const h = date.getHours().toString().padStart(2, '0')
    const mi = date.getMinutes().toString().padStart(2, '0')
    
    return `${day}, ${d} ${m} ${y} ${h}:${mi} WIB`
}

function day(date: Date) {
    return days[date.getDay()]
}

function dateFormatHms(date: Date) {
    const h = date.getHours().toString().padStart(2, '0')
    const m = date.getMinutes().toString().padStart(2, '0')
    const s = date.getSeconds().toString().padStart(2, '0')
    
    return `${h}:${m}:${s}`
}

function dateFormatAgo(date: Date) {
    const d = new Date()
    const diff = d.getTime() - date.getTime()
    
    if (diff < MINUTES_MS) {
        return `Baru saja`
    }
    else if (diff < HOURS_MS) {
        return `${Math.floor(diff / MINUTES_MS) % 60} menit yang lalu`
    }
    else if (diff < DAYS_MS) {
        return `${Math.floor(diff / HOURS_MS) % 24} jam yang lalu`
    }
    else if (diff < 2 * DAYS_MS) {
        return "Kemarin"
    }
    else {
        return dateFormatIndoDate(date)
    }
}

function dateFormatIndoDateAgo(date: Date) {
    const d = new Date()
    const yesterday = new Date()
    yesterday.setDate(yesterday.getDate() - 1)
    
    if (date.getFullYear() == d.getFullYear() && date.getMonth() === d.getMonth() && date.getDate() === d.getDate()) {
        return "Hari ini"
    }
    else if (date.getFullYear() == yesterday.getFullYear() && date.getMonth() === yesterday.getMonth() && date.getDate() === yesterday.getDate()) {
        return "Kemarin"
    }
    else {
        return dateFormatIndoDate(date)
    }
}

function dateFormatFutureDay(date: Date) {
    const dc = new Date()
    const df = new Date(date)
    
    dc.setHours(0, 0, 0, 0)
    df.setHours(0, 0, 0, 0)
    
    const diff = df.getTime() - dc.getTime()
    const diff_days = Math.floor(diff / DAYS_MS)
    
    if (diff_days < 0) {
        return "Selesai"
    }
    else if (diff_days === 0) {
        return "Hari ini"
    }
    else if (diff_days === 1) {
        return "Besok"
    }
    else if (diff_days < 14) {
        return `${diff_days} hari lagi`
    }
    else if (diff_days < 30) {
        return `${Math.floor(diff_days / 7)} minggu lagi`
    }
    else {
        return `${Math.floor(diff_days / 30)} bulan lagi`
    }
}

export function dateGetMonth(month: number): string {
    return months[month]
}

export function dateGetMonthShort(month: number): string {
    return months[month].substring(0, 3)
}

export function dateGetYearShort(year: number): string {
    return year.toString().substring(2, 4)
}

export function dateFormat(date: Date, format: DateFormat): string {
    if (format === "y-m-d") {
        return dateFormatYMD(date)
    }
    else if (format === "d/m/y") {
        return dateFormatDMY(date)
    }
    else if (format === "timestamp") {
        return dateFormatTimestamp(date)
    }
    else if (format === "time") {
        return dateFormatTime(date)
    }
    else if (format === "time-dot") {
        return dateFormatTimeDot(date)
    }
    else if (format === "indo-date") {
        return dateFormatIndoDate(date)
    }
    else if (format === "indo-date-short") {
        return dateFormatIndoDateShort(date)
    }
    else if (format === "indo-date-with-day") {
        return dateFormatIndoDateWithDay(date)
    }
    else if (format === "indo-date-short-with-day") {
        return dateFormatIndoDateShortWithDay(date)
    }
    else if (format === "indo-date-complete") {
        return dateFormatIndoDateComplete(date)
    }
    else if (format === "ago") {
        return dateFormatAgo(date)
    }
    else if (format === "indo-date-ago") {
        return dateFormatIndoDateAgo(date)
    }
    else if (format === "future-day") {
        return dateFormatFutureDay(date)
    }
    else if (format === "hms") {
        return dateFormatHms(date)
    }
    else if (format === "day") {
        return day(date)
    }
    else {
        return "INVALID_FORMAT"
    }
}

export function dateStringFormat(date: string | null | undefined, format: DateFormat): string {
    if (!date) return ""
    
    return dateFormat(new Date(date), format)
}

export function dateRefineFromImport<T extends Record<string, any>>(data: T, keys: Array<keyof T>) {
    for (const k of keys) {
        if (k in data && typeof data[k] === "string") {
            // @ts-ignore
            data[k] = new Date(data[k])
        }
    }
}

export function dateStringIsToday(date: string): boolean {
    const d = new Date(date)
    const today = new Date()
    
    return d.getFullYear() === today.getFullYear() && d.getMonth() === today.getMonth() && d.getDate() === today.getDate()
}

export function dateNewTodayDateOnly(): Date {
    const d = new Date()
    
    d.setHours(0)
    d.setMinutes(0)
    d.setSeconds(0)
    d.setMilliseconds(0)
    
    return d
}