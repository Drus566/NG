import { Controller } from "stimulus"

export default class extends Controller {
    
    static targets = ["comments", "form"]

    createCommentForm(event) {
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
        if (this.hasCommentsTarget) {
            let [data, status, xhr] = event.detail
            if (this.commentsTarget.dataset.comments == 'true') {
                this.commentsTarget.firstElementChild.firstElementChild.insertAdjacentHTML('beforebegin', xhr.response)
            } else {
                console.log(xhr.response)
                this.commentsTarget.innerHTML += xhr.response
                this.commentsTarget.dataset.comments = 'true'
            }
        }
    }

    deleteComment(event) {
        if (this.hasCommentsTarget && this.commentsTarget.dataset.comments == 'true') { 
            let commentId = event.target.getAttribute('href').split('/')[4]
            let comment = this.commentsTarget.querySelector(`#comment-${commentId}`)
            if (comment.nextElementSibling && comment.previousElementSibling) {
                comment.nextElementSibling.remove()
                comment.remove()
            } else if (comment.nextElementSibling) {
                comment.nextElementSibling.remove()
                comment.remove()
            } else if (comment.previousElementSibling) {
                comment.previousElementSibling.remove()
                comment.remove()
            } else if (comment.nextElementSibling == null && comment.previousElementSibling == null) {
                this.commentsTarget.dataset.comments = 'false'
                for (let i = 0; this.commentsTarget.children.length; i++) {
                    this.commentsTarget.children[i].remove()
                }
            }
        }
    }
}
