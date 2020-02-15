import { Controller } from "stimulus"

export default class extends Controller {
    
    connect() {
        this.element.addEventListener("trix-file-accept", function(event) {
            let customEvent = new CustomEvent('notify', { detail: `<div class="error">Невозможно прикрепить файл</div>` })
            document.dispatchEvent(customEvent)
            event.preventDefault()
        })
    }
}