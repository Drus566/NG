import { Controller } from "stimulus"

export default class extends Controller {
    
    connect() {
        this.element.addEventListener("trix-file-accept", function(event) {
            event.preventDefault()
        })
    }
}