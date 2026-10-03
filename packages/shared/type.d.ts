type Optional<T, K extends keyof T> = Pick<Partial<T>, K> & Omit<T, K>;
type Omit<T, K extends keyof T> = Pick<T, Exclude<keyof T, K>>
type PartialBy<T, K extends keyof T> = Omit<T, K> & Partial<Pick<T, K>>
type WithRequired<T, K extends keyof T> = T & { [P in K]-?: T[P] }