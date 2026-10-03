import { Button } from "@tahfeedz/fe-core/components/Button.jsx"
import { InputError } from "@tahfeedz/fe-core/components/input/InputError.jsx"
import { InputLabel } from "@tahfeedz/fe-core/components/input/InputLabel.jsx"
import { validationContext } from "@tahfeedz/fe-core/components/validation/Validation.jsx"
import { createField } from "@tahfeedz/fe-core/components/validation/field.js"
import { requiredValidator, Validator } from "@tahfeedz/fe-core/components/validation/validator.js"
import { foreach } from "@pang/core.js"
import { stop } from "@pang/event-utils.js"
import { onDestroy, onMount } from "@pang/lifecycle.js"
import { derived, state } from "@pang/reactive.js"
import { twJoin, twMerge } from "tailwind-merge"
import { Icon } from "@tahfeedz/fe-core/components/Icon.jsx"
import { MiddlePopup } from "@tahfeedz/fe-core/components/container/Popup.jsx"

export type OptionItem<T = string> = {
    text: string
    value: T
}

type Option<T> = T | OptionItem<T>

export type SelectInputProps<T> = {
    options: readonly Option<T>[]
    value: T
    label?: string
    inline?: boolean
    onChange?: (v: T) => void
    onSearch?: (v: string) => void
    placeholder?: string
    isLoading?: boolean
    isMobile?: boolean
    
    validators?: Validator[],
    required?: boolean
    disabled?: boolean
    readonly?: boolean
    searchable?: boolean
    clearable?: boolean
    
    class?: string
    inputContainerClass?: string
    inputClass?: string
    actionClass?: string
    
    arrowIcon?: string
}

