import { Controller } from "stimulus"

export default class extends Controller {

    static targets = ["form", "replies"]

    // открытие формы ответа на комментарий
    replyCommentForm(event) {
        if (this.hasFormTarget) {
            let [data, status, xhr] = event.detail

            if(this.formTarget.dataset.form == 'closed') {
                this.formTarget.dataset.form = "open"        
                this.formTarget.innerHTML += xhr.response
            }    
        }
    }

    // Отрытие формы редактирования комментария
    editCommentForm(event) {
        if (this.hasFormTarget) {
            let [data, status, xhr] = event.detail

            if(this.formTarget.dataset.form == 'closed') {
                this.formTarget.dataset.form = "open"        
                this.formTarget.innerHTML += xhr.response
            }
        }   
    }

    // Удаление формы комментария
    deleteCommentForm() {
        if (this.hasFormTarget) {
            if(this.formTarget.dataset.form == 'open') {
                for (let i = 0; i < this.formTarget.children.length; i++) {
                    this.formTarget.children[i].remove()
                }
                this.formTarget.dataset.form = 'closed'
            }
        }   
    }
    
    // Создание комментария
    createComment(event) {
        if (this.hasRepliesTarget) {
            let [data, status, xhr] = event.detail

            if (this.repliesTarget.dataset.replies == 'true') {
                let spacer = document.createElement('div')
                spacer.classList.add('comment-spacer')
                this.repliesTarget.firstElementChild.prepend(spacer)
                this.repliesTarget.firstElementChild.firstElementChild.insertAdjacentHTML('beforebegin', xhr.response)
            } else {
                let replies = document.createElement('ul')
                replies.classList.add('comments-replies')
                replies.innerHTML = xhr.response
                this.repliesTarget.prepend(replies)
                this.repliesTarget.dataset.replies = 'true'
            }
            this.formTarget.dataset.form = 'closed'
            this.formTarget.firstElementChild.remove()
        }
    }

    // Обновление коммента
    updateComment(event) {
        let [data, status, xhr] = event.detail
        this.element.innerHTML = xhr.response
    }

    // Добавление ошибки
    addError(event) {
        let [data, status, xhr] = event.detail
        console.log(status)
        // Если это ошибка 401, то отправляем
        if (status == '400' || status.toLowerCase() == 'bad request') {
            console.log('Send')
            let customEvent = new CustomEvent('notify', { detail: xhr.response })
            document.dispatchEvent(customEvent)
        }
    }
}
