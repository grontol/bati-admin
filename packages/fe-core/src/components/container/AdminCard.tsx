import { PageContainer } from "@tahfeedz/fe-core/components/container/PageContainer.jsx";

export function AdminCard(props: {
    title?: string
    subtitle?: string
    
    children?: JSX.Element
    rightSlot?: JSX.Element
}) {    
    return <PageContainer>
        <div class="flex">
            <div class="flex flex-col">
                <h1 class="text-xl font-semibold text-primary font-secondary">{props.title ?? "Title Here"}</h1>
        
                {props.subtitle && (
                    <h2 class="text-sm text-black-light">{props.subtitle}</h2>
                )}                
            </div>
            
            <div class="flex-1"></div>
            
            {props.rightSlot}
        </div>
        
        <div class="mt-3"></div>
        
        {props.children}
    </PageContainer>
}