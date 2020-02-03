import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {

    static targets = ["messages", "scrollDown"]

    initialize() {

    }
    
    connect() {
        this.addActionCable(this)
        console.log('ChatController: Connect')
    }

    disconnect() {
        this.subscription.unsubscribe()
        console.log('ChatController: Disconnect')
    }

    addActionCable(chat) {
        this.subscription = consumer.subscriptions.create("ChatChannel", {
                connected() {
                },
                disconnected() {
                },
                received(data) {
                    data['chat'] ? chat.addChat(chat, data) : chat.addMessage(chat, data)
                }
            }
        )
    }

    addMessage(chat, data) {
        if (chat.hasMessagesTarget) {
            if (chat.messagesTarget.scrollHeight - chat.messagesTarget.scrollTop === chat.messagesTarget.clientHeight) {
                chat.messagesTarget.insertAdjacentHTML('beforeEnd', data)
                chat.messagesTarget.scrollTop += chat.messagesTarget.clientHeight
            } else {
                chat.messagesTarget.insertAdjacentHTML('beforeEnd', data)
            }
        }
    }

    addChat(chat, data) {
        chat.element.innerHTML = data['chat']
        chat.addEventOnScroll(chat)
        chat.setScrollPosition(chat)
    }

    addEventOnScroll(chat) {
        let ticking = false

        if (chat.hasMessagesTarget) {
            chat.messagesTarget.addEventListener('scroll', function(e) {
                let btn = chat.scrollDownTarget
                if (!ticking) {
                    window.requestAnimationFrame(function() {
                        if (chat.messagesTarget.scrollHeight - chat.messagesTarget.scrollTop !== chat.messagesTarget.clientHeight) {
                            if (!btn.classList.contains('active')) {
                                btn.classList.add('active')
                            }
                        } else {
                            if (btn.classList.contains('active')) {
                                btn.classList.remove('active')
                            }
                        }
                        ticking = false
                    })
                    ticking = true
                }
            })
        }
    }

    scrollToDown() {
        this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
    }

    setScrollPosition(chat) {
        if (chat.hasMessagesTarget) {
            chat.messagesTarget.scrollTop = chat.scrollPosition
            if (chat.messagesTarget.scrollTop == 0) {
                chat.messagesTarget.scrollTop = chat.messagesTarget.scrollHeight
            } 
        }
    }

    saveScrollPosition() {
        this.scrollPosition = this.messagesTarget.scrollTop
    }
}