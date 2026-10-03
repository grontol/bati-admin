import { SessionResultList } from "@/views/admin/session-result/SessionResultList.jsx";
import { Dashboard } from "@/views/Dashboard.jsx";
import { DashboardAdmin } from "@/views/DashboardAdmin.jsx";
import { Maintenance, NotFound, SomethingWrong, Unauthorized } from "@/views/Errors.jsx";
import { Home } from "@/views/Home.jsx";
import { Login } from "@/views/Login.jsx";
import { Root } from "@/views/Root.jsx";
import { AuthGuardResult, RouterConfig } from "@pang/router.js";
import { SessionManager } from "@tahfeedz/fe-core/data/session.js";

function guardRoles(): AuthGuardResult {
    if (!SessionManager.isLogin() || !SessionManager.userData.value) {
        return { type: "redirect", path: "login" }
    }
    
    return true
}

export const routerConfig: RouterConfig = {
    routes: [
        {
            path: '',
            component: Root,
            children: [
                {
                    path: 'login',
                    component: Login,
                },
                {
                    path: '',
                    component: Dashboard,
                    children: [
                        {
                            path: '',
                            component: DashboardAdmin,
                            children: [
                                {
                                    path: '',
                                    authGuard: () => guardRoles(),
                                    children: [
                                        {
                                            path: '',
                                            component: Home,
                                        },
                                        {
                                            path: 'session-result',
                                            component: SessionResultList,
                                        },
                                    ]
                                }
                            ]
                        },
                    ]
                }
            ]
        },
        {
            path: "something-wrong",
            component: SomethingWrong,
        },
        {
            path: "maintenance",
            component: Maintenance,
        },
    ],
    notFound: NotFound,
    unauthorized: Unauthorized,
}