import { Button } from "@tahfeedz/fe-core/components/Button.jsx";
import { goto } from "@pang";

export function NotFound() {
    return <div class="flex flex-col justify-center items-center h-dvh p-8 bg-linear-to-b from-gray-100 to-green-200">
        <img src="/images/not-found.webp" class="h-[50%]"/>
        <div class="font-extrabold text-gray-700 text-2xl mt-6 text-center">Halaman tidak ditemukan...</div>
        <Button class="mt-6" size="lg" roundness="full" onclick={() => goto("")}>Ke Halaman Utama</Button>
    </div>
}

export function Unauthorized() {
    return <div class="flex flex-col justify-center items-center h-dvh p-8 bg-linear-to-b from-gray-100 to-amber-100">
        <img src="/images/unauthorized.webp" class="h-[50%]"/>
        <div class="font-extrabold text-gray-700 text-xl mt-6 text-center">Maaf, Anda tidak boleh mengakses halaman ini...</div>
        <Button class="mt-6 bg-amber-800" size="lg" roundness="full" onclick={() => goto("")}>Ke Halaman Utama</Button>
    </div>
}

export function SomethingWrong() {
    return <div class="flex flex-col justify-center items-center h-dvh p-8 bg-linear-to-b from-gray-100 to-amber-100">
        <img src="/images/something-wrong.webp" class="h-[50%]"/>
        <div class="font-extrabold text-gray-700 text-xl mt-6 text-center">Ooops, ada yang salah. Tapi tenang, jangan panik. Coba kembali ke halaman utama...</div>
        <Button class="mt-6 bg-amber-800" size="lg" roundness="full" onclick={() => goto("")}>Ke Halaman Utama</Button>
    </div>
}

export function Maintenance() {
    return <div class="flex flex-col justify-center items-center h-dvh p-8 bg-linear-to-b from-gray-100 to-amber-100">
        <img src="/images/maintenance.webp" class="h-[50%]"/>
        <div class="font-extrabold text-gray-700 text-xl mt-6 text-center">Maaf, kami sedang memperbaiki sistem. Mohon tunggu sesaat lagi...</div>
        <Button class="mt-6 bg-amber-800" size="lg" roundness="full" onclick={() => goto("")}>Ke Halaman Utama</Button>
    </div>
}