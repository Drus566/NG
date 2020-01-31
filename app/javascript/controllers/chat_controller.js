import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {

    static targets = ["messages"]
    
    connect() {
        let chat = this
        this.subscription = consumer.subscriptions.create("ChatChannel", {
                connected() {
                    console.log('WAY')
                },
                disconnected() {
                    console.log('ActionCable: Disconnect')
                },
                received(data) {
                    console.log('ActionCable: Received')
                    console.log(data)
                    console.log(data['chat'])
                    if (data['chat']) {
                        chat.element.innerHTML = data['chat']
                    } else {
                        if (chat.hasMessagesTarget) {
                            chat.messagesTarget.insertAdjacentHTML('beforeEnd', data)
                        }
                    }
                }
            }
        )
    }

    disconnect() {
        this.subscription.unsubscribe();
        Console.log('ChatController: Disconnect')
    }

    addMessage(event) {
        let [data, status, xhr] = event.detail
        
        if (this.hasMessagesTarget) {
            this.messagesTarget.innerHTML += xhr.response
        }
    }
}