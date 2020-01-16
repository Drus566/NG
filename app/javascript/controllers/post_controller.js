// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
    static targets = [ "postCreateForm" ]

    connect() {

    }

    createPostCommentForm(event) {
        // console.log(e.target.dataset.postCreateCommentForm);
        let [data, status, xhr] = event.detail
        let post = this.element
        let postCommentCreate = post.getElementsByClassName("post-comment-create")
        if (postCommentCreate.length <= 0) {
                
        } 
        if (postCreateFormTarget != null) {
            console.log("YAEps")
        }else{
            console.log("GGWP")
        }
    }

    ajaxLoad() {
        let token = document.getElementsByName('csrf-token')[0].content
    }
}
