export interface IStorage {
    getItem(key: string): string | null
    setItem(key: string, value: string): void
    removeItem(key: string): void
}

class CustomStorage implements IStorage {
    getItem(key: string): string | null {
        return localStorage.getItem(`${window.name ? `__$$${window.name}$$__` : ''}${key}`)
    }
    
    setItem(key: string, value: string): void {
        localStorage.setItem(`${window.name ? `__$$${window.name}$$__` : ''}${key}`, value)
    }
    
    removeItem(key: string): void {
        localStorage.removeItem(`${window.name ? `__$$${window.name}$$__` : ''}${key}`)
    }
    
    getKeysWithName(windowName: string): string[] {
        return Object.keys(localStorage).filter(x => x.startsWith(`__$$${windowName}$$__`))
    }
    
    removeItemWithName(windowName: string): void {
        const keys = this.getKeysWithName(windowName)
        
        for (const k of keys) {
            localStorage.removeItem(k)
        }
    }
}

export const customStorage = new CustomStorage()