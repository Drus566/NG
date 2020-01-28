import { Controller } from "stimulus"

export default class extends Controller {

    static targets = ["content"]

    setContent(event) {
        console.log('content')
        let [data, status, xhr] = event.detail
        if (this.hasContentTarget) {
            this.contentTarget.innerHTML = xhr.response
        }
    }
}