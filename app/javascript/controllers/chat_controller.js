import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {

    static targets = ["messages"]
    
    connect() {
        let chat = this
        this.subscription = consumer.subscriptions.create("ChatChannel", {
                connected() {
                },
                disconnected() {
                },
                received(data) {
                    if (data['chat']) {
                        chat.element.innerHTML = data['chat']
                    } else {
                        if (chat.hasMessagesTarget) {
                            chat.messagesTarget.insertAdjacentHTML('beforeEnd', data)
                            if (chat.messagesTarget.scrollTop == chat.messagesTarget.scrollHeight) {
                                chat.messagesTarget.scrollTop = chat.messagesTarget.scrollHeight
                            }
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