export function SelectInput<T extends string | number = string>(props: SelectInputProps<T>) {
    let el: HTMLDivElement
    let input: HTMLInputElement
    
    const validation = validationContext.get()
    
    const inline = derived(() => props.inline ?? false)
    const required = derived(() => props.required ?? false)
    const disabled = derived(() => props.disabled ?? false)
    const readonly = derived(() => props.readonly ?? false)
    const searchable = derived(() => props.searchable ?? true)
    const clearable = derived(() => props.clearable ?? true)
    
    const isShowOptions = state(false)
    const isSearching = derived(() => searchable.value && !disabled.value && isShowOptions.value)
    const searchText = state("")
    
    const text = derived(() => {
        const selected = props.options.find(x => getValueOf(x) === props.value)
        
        if (!selected) {
            return ""
        }
        else {
            return getTextOf(selected)
        }
    })
    
    const inputText = derived(() => {
        if (isSearching.value && !props.isMobile) {
            return searchText.value
        }
        else {
            return text.value
        }
    })
    
    const placeholder = derived(() => {
        if (isSearching.value) {
            return text.value
        }
        else {
            return props.placeholder
        }
    })
    
    const filteredOptions = derived(() => {
        if (!searchable.value || !searchText.value) return props.options
        
        return props.options.filter(x => {
            const text = getTextOf(x)
            return text.toLowerCase().includes(searchText.value.toLowerCase())
        })
    })
    
    const field = validation ? createField(
        derived(() => props.value),
        derived(() => [
            ...(required.value ? [requiredValidator(false)] : []),
            ...(props.validators ?? [])
        ]),
        () => {
            setTimeout(() => {
                input.focus()
            }, 0)
        }
    ) : null
    
    const isError = derived(() => (field?.errors?.value?.length ?? 0) > 0)
    const errMsg = derived(() => (field?.errors?.value?.length ?? 0) > 0 ? field!.errors.value[0] : null)
    
    function showOptions(toggle = false) {
        if (readonly.value || disabled.value) return
        
        if (toggle) {
            isShowOptions.value = !isShowOptions.value
        }
        else {
            isShowOptions.value = true
        }
    }
    
    function hideOptions() {
        isShowOptions.value = false        
        searchText.value = ''
    }
    
    function selectOption(option: Option<T>) {
        props.onChange?.(getValueOf(option))
        hideOptions()
    }
    
    function handleClickOutside(event: MouseEvent) {
        if (props.isMobile) return
        
        if (event.target instanceof Node && !el.contains(event.target)) {
            hideOptions()
        }
    }
    
    function handleSearch(v: string) {
        searchText.value = v
        props.onSearch?.(v.toLowerCase())
    }
    
    function clear() {
        if (typeof props.value === 'number') {
            props.onChange?.(0 as T)
        }
        else {
            props.onChange?.('' as T)
        }
        
        hideOptions()
    }
    
    onMount(() => {
        document.addEventListener("click", handleClickOutside)
        
        if (field) {
            validation?.addField(field)
        }
    })
    
    onDestroy(() => {
        document.removeEventListener("click", handleClickOutside)
        
        if (field) {
            validation?.removeField(field)
        }
    })
    
    return <>
        <div
            class={twMerge(
                "flex flex-col relative",
                inline.value ? "flex-row items-center gap-2" : "",
                props.class,
            )}
        >
            {props.label !== undefined && (
                <InputLabel
                    class={twMerge(
                        inline.value ? "mb-0" : "",
                    )}
                    label={props.label}
                    required={props.required}
                />
            )}
            
            <div
                ref={r => el = r}
                class={twMerge(
                    "flex flex-col bg-white/80 border border-black-extra-light transition-colors rounded relative focus-within:border-primary",
                    isError.value ? "border-red-500 focus-within:border-red-500" : "",
                    readonly.value ? "bg-white/10" : "",
                    disabled.value ? "bg-gray-400/10" : "",
                    props.inputContainerClass,
                )}
            >
                <input
                    ref={v => input = v}
                    type="text"
                    class={twMerge(
                        "outline-none px-3 py-1.5 cursor-pointer",
                        disabled.value ? "cursor-default" : "",
                        props.inputClass,
                    )}
                    onfocus={() => showOptions(false)}
                    value={inputText.value}
                    oninput={handleSearch}
                    readonly={!isSearching.value}
                    placeholder={placeholder.value}
                    disabled={disabled.value}
                />
                
                <div
                    class={twMerge(
                        "absolute top-0 bottom-0 right-1 flex items-center",
                        props.actionClass,
                    )}
                >
                    {clearable.value && !readonly.value && !disabled.value && props.value && (
                        <Button
                            class="px-1"
                            color="neutral"
                            style="none"
                            onclick={stop(clear)}
                        >
                            <span class="icon-[mdi--close] text-black-extra-light hover:text-black-light text-lg"/>
                        </Button>
                    )}
                    
                    <span
                        class={twMerge(
                            "text-black-extra-light",
                            props.disabled ? "" : "cursor-pointer",
                            props.arrowIcon ? props.arrowIcon : "icon-[fe--arrow-down]",
                        )}
                        onclick={() => showOptions(true)}
                    />
                </div>
                
                {isShowOptions.value && !props.isMobile && (
                    <div
                        class="absolute top-full mt-1 z-100 bg-white-darker flex flex-col w-full disable-break py-2 border border-black-extra-light box-border overflow-auto rounded max-h-[500px]"
                    >
                        {props.isLoading ? (
                            <div class="px-4 py-1 text-center text-black-light">Loading...</div>
                        ) : (
                            foreach(filteredOptions.value, option => (
                                <div
                                    class="hover:bg-black/10 px-4 py-1 cursor-pointer"
                                    onclick={stop(() => selectOption(option))}
                                >{getTextOf(option)}</div>
                            )
                        ))}
                    </div>
                )}
            </div>
                        
            {errMsg.value && (
                <InputError
                    class="mt-1"
                    message={errMsg.value}
                />
            )}
        </div>
        
        {props.isMobile && (
            <MiddlePopup
                visible={isShowOptions.value}
                onClose={hideOptions}
                cardClass="p-0 overflow-hidden"
            >
                {searchable.value && (
                    <div class="p-2 border-b border-black-extra-light/50 mb-2">
                        <input
                            ref={v => input = v}
                            type="text"
                            class={twMerge(
                                "outline-none px-3 py-1.5",
                                disabled.value ? "cursor-default" : "",
                                props.inputClass,
                            )}
                            onfocus={() => showOptions(false)}
                            value={searchText.value}
                            oninput={handleSearch}
                            readonly={!isSearching.value}
                            placeholder={text.value ? text.value : props.placeholder}
                            disabled={disabled.value}
                        />
                    </div>
                )}
                
                <div
                    class={twMerge(
                        "flex flex-col overflow-auto my-2",
                        searchable.value ? "mt-0" : "",
                    )}
                >
                    {props.isLoading ? (
                        <div class="px-4 py-1 text-center text-black-light">Loading...</div>
                    ) : (
                        foreach(filteredOptions.value, option => (
                            <div
                                class={twMerge(
                                    "hover:bg-black/10 px-4 py-2 cursor-pointer",
                                    getValueOf(option) === props.value && "bg-kedua"
                                )}
                                onclick={stop(() => selectOption(option))}
                            >{getTextOf(option)}</div>
                        )
                    ))}
                </div>
            </MiddlePopup>
        )}
    </>
}

