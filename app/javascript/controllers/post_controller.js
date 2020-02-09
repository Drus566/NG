import { Controller } from "stimulus"

export default class extends Controller {
    
    static targets = ["comments", "form", "like"]

    createCommentForm(event) {
        if (this.hasFormTarget) {
            let [data, status, xhr] = event.detail

            if (xhr.response.trimLeft().toLowerCase().startsWith('<div class="post-comment-form"')) {
                if(this.formTarget.dataset.form == 'closed') {
                    this.formTarget.dataset.form = "open"
                    this.formTarget.innerHTML += xhr.response
                }
            }
        }
    }

    deleteCommentForm() {
        if (this.hasFormTarget) {
            if (this.formTarget.dataset.form == 'open') {
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
                let spacer = document.createElement('div')
                spacer.classList.add('comment-spacer')
                this.commentsTarget.firstElementChild.prepend(spacer)
                this.commentsTarget.firstElementChild.firstElementChild.insertAdjacentHTML('beforebegin', xhr.response)
            } else {
                let comments = document.createElement('div')
                comments.classList.add('comments-wrapper')
                comments.innerHTML = xhr.response
                this.commentsTarget.prepend(comments)
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

    deleteReply(event) {
        let commentId = event.target.getAttribute('href').split('/')[4]
        let comment = this.commentsTarget.querySelector(`#comment-${commentId}`)
        
        if (comment && comment.parentElement.parentElement.dataset.replies == 'true') {            
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

    updateLike(event) {
        let [data, status, xhr] = event.detail

        if (xhr.response.toLowerCase().startsWith('<div class="likes-wrapper"')) {
            let resp = new DOMParser().parseFromString(xhr.response, "text/html")
            this.likeTarget.innerHTML = resp.firstElementChild.innerHTML
        }
    }
}
