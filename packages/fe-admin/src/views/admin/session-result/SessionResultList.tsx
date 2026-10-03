import { derived, foreach, onMount, state } from "@pang";
import { showAlertConfirmDelete } from "@tahfeedz/fe-core/components/Alert.jsx";
import { Button } from "@tahfeedz/fe-core/components/Button.jsx";
import { AdminCard } from "@tahfeedz/fe-core/components/container/AdminCard.jsx";
import { AdminFullPopup } from "@tahfeedz/fe-core/components/container/AdminFullPopup.jsx";
import { Icon } from "@tahfeedz/fe-core/components/Icon.jsx";
import { Table } from "@tahfeedz/fe-core/components/table/Table.jsx";
import { showToastDeleteSuccess } from "@tahfeedz/fe-core/components/Toast.jsx";
import { SessionResultApi } from "@tahfeedz/fe-core/data/session_result_api.js";
import { apiOrToast, apiOrToastWithLoading } from "@tahfeedz/fe-core/utils/api.js";
import { dateStringFormat } from "@tahfeedz/fe-core/utils/date.js";
import { SessionResultData, SessionResultDetailData } from "@tahfeedz/shared/types.js";

export function SessionResultList() {
    const data = state<SessionResultData[]>([])
    
    const detailPopupVisible = state(false)
    const detail = state<SessionResultData | null>(null)
    
    async function getData() {
        apiOrToast(SessionResultApi.getAll(), r => {
            data.value = r
        })
    }
    
    function toDetail(i: SessionResultData) {
        detailPopupVisible.value = true
        detail.value = i
    }
    
    function remove(i: SessionResultData) {
        showAlertConfirmDelete(() => {
            apiOrToastWithLoading(SessionResultApi.delete(i.id), () => {
                showToastDeleteSuccess()
                getData()
            })
        })
    }
    
    onMount(() => {
        getData()
    })
    
    return <>
        <AdminCard
            title="Data Hasil"
            subtitle="List Data Hasil"
        >            
            <Table<SessionResultData>
                colDefs={[
                    {
                        title: "Nama",
                        render: i => i.name,
                        sortable: true,
                    },
                    {
                        title: "NIS",
                        render: i => i.nis,
                        sortable: true,
                    },
                    {
                        title: "Tanggal",
                        render: i => dateStringFormat(i.date, "indo-date-complete"),
                        sortable: true,
                    },
                    {
                        title: "Aksi",
                        style: { align: "center", compact: true },
                        render: i => <div class="flex justify-center gap-1">
                            <Button color="primary" onclick={() => toDetail(i)}>
                                <Icon icon="icon-[mdi--eye]" class="text-lg"/>
                            </Button>
                            
                            <Button color="error" onclick={() => remove(i)}>
                                <Icon icon="icon-[mdi--trash]" class="text-lg"/>
                            </Button>
                        </div>
                    }
                ]}
                items={data.value}
            />
        </AdminCard>
        
        <SessionResultDetail
            visible={detailPopupVisible.value}
            data={detail.value}
            onClose={() => {
                detailPopupVisible.value = false
                detail.value = null
            }}
        />
    </>
}

