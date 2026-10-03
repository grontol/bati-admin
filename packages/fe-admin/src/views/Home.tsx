import { AdminCard } from "@tahfeedz/fe-core/components/container/AdminCard.jsx";
import { SessionManager } from "@tahfeedz/fe-core/data/session.js";

export function Home() {
    return <AdminCard
        title="Dashboard"
        subtitle={`Dashboard Public Speaking`}
    >
        <h2 class="text-2xl text-black-medium font-semibold">Hai, {SessionManager.name.value}</h2>
        <h3 class="text-black-light mt-2">Selamat datang di Dashboard Admin Public Speaking</h3>
    </AdminCard>
}