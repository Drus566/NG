import { Controller } from "stimulus"

export default class extends Controller {

    addError(event) {
        let [data, status, xhr] = event.detail

        if (status == '400' || status.toLowerCase() == 'bad request') {
            console.log('Send')
            let customEvent = new CustomEvent('notify', { detail: xhr.response })
            document.dispatchEvent(customEvent)
        }
    }
}