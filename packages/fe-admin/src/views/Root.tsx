import { Alert } from "@tahfeedz/fe-core/components/Alert.jsx"
import { Loading } from "@tahfeedz/fe-core/components/Loading.jsx"
import { Toast } from "@tahfeedz/fe-core/components/Toast.jsx"

export function Root(props: { children?: JSX.Element }) {
    return <>
        {props.children}
        
        <Alert/>
        <Toast/>
        <Loading/>
    </>
}