const criterias = [
    [
        "Menyapa Tamu: mengucapkan salam ramah",
        "Menanyakan Detail Reservasi: memperkenalkan diri dan minta nama tamu",
        "Pemeriksaan Sistem & Verifikasi ID: mengecek sistem di komputer dan persilahkan tamu untuk menunggu",
        "Hasil Cek Sistem: mengucapkan penemuan data",
        "Minta Identitas: meminta KTP kepada tamu",
        "Data Sesuai: menyampaikan bahwa data identitas sudah sesuai",
        "Informasi Fasilitas Hotel: memberi informasi tentang fasilitas Wi-Fi dan mekanisme sarapan",
        "Penyerahan Kunci Kamar: menyerahkan kunci kamar dan menawarkan bantuan jika membutuhkan",
    ],
    [
        "Empati Awal: Mendengarkan keluhan tamu mengenai AC yang mati. Merespons dengan empati.",
        "Penjelasan Kebijakan secara Asertif (Saat Tamu Menuntut Upgrade Suite Premium): Mengucapkan penjelasan batasan wewenang dan opsi solusi",
        "Menyampaikan Solusi: Menawarkan solusi alternatif konkret",
        "Konfirmasi Waktu: Setelah tamu setuju, berikan konfirmasi",
        "Mohon Maaf & Penutup: Menyampaikan permintaan maaf sekali lagi",
    ],
    [
        "Menyapa Tamu: Mengucapkan salam ramah",
        "Menanyakan Jam Late Check-out: Saat tamu menanyakan kemungkinan late check-out, tanyakan detail waktunya",
        "Konfirmasi Late Check-out: Cek sistem, lalu konfirmasikan permintaan jam 14.00 gratis.",
        "Menanggapi Permintaan Tambahan: Saat tamu menambahkan permintaan bantal & handuk ekstra, konfirmasikan pengiriman oleh housekeeping",
        "Penutup: Ucapkan salam penutup yang hangat",
    ],
    [
        "Menyapa Tamu: Mengucapkan salam ramah",
        "Meminta Kunci Kamar: Proses check-out dan minta kuci",
        "Pengecekan Tagihan Awal: Cek sistem dan sebutkan total tagihan awal",
        "Merespons Keberatan Tamu (Dispute Minibar): Saat tamu terkejut dan menyatakan tidak memakai minibar, beri tanggapan tenang",
        "Pemeriksaan Ulang & Koreksi Tagihan: Lakukan verifikasi ulang pada sistem/catatan. Sampaikan permohonan maaf dan koreksi harga yang benar",
        "Proses Pembayaran: Tanyakan metode pembayaran",
        "Ambil kartu pembayaran dari tamu: Menyampaikan untuk menunggu dan mengucapkan konfirmasi berhasil dan terima kasih",
        "Penutup: Lepas keberangkatan tamu dengan ramah",
    ]
]

function SessionResultDetail(props: {
    visible: boolean
    data: SessionResultData | null
    onClose: () => void
}) {
    const details = derived(() => props.data?.details?.toSorted((a, b) => (a.scene * 100 + a.part) - (b.scene * 100 + b.part)) ?? [])
    
    return <AdminFullPopup
        visible={props.visible}
        title="Detail Hasil"
        subtitle="List Detail Hasil"
        onCancel={props.onClose}
        action={
            <div>
                <Button onclick={props.onClose}>Tutup</Button>
            </div>
        }
    >
        {foreach(details.value, (d, i) => (
            <div class="p-4 flex flex-col">
                <div class=" text-lg font-bold mb-2">{d.scene} - {d.part}. {criterias[d.scene - 1]?.[d.part - 1]}</div>
                
                {d.is_passed ? (
                    <div class="bg-green-600 px-4 rounded-full self-start text-white">LOLOS</div>
                ) : (
                    <div class="bg-red-600 px-4 rounded-full self-start text-white">TIDAK LOLOS</div>
                )}
                
                <div class="mt-1 flex"><div class="w-40">Kelancaran</div> : {d.fluency}/100</div>
                <div class="mt-1 flex"><div class="w-40">Profesionalisme</div> : {d.professionalism}/100</div>
                <div class="mt-1 flex"><div class="w-40">Intonasi</div> : {d.intonation}/100</div>
                <div class="mt-1 flex"><div class="w-40">Skor</div> : {d.score}/100</div>
                <div class="mt-1 flex"><div class="w-40 shrink-0">Jawaban</div> : {d.content}</div>
                <div class="mt-1 flex"><div class="w-40 shrink-0">Feedback</div> : {d.feedback}</div>
                <div class="mt-1 flex"><div class="w-40 shrink-0">Saran Jawaban</div> : {d.suggested_response}</div>
            </div>
        ))}
    </AdminFullPopup>
}