// import { Button } from "@tahfeedz/fe-core/components/Button.jsx";
// import { AdminFullPopup } from "@tahfeedz/fe-core/components/container/AdminFullPopup.jsx";
// import { SelectInput } from "@tahfeedz/fe-core/components/input/SelectInput.jsx";
// import { TextInput } from "@tahfeedz/fe-core/components/input/TextInput.jsx";
// import { showToastInsertFailed, showToastInsertSuccess, showToastUpdateFailed, showToastUpdateSuccess } from "@tahfeedz/fe-core/components/Toast.jsx";
// import { Validation, ValidationRef } from "@tahfeedz/fe-core/components/validation/Validation.jsx";
// import { ApiResponse } from "@tahfeedz/fe-core/data/api.js";
// import { UserApi, UserData, UserInputData, UserRoleData, userRoles } from "@tahfeedz/fe-core/data/user_api.js";
// import { state } from "@pang";

// export type InputUserRef = {
//     add(): void
//     edit(data: UserData): void
// }

// export function InputUser(props: Refable<{
//     onRefresh: () => void
//     data: UserData[],
// }, InputUserRef>) {
//     props.ref?.({
//         add,
//         edit,
//     })
    
//     let validation: ValidationRef
//     let editId: string | null = null
    
//     const isVisible = state(false)
//     const isEdit = state(false)
    
//     const name = state("")
//     const role = state<UserRoleData>("shop")
//     const email = state("")
//     const phone = state("")
//     const password = state("")
//     const alamat = state("")
//     const latitude = state("")
//     const longitude = state("")
    
//     function add() {
//         isVisible.value = true
//         isEdit.value = false
        
//         editId = null
//         name.value = ""
//         role.value = "shop"
//         email.value = ""
//         phone.value = ""
//         alamat.value = ""
//         latitude.value = ""
//         longitude.value = ""
//     }
    
//     function edit(data: UserData) {
//         isVisible.value = true
//         isEdit.value = true
        
//         editId = data.id
//         name.value = data.name
//         role.value = data.role
//         email.value = data.email
//         phone.value = data.phone
//         alamat.value = data.alamat
//         latitude.value = data.latitude.toString()
//         longitude.value = data.longitude.toString()
//     }
    
//     async function save() {
//         if (!(await validation.validate())) return
        
//         const data: UserInputData = {
//             name: name.value,
//             role: role.value,
//             email: email.value,
//             phone: phone.value,
//             password: password.value,
//             alamat: alamat.value,
//             latitude: +latitude.value,
//             longitude: +longitude.value,
//         }
        
//         let res: ApiResponse<any>
        
//         if (editId) {
//             res = await UserApi.update(editId, data)
//         }
//         else {
//             res = await UserApi.insert(data)
//         }
        
//         if (res.success) {
//             if (editId) showToastUpdateSuccess()
//             else showToastInsertSuccess()
            
//             isVisible.value = false
            
//             props.onRefresh()
//         }
//         else {
//             if (editId) showToastUpdateFailed()
//             else showToastInsertFailed()
//         }
//     }
    
//     function cancel() {
//         isVisible.value = false
//     }
    
//     return <AdminFullPopup
//         visible={isVisible.value}
//         title="Input Data User"
//         subtitle="Input Data User"
//         action={<div class="flex justify-end gap-2">
//             <Button type="button" style="outline" onclick={cancel}>Batal</Button>
//             <Button type="submit" onclick={save}>Simpan</Button>
//         </div>}
//         onCancel={cancel}
//     >
//         <Validation ref={v => validation = v}>
//             <div class="grid grid-cols-2 gap-4 mt-4">
//                 <TextInput
//                     label="Nama"
//                     value={name.value}
//                     onChange={v => name.value = v}
//                     required={true}
//                     autofocus={true}
//                 />
                
//                 <SelectInput
//                     label="Role"
//                     options={userRoles}
//                     value={role.value}
//                     onChange={v => role.value = v}
//                     required={true}
//                 />
                
//                 <TextInput
//                     label="Email"
//                     value={email.value}
//                     onChange={v => email.value = v}
//                     required={true}
//                 />
                
//                 <TextInput
//                     label="Phone"
//                     value={phone.value}
//                     onChange={v => phone.value = v}
//                     required={role.value === "shop"}
//                 />
                
//                 <TextInput
//                     label={`Password${isEdit.value ? " (Biarkan kosong kalau tidak mau mengubah)" : ""}`}
//                     value={password.value}
//                     onChange={v => password.value = v}
//                     required={!isEdit.value}
//                 />
                
//                 <TextInput
//                     label="Alamat"
//                     value={alamat.value}
//                     onChange={v => alamat.value = v}
//                     required={role.value === "shop"}
//                 />
                
//                 <TextInput
//                     label="Latitude"
//                     value={latitude.value}
//                     onChange={v => latitude.value = v}
//                     type="number"
//                     required={role.value === "shop"}
//                 />
                
//                 <TextInput
//                     label="longitude"
//                     value={longitude.value}
//                     onChange={v => longitude.value = v}
//                     type="number"
//                     required={role.value === "shop"}
//                 />
//             </div>
//         </Validation>
//     </AdminFullPopup>
// }