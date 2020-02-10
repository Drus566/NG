import { Controller } from "stimulus"

export default class extends Controller {

    static targets = ["notify"]

    connect() {
        this.count = 0
    }

    addNotify(event) {
        console.log('notify')
        if (this.hasNotifyTarget) {
            this.notifyTarget.classList.add('notify-active')
            this.notifyTarget.innerHTML = event.detail
            this.count += 1

            if (this.notifyTarget.dataset.interval) {
                setTimeout(() => {
                    this.clear()
                }, this.notifyTarget.dataset.interval)
            }
        }        
    }

    clear() {
        if (this.count <= 1){
            this.notifyTarget.innerHTML = ""
            this.notifyTarget.classList.remove('notify-active')
        }
        this.count -= 1
    }
}