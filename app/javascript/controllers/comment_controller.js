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
        if (this.hasRepliesTarget) {
            let [data, status, xhr] = event.detail
            if (this.repliesTarget.dataset.replies == 'true') {
                this.repliesTarget.firstElementChild.firstElementChild.insertAdjacentHTML('beforebegin', xhr.response)
            } else {
                this.repliesTarget.innerHTML += xhr.response
                this.repliesTarget.dataset.replies = 'true'
            }
        }
    }

    updateComment(event) {

    }

    deleteComment() {
        let post = this.element
        let postCommentForm = post.getElementsByClassName("post-comment-form")
        if (postCommentForm.length > 0) { 
            for (let i = 0; i < postCommentForm.length; i++){
                postCommentForm[i].remove()
            }
        }
    }
}
