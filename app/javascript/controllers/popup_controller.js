import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ["popup", "errors"]

    clear(event) {
        if (event.target.id.toLowerCase() == 'user-form-wrapper' 
            || event.target.className.toLowerCase() == 'close-form') { 
            this.popupTarget.innerHTML = ""
            this.popupTarget.classList.remove('popup-active')
            document.body.classList.remove('overflow')
        } 
    }

    addError(event) {
        let [data, status, xhr] = event.detail

        if (this.hasErrorsTarget) {
            if (xhr.response.toLowerCase().startsWith('<div class="errors">')) {
                this.errorsTarget.innerHTML = xhr.response
            }
        }
    }

    addPopup(event) {
        if (this.hasPopupTarget) {
            document.body.classList.add('overflow')
            this.popupTarget.classList.add('popup-active')
            this.popupTarget.innerHTML = event.detail    
        }
    }
}