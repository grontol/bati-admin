import { foreach } from "@pang/core.js"
import { derived } from "@pang/reactive.js"
import { twMerge } from "tailwind-merge"

type Props = {
    count: number
    curPage: number
    perPage: number
    
    onPageChanged?: (index: number) => void
}

type PageItem = {
    page: number
    text: string
    clickable: boolean
}

const PAGE_COUNT = 9
const PREV_NEXT_COUNT = 3

export function Pagination(props: Props) {
    const totalPage = derived(() => countTotalPage(props.count, props.perPage))    
    const start = derived(() => props.perPage * props.curPage + 1)
    const end = derived(() => {
        return Math.min(props.count, props.perPage * (props.curPage + 1))
    })
    const isFirtsPage = derived(() => props.curPage === 0)
    const isLastPage = derived(() => props.curPage >= totalPage.value - 1)
    
    const pages = derived<PageItem[]>(() => {
        if (totalPage.value <= PAGE_COUNT) {
            return Array.from({ length: totalPage.value }).map((_, i) => ({
                page: i,
                text: (i + 1).toString(),
                clickable: true,
            }))
        }
        else {
            const res: PageItem[] = []
            
            let startPage = props.curPage - PREV_NEXT_COUNT
            let endPage = props.curPage + PREV_NEXT_COUNT
            
            if (startPage < 0) {
                endPage -= startPage
                startPage = 0
            }
            
            if (endPage > totalPage.value - 1) {
                startPage += (totalPage.value - 1 - endPage)
                endPage = totalPage.value - 1
            }
            
            const hasStartDot = startPage > 1
            const hasEndDot = endPage < totalPage.value - 2
            
            if (hasEndDot && props.curPage - PREV_NEXT_COUNT > 0) {
                endPage--
            }
            
            if (hasStartDot && props.curPage + PREV_NEXT_COUNT < totalPage.value - 1) {
                startPage++
            }
            
            if (startPage > 0) {
                res.push({ page: 0, text: "1", clickable: true })
            }
            
            if (hasStartDot) {
                res.push({ page: -1, text: "...", clickable: false })
            }
            
            for (let a = startPage; a <= endPage; a++) {
                res.push({ page: a, text: (a + 1).toString(), clickable: true })
            }
            
            if (hasEndDot) {
                res.push({ page: -1, text: "...", clickable: false })
            }
            
            if (endPage < totalPage.value - 1) {
                res.push({ page: totalPage.value - 1, text: totalPage.value.toString(), clickable: true })
            }
            
            // res.push({ page: 0, text: "1", clickable: true })
            
            // if (props.curPage < START_END_COUNT) {
            //     for (let a = 1; a < START_END_COUNT; a++) {
            //         res.push({ page: a, text: (a + 1).toString(), clickable: true })
            //     }
                
            //     res.push({ page: -1, text: "...", clickable: false })
            // }
            // else if (props.curPage > totalPage.value - START_END_COUNT) {
            //     res.push({ page: -1, text: "...", clickable: false })
                
            //     for (let a = totalPage.value - START_END_COUNT; a < totalPage.value - 1; a++) {
            //         res.push({ page: a, text: (a + 1).toString(), clickable: true })
            //     }
            // }
            
            // res.push({ page: totalPage.value - 1, text: totalPage.value.toString(), clickable: true })
            
            return res
        }
    })
    
    function selectPage(index: number) {
        if (index !== props.curPage && index >= 0 && index < totalPage.value) {
            props.onPageChanged?.(index)
        }
    }
    
    return (
        <div class="flex items-center py-1">
            <span class="text-black-light">[{start.value} - {end.value}] Total: <span class="text-black-medium font-bold">{props.count}</span></span>
            
            <div class="flex-1"/>
            
            <div class="flex items-stretch">
                <div
                    class={twMerge(
                        "px-1.5 py-0.5 font-bold cursor-pointer flex items-center",
                        isFirtsPage.value ? "text-black-extra-light cursor-not-allowed" : "text-black-light hover:text-primary-dark",
                    )}
                    onclick={() => selectPage(props.curPage - 1)}
                >
                    <span
                        class="icon-[solar--alt-arrow-left-line-duotone]"
                    />
                </div>
                
                {foreach(pages.value, p => (
                    <div
                        class={twMerge(
                            "min-w-8 px-1 flex justify-center py-0.5 text-black-light hover:text-primary-dark",
                            p.clickable && "cursor-pointer",
                            props.curPage === p.page ? "text-primary-dark font-bold" : "",
                        )}
                        onclick={() => { if (p.clickable) selectPage(p.page) }}
                    >{p.text}</div>
                ))}
                
                <div
                    class={twMerge(
                        "px-1.5 py-0.5 font-bold hover:text-primary-dark cursor-pointer flex items-center",
                        isLastPage.value ? "text-black-extra-light cursor-not-allowed" : "text-black-light hover:text-primary-dark",
                    )}
                    onclick={() => selectPage(props.curPage + 1)}
                >
                    <span
                        class="icon-[solar--alt-arrow-right-line-duotone]"
                    />
                </div>
            </div>
        </div>
    )
}

export function countTotalPage(count: number, perPage: number): number {
    const div = count / perPage
        
    if (div - Math.floor(div) > 0) {
        return Math.ceil(div)
    }
    else {
        return Math.floor(div)
    }
}