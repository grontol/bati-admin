import { foreach, onMount, state } from "@pang"
import { twJoin } from "tailwind-merge"

export function Gamebot() {
    const dots = state<boolean[]>(Array.from({ length: 200 }, () => false))
    const curGame = state<Game | null>(null)
    
    function render(data: DisplayData) {
        dots.value = data.dots
    }
    
    function exitGame() {
        
    }
    
    function runGame(game: Game) {
        game.start({
            render,
            exitGame,
        })
        
        curGame.value = game
    }
    
    onMount(() => {
        runGame(new Tetris())
    })
    
    return <div
        class="h-screen w-screen bg-gray-700 flex items-center justify-center"
    >
        <img
            src="/images/gamebot.png"
            class="h-full rounded-4xl"
        />
        
        <div class="bg-[#8F9F92] border-2 border-gray-700 w-[15%] aspect-1/2 absolute top-[5%] left-[10%]">
            {foreach(20, y => (
                <div class="flex">
                    {foreach(10, x => (
                        <div class="flex-1 aspect-square border border-black-medium relative">
                            <div
                                class={twJoin(
                                    "bg-black-medium absolute inset-0.5",
                                    dots.value[y * 10 + x] ? "" : "hidden"
                                )}
                            />
                        </div>
                    ))}
                </div>
            ))}
        </div>
    </div>
}

type DisplayData = {
    dots: boolean[]
}

type GameCallbackData = {
    render: (data: DisplayData) => void
    exitGame: () => void
}

interface Game {
    start: (cb: GameCallbackData) => void
    stop: () => void
}

class Tetris implements Game {
    cb?: GameCallbackData
    
    start(cb: GameCallbackData) {
       this.cb = cb
       
       this.loop()
    }
    
    stop() {
        
    }
    
    loop() {
        
    }
}