import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {

    static targets = ["messages", "scrollDown", "textarea"]
    
    connect() {
        this.addActionCable(this)
        console.log('ChatController: Connect')
    }

    disconnect() {
        this.subscription.unsubscribe()
        console.log('ChatController: Disconnect')
    }

    // Инициализация Action Cable
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

    // Добавление сообщения
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

    // Инициализация чата
    addChat(chat, data) {
        chat.element.innerHTML = data['chat']
        chat.addEventOnScroll(chat)
        chat.setScrollPosition(chat)
    }

    // Добавление события появления кнопки прокрутки для скролла
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

    // Перемотка скролла вниз
    scrollToDown() {
        this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
    }

    // Установка позиции скролла после смены страницы
    setScrollPosition(chat) {
        if (chat.hasMessagesTarget) {
            chat.messagesTarget.scrollTop = chat.scrollPosition
            if (chat.messagesTarget.scrollTop == 0) {
                chat.messagesTarget.scrollTop = chat.messagesTarget.scrollHeight
            } 
        }
    }

    // Сохранение позиции скролла перед сменой страницы
    saveScrollPosition() {
        this.scrollPosition = this.messagesTarget.scrollTop
    }

    // Добавление ошибки 
    addError(event) {
        let [data, status, xhr] = event.detail

        if (status == '400' || status.toLowerCase() == 'bad request') {
            let customEvent = new CustomEvent('notify', { detail: xhr.response })
            document.dispatchEvent(customEvent)
        }
    }
}