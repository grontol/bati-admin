import { foreach } from "@pang/core.js"
import { derived, effect, state } from "@pang/reactive.js"
import { Icon } from "@tahfeedz/fe-core/components/Icon.jsx"
import { SelectInput } from "@tahfeedz/fe-core/components/input/SelectInput.jsx"
import { TextInput } from "@tahfeedz/fe-core/components/input/TextInput.jsx"
import { countTotalPage, Pagination } from "@tahfeedz/fe-core/components/table/Pagination.jsx"
import { isMobile } from "@tahfeedz/fe-core/lib/utils/device.js"
import { twJoin, twMerge } from "tailwind-merge"

type TableRender<T> = (t: T, i: number) => JSX.Element

export type TableCol<T> = {
    title: string
    render: TableRender<T>
    
    sortable?: boolean
    searchable?: boolean
    searchText?: (i: T) => string
    hidden?: boolean
    style?: { compact?: boolean, align?: 'left' | 'center' | 'right', titleAlign?: 'left' | 'center' | 'right' }
    class?: string
}

type Props<T> = {
    colDefs: TableCol<T>[]
    items: T[]
    mobileRender?: (item: T, index: number) => JSX.Element
    
    expandable?: {
        render: (item: T, index: number) => JSX.Element
        onToggleExpand: (item: T) => void
        isExapanded: (item: T) => boolean
    }
    
    rowSelectable?: {
        onRowSelect: (item: T, index: number) => void
        isRowSelected: (item: T, index: number) => boolean
    }
    
    perPage?: number
    onPerPageChanged?: (value: number) => void
    paginationEnabled?: boolean
    numberColumnEnabled?: boolean
    searchEnabled?: boolean
    hideTotalData?: boolean
    fixedColumnWidth?: boolean
    loading?: boolean
    
    topLeftSlot?: JSX.Element
    
    class?: string
}

