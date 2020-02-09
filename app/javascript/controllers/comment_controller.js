import { Controller } from "stimulus"

export default class extends Controller {

    static targets = ["form", "replies"]

    replyCommentForm(event) {
        if (this.hasFormTarget) {

            let [data, status, xhr] = event.detail

            if (xhr.response.trimLeft().toLowerCase().startsWith('<div class="reply-comment-form"')) {
                if(this.formTarget.dataset.form == 'closed') {
                    this.formTarget.dataset.form = "open"        
                    this.formTarget.innerHTML += xhr.response
                }    
            }
        }
    }

    editCommentForm(event) {
        if (this.hasFormTarget) {

            let [data, status, xhr] = event.detail

            if (xhr.response.trimLeft().toLowerCase().startsWith('<div class="edit-comment-form"')) {
                if(this.formTarget.dataset.form == 'closed') {
                    this.formTarget.dataset.form = "open"        
                    this.formTarget.innerHTML += xhr.response
                }
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
        if (this.hasRepliesTarget) {
            let [data, status, xhr] = event.detail
            
            if (xhr.response.trimLeft().toLowerCase().startsWith('<div class="comment-tree"')) {    
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
    }

    updateComment(event) {
        let [data, status, xhr] = event.detail

        if (xhr.response.trimLeft().toLowerCase().startsWith('<div class="comment-tree"')) { 
            this.element.innerHTML = xhr.response
        } 
    }

    addError(event) {
        let [data, status, xhr] = event.detail

        console.log(xhr.response)
    }
}
