import { Controller } from "stimulus"

export default class extends Controller {

    // static targets = [ "commentForm" ]

    createCommentForm(event) {
        let post = this.element
        let postCommentForm = post.getElementsByClassName("post-comment-form")
        if (postCommentForm.length <= 0) {
            let [data, status, xhr] = event.detail
            post.innerHTML += xhr.response
        } 
    }

    deleteCommentForm() {
        let post = this.element
        let postCommentForm = post.getElementsByClassName("post-comment-form")
        // this.commentFormTarget.element.remove
        if (postCommentForm.length > 0) { 
            for (let i = 0; i < postCommentForm.length; i++){
                postCommentForm[i].remove()
            }
        }
    }
}
