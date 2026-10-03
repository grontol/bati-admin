import { effect, onMount } from "@pang"
import { twMerge } from "tailwind-merge"

export function CircleProgress(props: { progress: number, color: string }) {    
    return <div class="w-11 h-11 flex items-center justify-center relative">
        
        <div
            class="w-full h-full absolute rounded-full"
            style={{ background: `${props.color}33` }}
        />
        
        <div
            class="w-full h-full absolute"
            style={{
                clipPath: `polygon(${createPolygon(props.progress)})`
            }}
        >
            <div
                class="w-full h-full origin-center rounded-full"
                style={{
                    background: props.color,
                    transform: `rotate(45deg)`
                }}
            />
        </div>
        
        <div
            class="w-9 h-9 border-transparent bg-white absolute rounded-full"
        />
        
        <span class="relative text-xxs font-bold">{Math.round(props.progress)}%</span>
    </div>
}

export function ProgressView(props: {
    progress: number
    activeColor?: string
    inactiveColor?: string
    textColor?: string
    
    class?: string
    textClass?: string
}) {
    let canvas: HTMLCanvasElement
    let ctx: CanvasRenderingContext2D | null = null
    
    effect(draw)
    
    function draw() {
        if (!ctx) return
        
        ctx.fillStyle = "transparent"
        ctx.clearRect(0, 0, 200, 200)
        
        const rad = props.progress * 2 * Math.PI / 100
        const x = 100 + 80 * Math.cos(rad)
        const y = 100 + 80 * Math.sin(rad)
        
        const pie = new Path2D()
        pie.arc(100, 100, 100, 0, rad)
        pie.lineTo(x, y)
        pie.arc(100, 100, 80, rad, 0, true)
        
        const ring = new Path2D()
        ring.ellipse(100, 100, 100, 100, 0, 0, 2 * Math.PI)
        ring.ellipse(100, 100, 80, 80, 0, 0, 2 * Math.PI, true)
        
        ctx.fillStyle = props.inactiveColor ?? "#DDDDDD"
        ctx.fill(ring)
        
        ctx.fillStyle = props.activeColor ?? "red"
        ctx.fill(pie)
    }
    
    effect(() => {
        props.progress;
        
        draw()
    })
    
    onMount(() => {
        ctx = canvas.getContext("2d")!
        draw()
    })
    
    return <div
        class={twMerge(
            "w-12 h-12 relative",
            props.class,
        )}
    >
        <canvas
            width="200"
            height="200"
            class="w-full h-full"
            ref={v => canvas = v}
        />
        
        <span
            class={twMerge(
                "absolute inset-0 flex items-center justify-center font-bold text-xs",
                props.textClass,
            )}
            style={{ color: props.textColor ?? props.activeColor ?? "red" }}
        >{Math.round(props.progress)}%</span>
    </div>
}

function createPolygon(progress: number) {
    const angle = progress * 360 / 100
    const rad = angle * Math.PI / 180
    
    let points: [number, number][]
    const last: [number, number] = [Math.floor(200 * Math.cos(rad) + 50), Math.floor(200 * Math.sin(rad) + 50)]
    
    if (angle <= 45) {
        points = [[50, 50], [100, 50], last]
    }
    else if (angle <= 90) {
        points = [[50, 50], [100, 50], [100, 100], last]
    }
    else if (angle <= 135) {
        points = [[50, 50], [100, 50], [100, 100], [50, 100], last]
    }
    else if (angle <= 180) {
        points = [[50, 50], [100, 50], [100, 100], [50, 100], [0, 100], last]
    }
    else if (angle <= 225) {
        points = [[50, 50], [100, 50], [100, 100], [50, 100], [0, 100], [0, 50], last]
    }
    else if (angle <= 270) {
        points = [[50, 50], [100, 50], [100, 100], [50, 100], [0, 100], [0, 50], [0, 0], last]
    }
    else if (angle <= 315) {
        points = [[50, 50], [100, 50], [100, 100], [50, 100], [0, 100], [0, 50], [0, 0], [50, 0], last]
    }
    else {
        points = [[50, 50], [100, 50], [100, 100], [50, 100], [0, 100], [0, 50], [0, 0], [50, 0], [100, 0], last]
    }
    
    return points.map(x => `${x[0]}% ${x[1]}% `).join(", ")
}