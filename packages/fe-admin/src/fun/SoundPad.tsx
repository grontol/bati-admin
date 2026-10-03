import { foreach, onDestroy, onMount } from "@pang"

export function SoundPad() {
    let padEl: HTMLDivElement
    
    const audioCtx = new window.AudioContext()
    
    const oscillator = audioCtx.createOscillator()
    const filterNode = audioCtx.createBiquadFilter()
    const gainNode = audioCtx.createGain()
    
    oscillator.type = "square"
    filterNode.type = "lowpass"
    
    oscillator.connect(filterNode)
    filterNode.connect(gainNode)
    gainNode.connect(audioCtx.destination)
    
    let isStarted = false
    let isMouseDown = false
    let volume = 0.2
    
    function mouseDown(e: MouseEvent) {
        isMouseDown = true
        playNote(e.offsetX, e.offsetY)
    }
    
    function mouseMove(e: MouseEvent) {
        if (isMouseDown) {
            playNote(e.offsetX, e.offsetY)
        }
    }
    
    function mouseUp() {
        gainNode.gain.value = 0
        isMouseDown = false
    }
    
    function touchDown(e: TouchEvent) {
        isMouseDown = true
        playNote(e.touches[0].clientX, e.touches[0].clientY)
    }
    
    function touchMove(e: TouchEvent) {
        if (isMouseDown) {
            playNote(e.touches[0].clientX, e.touches[0].clientY)
        }
    }
    
    function touchEnd() {
        gainNode.gain.value = 0
        isMouseDown = false
    }
    
    function playNote(x: number, y: number) {
        if (!isStarted) {
            oscillator.start()
            isStarted = true
        }
        
        const freqMin = 261
        const freqMax = freqMin * 2
        
        const xPerc = x / padEl.clientWidth
        const yPerc = 1 - (y / padEl.clientHeight)
        
        const freq = freqMin * Math.pow(freqMax / freqMin, xPerc)
        const cutoff = 300 * Math.pow(10000 / 300, yPerc)
        
        // gainNode.gain.value = yPerc * 0.5
        gainNode.gain.value = volume
        oscillator.frequency.setValueAtTime(freq, audioCtx.currentTime)
        filterNode.frequency.setTargetAtTime(cutoff, audioCtx.currentTime, 0.05)
        filterNode.Q.value = 10
    }
    
    onMount(() => {
    })
    
    onDestroy(() => {
        if (isStarted) {
            oscillator.stop()
        }
    })
    
    return <div
        ref={x => padEl = x}
        class="absolute left-0 right-0 top-0 bottom-0 bg-red-200 flex"
        onmousedown={mouseDown}
        onmousemove={mouseMove}
        onmouseup={mouseUp}
        ontouchstart={touchDown}
        ontouchmove={touchMove}
        ontouchend={touchEnd}
        ontouchcancel={touchEnd}
    >
        {foreach(12, i => (
            <div class="flex-1 border-2 border-red-600 pointer-events-none"/>
        ))}
    </div>
}