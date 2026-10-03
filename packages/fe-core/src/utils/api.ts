import { noDeps, popDeps, untrack } from "@pang/reactive.js";
import { hideLoading, hideSoftLoading, showLoading, showSoftLoading } from "@tahfeedz/fe-core/components/Loading.jsx";
import { showToastError } from "@tahfeedz/fe-core/components/Toast.jsx";
import { ApiJob, ApiResponse } from "@tahfeedz/fe-core/data/api.js";

export async function apiOrToast<T, R>(job: ApiJob<T>, cb?: (data: T) => R): Promise<R | null> {
    return new Promise((result) => {
        untrack(() => {
            showSoftLoading()
        })
        
        job.load(res => {
            try {
                if (res.success) {
                    result(cb?.(res.data) ?? null)
                }
                else {
                    showToastError(res.message)
                    result(null)
                }
            }
            catch (e) {
                showToastError(e)
                result(null)
            }
            finally {
                untrack(() => {
                    hideSoftLoading()
                })
            }
        }, () => {
            result(null)
            
            untrack(() => {
                hideSoftLoading()
            })
        })
    })
}

export async function apiOrToastWithLoading<T>(job: ApiJob<T>, cb?: (data: T) => void) {
    untrack(() => {
        showLoading()
    })
    
    job.load(res => {
        try {
            if (res.success) {
                cb?.(res.data)
            }
            else {
                showToastError(res.message)
            }
        }
        catch (e) {
            showToastError(e)
        }
        finally {
            untrack(() => {
                hideLoading()
            })
        }
    }, () => {
        untrack(() => {
            hideLoading()
        })
    })
}

export async function apiMultiOrToastWithLoading<T>(response: Promise<ApiResponse<T>>[], cb?: (data: T[]) => void) {
    showLoading()
    const res = await Promise.all(response)
    const datas: T[] = []
    
    for (const r of res) {
        if (!r.success) {
            hideLoading()
            showToastError(r.message)
            break
        }
        else {
            datas.push(r.data)
        }
    }
    
    hideLoading()
    cb?.(datas)
}