export function Table<T>(props: Props<T>) {
    const search = state("")
    const curPage = state(0)
    
    const innerPerPage = state(10)
    const perPage = derived(() => props.perPage ?? innerPerPage.value)
    const paginationEnabled = derived(() => props.paginationEnabled ?? true)
    const numberColumnEnabled = derived(() => props.numberColumnEnabled ?? true)
    const searchEnabled = derived(() => props.searchEnabled ?? true)
    
    const columnCount = derived(() => props.colDefs.length + (numberColumnEnabled.value ? 1 : 0) + (props.expandable ? 1 : 0))
    
    const sortColumnIndex = state(-1)
    const sortColumnMode = state<"asc" | "desc">("asc")
    
    const filteredItems = derived(() => props.items.filter((item, i) => {
        if (!search.value) return true
        
        for (const def of props.colDefs) {
            if (isColumnMatches(def, item, i, search.value)) {
                return true
            }
        }
        
        return false
    }))
    
    const sortedData = derived(() => {
        if (sortColumnIndex.value < 0) return filteredItems.value
        
        const def = props.colDefs[sortColumnIndex.value]
        const texts = filteredItems.value.map(x => {
            let text: string
            
            if (def.searchText) {
                text = def.searchText(x)
            }
            else {
                const rendered = def.render(x, -1)
                if (!rendered || typeof rendered === "object") {
                    return ""
                }
                
                text = def.render(x, -1)?.toString() ?? ''
            }
            
            return text
        })
        
        return filteredItems.value.toSorted((a, b) => {
            const aText = texts[filteredItems.value.indexOf(a)]
            const bText = texts[filteredItems.value.indexOf(b)]
            
            if (sortColumnMode.value === "asc") {
                return aText.localeCompare(bText)
            }
            else {
                return bText.localeCompare(aText)
            }
        })
    })
    
    const paginatedItems = derived(() => {
        if (!paginationEnabled.value) return sortedData.value
        
        const start = curPage.value * perPage.value
        const end = (curPage.value + 1) * perPage.value
        return sortedData.value.slice(start, end)
    })
    
    const toShowItems = paginatedItems
    
    // If curPage is overflowing, set to last page
    effect(() => {
        const totalPage = countTotalPage(filteredItems.value.length, perPage.value)
        
        if (curPage.value >= totalPage) {
            curPage.value = Math.max(0, totalPage - 1)
        }
    })
    
    function handlePerPageChange(value: number) {
        innerPerPage.value = value
        props.onPerPageChanged?.(value)
    }
    
    function sortColumn(index: number) {
        const def = props.colDefs[index]
        
        if (sortColumnIndex.value !== index) {
            sortColumnIndex.value = index
            sortColumnMode.value = "asc"
        }
        else {
            if (sortColumnMode.value === "asc") {
                sortColumnMode.value = "desc"
            }
            else {
                sortColumnIndex.value = -1
            }
        }
    }
    
    function onRowClick(item: T, rowIndex: number) {
        if (props.expandable) {
            props.expandable.onToggleExpand(item)
        }
        else if (props.rowSelectable) {
            props.rowSelectable.onRowSelect(item, rowIndex)
        }
    }
    
    return (
        <div class={twMerge("flex flex-col mt-2", props.class)}>
            <div class="flex gap-1">
                {paginationEnabled.value && (
                    <SelectInput
                        class="w-24"
                        value={perPage.value}
                        options={[ 5, 10, 20, 50, 100, 200, 500, 1000 ]}
                        onChange={v => handlePerPageChange(v)}
                        clearable={false}
                        searchable={false}
                    />
                )}
                
                {props.topLeftSlot}
                
                <div class="flex-1"/>
                
                {searchEnabled.value && (
                    <TextInput
                        placeholder="Search"
                        value={search.value}
                        onChange={v => search.value = v}
                    />
                )}
            </div>
            
            {isMobile().value && props.mobileRender ? (
                <div class="flex flex-col gap-2 my-2">
                    {foreach(paginatedItems.value, props.mobileRender)}
                </div>
            ) : <>
                <div
                    class="flex flex-col mt-2 mb-2"
                >
                    <table
                        class={twMerge(
                            "bg-white/10 rounded",
                            props.fixedColumnWidth && "table-fixed",
                        )}
                    >
                        <thead>
                            <tr>
                                {props.expandable && <td/>}
                                
                                {numberColumnEnabled.value && (
                                    <th
                                        class="p-3 text-black-medium text-sm"
                                    >#</th>
                                )}
                                
                                {foreach(props.colDefs, (def, i) => def.hidden ? null : (
                                    <th
                                        class={twJoin(
                                            "px-3 py-1 text-black-medium relative",
                                            def.sortable ?? true ? "cursor-pointer" : "",
                                            def.style?.align === "center" ? "text-center"
                                                : def.style?.align === "right" ? "text-right"
                                                : "text-left",
                                            def.class,
                                        )}
                                        onclick={() => sortColumn(i)}
                                    >
                                        <span>{def.title}</span>
                                        
                                        {(def.sortable ?? true) && (
                                            <div class="absolute right-2 top-0 bottom-0 flex items-center">
                                                <Icon icon="icon-[fa--sort]" class="text-black-extra-light/40"/>
                                            </div>
                                        )}
                                        
                                        {(def.sortable ?? true) && sortColumnIndex.value === i && (
                                            <div class="absolute right-2 top-0 bottom-0 flex items-center">
                                                {sortColumnMode.value === "asc" ? (
                                                    <Icon icon="icon-[fa--sort-asc]" class="text-black-light"/>
                                                ) : (
                                                    <Icon icon="icon-[fa--sort-desc]" class="text-black-light"/>
                                                )}
                                            </div>
                                        )}
                                    </th>
                                ))}
                            </tr>
                        </thead>
                        <tbody>
                            {props.loading ? (
                                <tr>
                                    <td
                                        class="px-2 py-4 text-center text-black-medium"
                                        colspan={columnCount.value + ''}
                                    >
                                        Memuat data...
                                    </td>
                                </tr>
                            ) : toShowItems.value.length === 0 ? (
                                <tr>
                                    <td
                                        class="px-2 py-4 text-center text-black-medium"
                                        colspan={columnCount.value + ''}
                                    >
                                        Tidak ada data
                                    </td>
                                </tr>
                            ) : (
                                foreach(paginatedItems.value, (item, rowIndex) => <>
                                    <tr
                                        class={twMerge(
                                            "transition-colors",
                                            rowIndex % 2 === 0 ? "bg-back" : "bg-transparent",
                                            props.expandable && props.expandable.isExapanded(item) && "bg-kedua",
                                            props.rowSelectable && props.rowSelectable.isRowSelected(item, rowIndex) && "bg-blue-200",
                                            props.expandable && "cursor-pointer hover:bg-primary/20",
                                            props.rowSelectable && "cursor-pointer",
                                        )}
                                        onclick={() => onRowClick(item, rowIndex)}
                                    >
                                        {props.expandable && (
                                            <td
                                                class="w-0 pl-1.5"
                                            >
                                                <Icon
                                                    icon="icon-[ri--arrow-down-s-line]"
                                                    class={twJoin(
                                                        "text-lg text-black-light mt-1 transition-transform",
                                                        props.expandable.isExapanded(item) ? "" : "-rotate-90",
                                                    )}
                                                />
                                            </td>
                                        )}
                                        
                                        {numberColumnEnabled.value && (
                                            <td
                                                class="px-3 py-1 text-center w-px text-black-medium"
                                            >{rowIndex + 1}</td>
                                        )}
                                        
                                        {foreach(props.colDefs, (def, i) => def.hidden ? null : (
                                            <td
                                                class={twMerge(
                                                    "px-3 py-1 text-black-medium",
                                                    def.style?.align === "center" ? "text-center"
                                                        : def.style?.align === "right" ? "text-right"
                                                        : "text-left",
                                                    def.style?.compact ? "w-px" : ""
                                                )}
                                            >{def.render(item, rowIndex)}</td>
                                        ))}
                                    </tr>
                                    
                                    {props.expandable?.isExapanded(item) && (
                                        <tr>
                                            <td
                                                colspan={props.colDefs.length + (numberColumnEnabled.value ? 2 : 1) + ''}
                                            >{props.expandable.render(item, rowIndex)}</td>
                                        </tr>
                                    )}
                                </>)
                            )}
                        </tbody>
                    </table>
                </div>
                
                {paginationEnabled.value ? (
                    <Pagination
                        count={filteredItems.value.length}
                        perPage={perPage.value}
                        curPage={curPage.value}
                        onPageChanged={i => curPage.value = i}
                    />
                ) : !props.hideTotalData ? (
                    <small>Total {filteredItems.value.length} data</small>
                ) : null}
            </>}
            
        </div>
    )
}

function isColumnMatches<T>(def: TableCol<T>, item: T, index: number, search: string): boolean {
    if (!(def.searchable ?? true)) {
        return false
    }
    
    let text: string
    
    if (def.searchText) {
        text = def.searchText(item)
    }
    else {
        const rendered = def.render(item, index)
        if (!rendered || typeof rendered === "object") {
            return false
        }
        
        text = def.render(item, index)?.toString() ?? ''
    }
    
    return text.toLowerCase().includes(search.toLowerCase())
}