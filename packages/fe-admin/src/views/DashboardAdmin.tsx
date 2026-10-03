import { sidebarSections } from "@/views/SidebarData.js"
import { onDestroy, onMount } from "@pang/lifecycle.js"
import { derived, effect, state } from "@pang/reactive.js"
import { goto } from "@pang/router.js"
import { showAlertQuestion } from "@tahfeedz/fe-core/components/Alert.jsx"
import { Breadcrumb } from "@tahfeedz/fe-core/components/Breadcrumb.jsx"
import { Icon } from "@tahfeedz/fe-core/components/Icon.jsx"
import { MenuPopup } from "@tahfeedz/fe-core/components/popup/MenuPopup.jsx"
import { Sidebar } from "@tahfeedz/fe-core/components/Sidebar.jsx"
import { SessionManager } from "@tahfeedz/fe-core/data/session.js"
import { twMerge } from "tailwind-merge"

export function DashboardAdmin(props: { children?: JSX.Element }) {
    const innerWidth = state(window.innerWidth)
    const sidebarOpened = state(false)
    
    const sidebarFilter = state("")
    
    const isSmall = derived(() => innerWidth.value < 1150)
    
    effect(() => {
        if (!isSmall.value) {
            sidebarOpened.value = false
        }
    })
    
    function openSidebar() {
        sidebarOpened.value = true
    }
    
    function hideSidebar() {
        sidebarOpened.value = false
    }
    
    function logout() {
        showAlertQuestion({
            title: "Konfirmasi",
            message: "Yakin ingin logout?",
            onOk() {
                SessionManager.logout()
                goto("login")
            }
        })
    }
    
    function onResize() {
        innerWidth.value = window.innerWidth
    }
    
    let sidebarEl: HTMLDivElement
    
    function sidebarClickOutside(event: any) {
        if (sidebarEl && !sidebarEl.contains(event.target) && !event.defaultPrevented) {
            hideSidebar()
        }
    }
    
    onMount(() => {
        window.addEventListener('resize', onResize)
        document.addEventListener('click', sidebarClickOutside, true)
    })
    
    onDestroy(() => {
        window.removeEventListener('resize', onResize)
        document.removeEventListener('click', sidebarClickOutside, true)
    })
    
    return <>
        <div class="h-screen">
            <div class="flex flex-row h-screen overflow-hidden bg-linear-to-br from-back to-primary/20">
                <div
                    class={twMerge(
                        "flex flex-col bg-white h-full shadow-lg absolute z-10 w-[300px] transition-all",
                        isSmall.value && !sidebarOpened.value ? "left-[-300px]" : "left-0",
                    )}
                    ref={v => sidebarEl = v}
                >
                    <a
                        class="flex flex-row items-center px-4 pl-8 py-4 justify-start bg-red-400/0 border-b border-black-extra-light/50"
                        href="/"
                    >
                        <img src="/images/user.webp" alt="logo" class="w-8 h-8"/>
                        <div class="flex flex-col ms-2">
                            <span class="text-xl font-semibold text-[#4a7075] font-secondary">Public Speaking</span>
                            <span class="text-xs">Halaman Admin</span>
                        </div>
                    </a>
                    
                    {/* <div class="text-primary-dark font-bold pl-8 pr-4">{SessionManager.school.value?.name}</div> */}
                    
                    <Sidebar
                        sections={sidebarSections}
                        onSelect={() => sidebarOpened.value = false}
                    />
                    
                    {/* <TextInput
                        class="m-3"
                        placeholder="Filter menu..."
                        value={sidebarFilter.value}
                        onChange={v => sidebarFilter.value = v}
                    /> */}
                </div>
                
                <div
                    class={twMerge(
                        "flex flex-col flex-1",
                        isSmall.value ? "" : "ml-[300px]",
                    )}
                >
                    <div class="flex flex-row px-6 -mb-2 pt-2 items-center">
                        {isSmall.value && (
                            <button
                                class="p-1 mr-2 hover:bg-gray-500/10 transition-colors rounded cursor-pointer flex items-center"
                                onclick={openSidebar}
                            >
                                <Icon
                                    icon="icon-[mdi--hamburger-menu]"
                                    class="text-2xl text-black-light"
                                />
                            </button>
                        )}
                        
                        <Breadcrumb/>
                        
                        <div class="flex-1"></div>
                        
                        <MenuPopup
                            elId="menu-popup"
                            popupClass="w-60"
                            items={[
                                {
                                    type: "button",
                                    text: "Logout",
                                    icon: "icon-[mdi--logout]",
                                    onClick: logout,
                                },
                            ]}
                            header={
                                <div class="flex flex-col items-start px-4 pt-2 pb-4 mb-2 text-black-medium border-b border-black-extra-light">
                                    <span class="text-xs">{SessionManager.userData.value?.email}</span>
                                </div>
                            }
                        >
                            <div id="menu-popup" class="text-black-50 flex items-center pl-4 py-1 pr-1">
                                <span class="mr-2">{SessionManager.name.value}</span>
                                
                                <img
                                    src="/images/user.webp"
                                    class="w-9 h-9 rounded-full border-3 border-white bg-white"
                                />
                            </div>
                        </MenuPopup>
                    </div>
                    
                    <div class="h-full overflow-auto">
                        {props.children}
                    </div>
                </div>
            </div>
        </div>
    </>
}