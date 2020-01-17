import { Controller } from "stimulus"

export default class extends Controller {

    static targets = [ "formInfo" ]

    replyCommentForm(event) {
        let comment = this.element
        if (this.formInfoTarget.element.get.data("info") == 'closed') {
            this.formInfoTarget.element.set.data("info", "open")
            let [data, status, xhr] = event.detail
            comment.innerHTML += xhr.response
        }
    }

    editCommentForm(event) {
        let comment = this.element
        let replyCommentForm = comment.getElementsByClassName("comment-reply-form")
        let editCommentForm = comment.getElementsByClassName("comment-edit-form")
        if ((editCommentForm.length <= 0) && (replyCommentForm.length <= 0)) {
            let [data, status, xhr] = event.detail
            comment.innerHTML += xhr.response
        }   
    }

    deleteCommentForm() {
        let comment = this.element
        let replyCommentForm = comment.getElementsByClassName("comment-reply-form")
        let editCommentForm = comment.getElementsByClassName("comment-edit-form")
        if ((editCommentForm.length > 0) || (replyCommentForm.length > 0)) {
            for (let i = 0; i < replyCommentForm.length; i++){
                replyCommentForm[i].remove()
            }
            for (let i = 0; i < editCommentForm.length; i++){
                editCommentForm[i].remove()
            }
        } 
        // let post = this.element
        // let postCommentForm = post.getElementsByClassName("comment-reply-form")
        // if (postCommentForm.length > 0) { 
        //     for (let i = 0; i < postCommentForm.length; i++){
        //         postCommentForm[i].remove()
        //     }
        // }
    }
    
    createComment() {

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
