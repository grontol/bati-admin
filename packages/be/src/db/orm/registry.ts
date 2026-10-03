import { Db } from "@/db/db"
import { ForeignKeyConfig, isModel, Model, ModelRegistry } from "@/db/orm/types"
import { appError } from "@/error"

export function registerModels(db: Db, ...models: Model<any>[]) {
    const registry = new ModelRegistryImpl(models)
    
    function addForeignKey(table: string, targetModel: Model<any>, targetColumn: string, config: ForeignKeyConfig) {
        const model = registry.get(table)
        
        model.__addForeignKey({
            target: targetModel,
            targetColumn,
            onUpdate: config.mode ?? "restrict",
            onDelete: config.mode ?? "restrict",
        })
    }
    
    for (const model of models) {
        for (const colName in model._foreignKeyConfigs) {
            const fk = model._foreignKeyConfigs[colName]
            const target = fk.target
            
            if (Array.isArray(target)) {
                for (const t of target) {
                    if (isModel(t)) {
                        addForeignKey(t._name, model, colName, fk)
                    }
                    else {
                        addForeignKey(t, model, colName, fk)
                    }
                }
            }
            else {
                if (isModel(target)) {
                    addForeignKey(target._name, model, colName, fk)
                }
                else {
                    addForeignKey(target, model, colName, fk)
                }
            }
        }
    }
    
    for (const model of models) {
        model.__init(db, registry)
    }
}

export class ModelRegistryImpl implements ModelRegistry {
    private models = new Map<string, Model<any>>()
    
    constructor(models: Model<any>[]) {
        for (const model of models) {
            this.models.set(model._name, model)
        }
    }
    
    get(name: string) {
        const model = this.models.get(name)
        
        if (!model) {
            appError(`Cannot find model with name '${name}'`, 500)
        }
        
        return model
    }
    
    getAll(): Map<string, Model<any>> {
        return this.models
    }
}