type MultiSelectInputProps<T> = Omit<SelectInputProps<T>, 'value' | 'onChange'> & {
    value: T[]
    onChange?: (v: T[]) => void
}

export function MultiSelectInput<T extends string | number = string>(props: MultiSelectInputProps<T>) {
    let el: HTMLDivElement
    let input: HTMLInputElement
    
    const validation = validationContext.get()
    
    const inline = derived(() => props.inline ?? false)
    const required = derived(() => props.required ?? false)
    const disabled = derived(() => props.disabled ?? false)
    const readonly = derived(() => props.readonly ?? false)
    const searchable = derived(() => props.searchable ?? true)
    const clearable = derived(() => props.clearable ?? true)
    
    const isShowOptions = state(false)
    const isSearching = derived(() => searchable.value && !disabled.value && isShowOptions.value)
    const searchText = state("")
    
    const showClearButton = derived(() => clearable.value && !readonly.value && !disabled.value && props.value.length > 0)
    
    const text = derived(() => {
        const selecteds = props.options.filter(x => props.value.includes(getValueOf(x)))
        
        return selecteds.map(x => getTextOf(x)).join(", ")
    })
    
    const inputText = derived(() => {
        if (isSearching.value) {
            return searchText.value
        }
        else {
            return text.value
        }
    })
    
    const placeholder = derived(() => {
        if (isSearching.value) {
            return text.value
        }
        else {
            return props.placeholder
        }
    })
    
    const filteredOptions = derived(() => {
        if (!searchable.value || !searchText.value) return props.options
        
        return props.options.filter(x => {
            const text = getTextOf(x)
            return text.toLowerCase().includes(searchText.value.toLowerCase())
        })
    })
    
    const field = validation ? createField(
        derived(() => props.value),
        derived(() => required.value ? [requiredValidator(false)] : []),
        () => {
            input.focus()
        }
    ) : null
    
    const isError = derived(() => (field?.errors?.value?.length ?? 0) > 0)
    const errMsg = derived(() => (field?.errors?.value?.length ?? 0) > 0 ? field!.errors.value[0] : null)
    
    const isAllChecked = derived(() => props.value.length === props.options.length)
    
    function showOptions(toggle = false) {
        if (readonly.value || disabled.value) return
        
        if (toggle) {
            isShowOptions.value = !isShowOptions.value
        }
        else {
            isShowOptions.value = true
        }
    }
    
    function hideOptions() {
        isShowOptions.value = false        
        searchText.value = ''
    }
    
    function selectOption(option: Option<T>) {
        const v = getValueOf(option)
        const xs = [...props.value]
        
        if (!xs.includes(v)) {
            xs.push(v)
        }
        else {
            xs.splice(xs.indexOf(v), 1)
        }
        
        props.onChange?.(xs)
    }
    
    function selectAll() {
        props.onChange?.(props.options.map(x => getValueOf(x)))
    }
    
    function unselectAll() {
        props.onChange?.([])
    }
    
    function toggleSelectAll() {
        if (isAllChecked.value) {
            unselectAll()
        }
        else {
            selectAll()
        }
    }
    
    function isOptionSelected(option: Option<T>) {
        return props.value.includes(getValueOf(option))
    }
    
    function handleClickOutside(event: MouseEvent) {
        if (event.target instanceof Node && !el.contains(event.target)) {
            hideOptions()
        }
    }
    
    function handleSearch(v: string) {
        searchText.value = v
        props.onSearch?.(v.toLowerCase())
    }
    
    function clear() {
        props.onChange?.([])        
        hideOptions()
    }
    
    onMount(() => {
        document.addEventListener("click", handleClickOutside)
        
        if (field) {
            validation?.addField(field)
        }
    })
    
    onDestroy(() => {
        document.removeEventListener("click", handleClickOutside)
        
        if (field) {
            validation?.removeField(field)
        }
    })
    
    return (
        <div
            class={twMerge(
                "flex flex-col relative",
                inline.value ? "flex-row items-center gap-2" : "",
                props.class,
            )}
        >
            {props.label !== undefined && (
                <InputLabel
                    class={twMerge(
                        inline.value ? "mb-0" : "",
                    )}
                    label={props.label}
                    required={props.required}
                />
            )}
            
            <div
                ref={r => el = r}
                class={twMerge(
                    "flex flex-col bg-white/80 border border-black-extra-light transition-colors rounded relative focus-within:border-primary",
                    isError.value ? "border-red-500 focus-within:border-red-500" : "",
                    readonly.value ? "bg-white/10" : "",
                    disabled.value ? "bg-gray-400/10" : "",
                    props.inputContainerClass,
                )}
            >
                <input
                    ref={v => input = v}
                    type="text"
                    class={twMerge(
                        "outline-none px-3 py-1.5 cursor-pointer text-ellipsis placeholder:text-ellipsis",
                        disabled.value ? "cursor-default" : "",
                        showClearButton.value ? "pr-10" : "pr-5",
                        props.inputClass,
                    )}
                    onfocus={() => showOptions(false)}
                    value={inputText.value}
                    oninput={handleSearch}
                    readonly={!isSearching.value}
                    placeholder={placeholder.value}
                    disabled={disabled.value}
                    onclick={() => showOptions(false)}
                />
                
                <div
                    class={twMerge(
                        "absolute top-0 bottom-0 right-1 flex items-center",
                        props.actionClass,
                    )}
                >
                    {showClearButton.value && (
                        <Button
                            class="px-1"
                            color="neutral"
                            style="none"
                            onclick={stop(clear)}
                        >
                            <span class="icon-[mdi--close] text-black-extra-light hover:text-black-light text-lg"/>
                        </Button>
                    )}
                    
                    <span
                        class={twMerge(
                            "text-black-extra-light",
                            props.disabled ? "" : "cursor-pointer",
                            props.arrowIcon ? props.arrowIcon : "icon-[fe--arrow-down]",
                        )}
                        onclick={() => showOptions(true)}
                    />
                </div>
                
                {isShowOptions.value && (
                    <div
                        class="absolute top-full mt-1 z-100 bg-white-darker flex flex-col w-full disable-break py-2 border border-black-extra-light box-border overflow-auto rounded max-h-[500px]"
                    >
                        <div
                            class="hover:bg-black/10 px-4 py-1 cursor-pointer flex items-center border-b border-black-extra-light/50"
                            onclick={toggleSelectAll}
                        >
                            <Icon
                                icon={isAllChecked.value ? "icon-[mdi--checkbox-marked]" : "icon-[mdi--checkbox-blank-outline]"}
                                class={twJoin(
                                    "text-lg text-primary",
                                )}
                            />
                            
                            <span class="ml-2 text-primary">{isAllChecked.value ? "Hapus Centang Semua" : "Centang Semua"}</span>
                        </div>
                        
                        {props.isLoading ? (
                            <div class="px-4 py-1 text-center text-black-light">Loading...</div>
                        ) : (
                            foreach(filteredOptions.value, option => (
                                <div
                                    class="hover:bg-black/10 px-4 py-1 cursor-pointer flex items-center"
                                    onclick={stop(() => selectOption(option))}
                                >
                                    <Icon
                                        icon={isOptionSelected(option) ? "icon-[mdi--checkbox-marked]" : "icon-[mdi--checkbox-blank-outline]"}
                                        class={twJoin(
                                            "text-lg",
                                            isOptionSelected(option) ? "text-primary" : "text-black-light",
                                        )}
                                    />
                                    
                                    <span class="ml-2">{getTextOf(option)}</span>
                                </div>
                            )
                        ))}
                    </div>
                )}
            </div>
                        
            {errMsg.value && (
                <InputError
                    class="mt-1"
                    message={errMsg.value}
                />
            )}
        </div>
    )
}

function getValueOf<T>(option: Option<T>): T {
    if (isOptionItem(option)) {
        return option.value
    }
    else {
        return option
    }
}

function getTextOf<T extends string | number>(option: Option<T>): string {
    if (isOptionItem(option)) {
        return option.text
    }
    else {
        return option.toString()
    }
}

function isOptionItem<T>(item: Option<T>): item is OptionItem<T> {
    return typeof item === "object" && item && "text" in item && "value" in item
}