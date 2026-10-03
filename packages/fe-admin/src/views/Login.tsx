import { goto, prevent, state } from "@pang"
import { Button } from "@tahfeedz/fe-core/components/Button.jsx"
import { TextInput } from "@tahfeedz/fe-core/components/input/TextInput.jsx"
import { showToastSuccess } from "@tahfeedz/fe-core/components/Toast.jsx"
import { Validation, ValidationRef } from "@tahfeedz/fe-core/components/validation/Validation.jsx"
import { AuthApi } from "@tahfeedz/fe-core/data/auth_api.js"
import { SessionManager } from "@tahfeedz/fe-core/data/session.js"
import { apiOrToastWithLoading } from "@tahfeedz/fe-core/utils/api.js"

export function Login() {
    let validation: ValidationRef
    
    const username = state('')
    const password = state('')
    
    async function login() {
        if (!await validation.validate()) return
        
        apiOrToastWithLoading(AuthApi.login(username.value, password.value), r => {
            showToastSuccess("Success login")
            SessionManager.login(r, r.token)
            goto("/")
        })
    }
    
    return <div class="h-screen flex flex-col bg-linear-to-br from-back-dark/30 to-primary/20 justify-center">
        <div class="overflow-auto px-16 pt-8 pb-16">
            <div class="flex-1 flex container mx-auto max-h-[550px] max-w-[500px] lg:max-w-[1000px] px-0 shadow-lg">
                <div class="bg-linear-to-br from-white to-back p-8 flex-1 box-border flex items-center justify-center">
                    <Validation ref={x => validation = x}>
                        <form onsubmit={prevent()}>
                            <div class="flex flex-row items-center p-4 justify-center bg-red-400/0">
                                <img src="/images/logo.png" alt="logo" class="w-8 h-8"/>
                                <div class="flex flex-col ms-2">
                                    <span class="text-xl font-semibold text-[#4a7075] font-secondary">Tahfeedz</span>
                                    <span class="text-xs">Tahfidz Made Easy</span>
                                </div>
                            </div>
                            
                            <h2 class="text-black-light text-2xl mt-4 font-semibold font-secondary">Login</h2>
                            <h2 class="text-black-light/70 text-sm mb-4">Masukkan username dan password untuk masuk ke halaman dashboard</h2>

                            <TextInput
                                id="t-username"
                                label="Username"
                                value={username.value}
                                onChange={v => username.value = v}
                                required={true}
                            />

                            <TextInput
                                id="t-password"
                                class="mt-2"
                                type="password"
                                label="Password"
                                value={password.value}
                                onChange={v => password.value = v}
                                required={true}
                            />
                            
                            <Button 
                                type="submit"
                                color="primary"
                                size="lg" 
                                class="w-full mt-4 font-bold" 
                                onclick={login} 
                            >
                                Login
                            </Button>
                        </form>
                    </Validation>
                </div>
                <div 
                    class="bg-primary text-white flex-1 p-8 box-border hidden relative lg:flex flex-col items-center justify-center
                    overflow-hidden"
                >
                    <img 
                        src="/images/office.jpg" 
                        class="absolute opacity-[0.13] h-full w-full object-cover hover:scale-110 transition-transform duration-500"
                    />
                    
                    <div class="relative flex flex-col items-center pointer-events-none">
                        <span class="font-bold text-3xl">Selamat Datang!</span>
                        <span class="mt-4 text-xl font-bold">Aplikasi Tahfeedz</span>
                        <span class="font-semibold">Tahfidz made easy</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
}