import { onMount, state } from "@pang";
import { OptionItem, SelectInput, SelectInputProps } from "@tahfeedz/fe-core/components/input/SelectInput.jsx";
import { makeDebounce } from "@tahfeedz/fe-core/utils/debounce.js";

type Props<T> = Omit<SelectInputProps<T>, 'options'> & {
    additionalOptions?: OptionItem<T>[]
    getData: (search: string) => MayPromise<OptionItem<T>[]>
}

export function ServerSelectInput<T extends string | number = string>(props: Props<T>) {
    const options = state<OptionItem<T>[]>([])
    const isLoading = state(false)
    
    const debounceGetData = makeDebounce<string>(getData, 500)
    
    async function getData(search = "") {
        isLoading.value = true
        const data = await props.getData(search)
        options.value = data
        isLoading.value = false
    }
    
    onMount(() => {
        getData()
    })
    
    return <SelectInput<T>
        label={props.label}
        options={[...props.additionalOptions ?? [], ...options.value]}
        value={props.value}
        onSearch={debounceGetData}
        isLoading={isLoading.value}
        onChange={props.onChange}
        clearable={props.clearable}
        disabled={props.disabled}
        inline={props.inline}
        placeholder={props.placeholder}
        readonly={props.readonly}
        required={props.required}
        searchable={props.searchable}
        class={props.class}
        actionClass={props.actionClass}
        inputClass={props.inputClass}
        inputContainerClass={props.inputContainerClass}
    />
}