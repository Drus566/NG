import { Controller } from "stimulus"

export default class extends Controller {

    static targets = ["form", "replies"]

    replyCommentForm(event) {
        if (this.hasFormTarget) {
            if(this.formTarget.dataset.form == 'closed') {
                this.formTarget.dataset.form = "open"
                let [data, status, xhr] = event.detail
                this.formTarget.innerHTML += xhr.response
            }
        }
    }

    editCommentForm(event) {
        if (this.hasFormTarget) {
            if(this.formTarget.dataset.form == 'closed') {
                this.formTarget.dataset.form = "open"
                let [data, status, xhr] = event.detail
                this.formTarget.innerHTML += xhr.response
            }
        }   
    }

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
    
    createComment(event) {
        this.mutationsObserver
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
        }
    }

    updateComment(event) {

    }

    deleteComment(event) {
        event.preventDefault()
        console.log("СРАБОТАЛ")
        if (this.element && this.element.parentElement.parentElement.dataset.replies == 'true') {            
            let comment = this.element
            if (comment.nextElementSibling && comment.previousElementSibling
                && comment.nextElementSibling.className == 'comment-spacer'
                && comment.previousElementSibling.className == 'comment-spacer') {
                comment.nextElementSibling.remove()
                comment.remove()
            } else if (comment.nextElementSibling && comment.nextElementSibling.className == 'comment-spacer') {
                comment.nextElementSibling.remove()
                comment.remove()
            } else if (comment.previousElementSibling && comment.previousElementSibling.className == 'comment-spacer') {
                comment.previousElementSibling.remove()
                comment.remove()
            } else if (comment.nextElementSibling == null && comment.previousElementSibling == null) {
                comment.parentElement.parentElement.dataset.replies = 'false'
                comment.parentElement.remove()
            }
        }
    }
}
