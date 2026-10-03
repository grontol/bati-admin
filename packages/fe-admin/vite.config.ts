import tailwindcss from "@tailwindcss/vite"
import path from "path"
import { defineConfig } from 'vite'
import checker from "vite-plugin-checker"
import { transformJsxPlugin } from "../fe-core/src/lib/pang/jsx-transform.js"

export default defineConfig({
    root: "./",
    build: {
        outDir: "./build"
    },
    plugins: [
        tailwindcss({
            
        }),
        checker({
            typescript: true,
        }),
        transformJsxPlugin(),
    ],
    server: {
        fs: {
            allow: [
                path.resolve(__dirname, "./"),
                path.resolve(__dirname, "../fe-core")
            ]
        }
    },
    resolve: {
        alias: {
            '@pang': path.resolve(__dirname, '../fe-core/src/lib/pang'),
            "@tahfeedz/fe-core/components": path.resolve(__dirname, "../fe-core/src/components"),
            "@tahfeedz/fe-core": path.resolve(__dirname, "../fe-core/src"),
            '@': path.resolve(__dirname, 'src'),
            "@tahfeedz/shared": path.resolve(__dirname, "../shared/src"),
        }
    },
})