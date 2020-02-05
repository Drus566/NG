import { Controller } from "stimulus"

export default class extends Controller {

    static targets = ["dropdown", "dataOpen"]
    
    change(event) {
        if (event.target.dataset.open == 'false') {
            event.target.dataset.open = 'true'
            if (this.hasDropdownTarget) {
                this.dropdownTarget.classList.add('account-active')
            }
        } else {
            event.target.dataset.open = 'false'
            this.dropdownTarget.className = 'account-dropdown'
        }
    }

    addContent(event) {
        let [data, status, xhr] = event.detail
        let popup = document.querySelector('.popup')

        if (this.hasDropdownTarget) {
            this.dropdownTarget.classList.remove('account-active')
            this.dataOpenTarget.dataset.open = 'false'
        }

        if (popup) {
            document.body.classList.add('overflow')
            popup.classList.add('popup-active')
            popup.innerHTML = xhr.response
        }
    }
}