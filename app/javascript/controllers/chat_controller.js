import { Controller } from "stimulus"

export default class extends Controller {

    static targets = ["messages"]
    
    addMessage(event) {
        let [data, status, xhr] = event.detail
        
        if (this.hasMessagesTarget) {
            this.messagesTarget.innerHTML += xhr.response
        }
    }
}