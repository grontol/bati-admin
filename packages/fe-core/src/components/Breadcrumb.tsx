import { isMobile } from "@tahfeedz/fe-core/lib/utils/device.js"
import { foreach } from "@pang/core.js"
import { state } from "@pang/reactive.js"
import { formatUrlPath } from "@pang/router.js"

export type BreadCrumbItem = {
    text: string,
    link?: string,
}

export const breadcrumbStore = state<BreadCrumbItem[]>([
    {
        text: "Dashboard",
        link: "/"
    }
])

export function Breadcrumb() {
    return <>
        {isMobile().value ? (
            <div>
                {breadcrumbStore.value.length > 0 && (
                    <span class="text-primary-dark font-semibold">{breadcrumbStore.value[breadcrumbStore.value.length - 1].text}</span>
                )}
            </div>
        ) : (
            <div class="flex items-center">
                {foreach(breadcrumbStore.value, (b, i) => (
                    <>
                        {b.link && i < breadcrumbStore.value.length - 1 ? (
                            <a href={formatUrlPath(b.link)} class="text-primary-dark font-semibold">{b.text}</a>
                        ) : (
                            <span class="text-black-light font-semibold">{b.text}</span>
                        )}
                        
                        {i < breadcrumbStore.value.length - 1 && (
                            <span class="mx-2 text-black-light">/</span>
                        )}
                    </>
                ))}
            </div>
        )}
    </>
}