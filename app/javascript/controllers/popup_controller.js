import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ["popup"]

    clear(event) {
        if (event.target.id.toLowerCase() == 'user-form-wrapper' 
            || event.target.className.toLowerCase() == 'close-form') { 
            this.popupTarget.innerHTML = ""
            this.popupTarget.classList.remove('popup-active')
            document.body.classList.remove('overflow')
        } 
    }
}