import { onMount, state } from "@pang";
import { Button } from "@tahfeedz/fe-core/components/Button.jsx";
import { AdminCard } from "@tahfeedz/fe-core/components/container/AdminCard.jsx";
import { Icon } from "@tahfeedz/fe-core/components/Icon.jsx";
import { Table } from "@tahfeedz/fe-core/components/table/Table.jsx";
import { UserApi } from "@tahfeedz/fe-core/data/user_api.js";
import { apiOrToast } from "@tahfeedz/fe-core/utils/api.js";
import { UserData } from "@tahfeedz/shared/types.js";

export function UserList() {
    const data = state<UserData[]>([])
    
    const detailPopupVisible = state(false)
    const detailData = state<UserData | null>(null)
    
    async function getData() {
        apiOrToast(UserApi.getAll(), r => {
            data.value = r
        })
    }
    
    function detail(i: UserData) {
        detailPopupVisible.value = true
        detailData.value = i
    }
    
    onMount(() => {
        getData()
    })
    
    return <>
        <AdminCard
            title="Data User"
            subtitle="List Data User"
        >            
            <Table<UserData>
                colDefs={[
                    {
                        title: "Nama",
                        render: i => i.name,
                        sortable: true,
                    },
                    {
                        title: "Username",
                        render: i => i.username,
                        sortable: true,
                    },
                    {
                        title: "Email",
                        render: i => i.email,
                        sortable: true,
                    },
                    {
                        title: "Aksi",
                        style: { align: "center", compact: true },
                        render: i => <div class="flex justify-center gap-1">
                            <Button color="primary" onclick={() => detail(i)}>
                                <Icon icon="icon-[mdi--eye]" class="text-lg"/>
                            </Button>
                        </div>
                    }
                ]}
                items={data.value}
            />
        </AdminCard>
    </>
}