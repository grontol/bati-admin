type Optional<T extends Record<string, any>, K extends keyof T> = Pick<Partial<T>, K> & Omit<T, K>;
type WithRequired<T, K extends keyof T> = T & { [P in K]-?: T[P] }
type Omit<T extends Record<string, any>, K extends keyof T> = Pick<T, Exclude<keyof T, K>>
export type PartialBy<T extends Record<string, any>, K extends keyof T> = Omit<T, K> & Partial<Pick<T, K>>

export type UserData = {
    id: string
    name: string
    username: string
    email: string
}

export type UserInputData = Omit<UserData, 'id'> & { password: string }

export type SessionResultData = {
    id: string
    name: string
    nis: string
    date: string
    
    details?: SessionResultDetailData[]
}

export type SessionResultInputData = Omit<SessionResultData, 'id' | 'date' | 'details'> & {
    details: SessionResultDetailData[]
}

export type SessionResultDetailData = {
    scene: number
    part: number
    is_passed: number
    score: number
    fluency: number
    professionalism: number
    intonation: number
    content: string
    feedback: string
    suggested_response: string
}

export type ReferenceData<T = any> = {
    data: T
    includes: Record<string, Record<string, any>>,
    references: { path: string, include_path: string }[]
}