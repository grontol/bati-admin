import { SidebarSection } from "@tahfeedz/fe-core/components/Sidebar.jsx"

export const sidebarSections: SidebarSection[] = [
    {
        items: [
            {
                text: "Dashboard",
                link: "/",
                icon: "icon-[ic--round-home]",
                breadcrumb: [
                    { text: "Dashboard", link: "/" }
                ]
            },
            {
                text: "Hasil Sesi",
                icon: "icon-[carbon--result-draft]",
                link: "/session-result",
                breadcrumb: [
                    { text: "Dashboard", link: "/"},
                    { text: "Hasil Sesi", link: "/session-result"},
                ],
            },
        ]
    },
]