import { Controller } from "stimulus"

export default class extends Controller {

    static targets = ["notify"]

    addNotify(event) {
        if (hasNotifyTarget) {
            this.notifyTarget.classList.add('notify-active')
            this.notifyTarget.innerHTML = event.detail
            if (this.data.has("interval")) {
                setInterval(() => {
                    this.clear()
                }, this.data.get("interval"))
            }
        }        
    }

    clear() {
        this.notifyTarget.innerHTML = ""
        this.notifyTarget.classList.remove('notify-active')
    }
}