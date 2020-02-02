import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {

    static targets = ["messages"]

    initialize() {

    }
    
    connect() {
        this.addActionCable(this)
    }

    disconnect() {
        this.subscription.unsubscribe();
        this.saveScrollPosition(this)
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
                let btn = document.querySelector('.btn-scroll-down')
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
        let scrollPos = localStorage.getItem('scrollPosition')

        if (scrollPos) {
            chat.messagesTarget.scrollTop = scrollPos
        }
    }

    saveScrollPosition(chat) {
        let scrollPos = chat.messagesTarget.scrollTop
        localStorage.setItem('scrollPosition', scrollPos)
    }
}