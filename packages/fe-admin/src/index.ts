import { routerConfig } from "@/routes.js"
import { render, Router } from "@pang/index.js"
import "@pang/jsx.js"
import "./index.css"

const app = document.getElementById('app')!
render(app, Router(routerConfig))

if (import.meta.hot) {
    import.meta.hot.accept()
}