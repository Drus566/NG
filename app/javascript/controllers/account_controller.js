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

    close(event) {
        let [data, status, xhr] = event.detail

        if (this.hasDropdownTarget) {
            this.dropdownTarget.classList.remove('account-active')
            this.dataOpenTarget.dataset.open = 'false'
        }

        let popupEvent = new CustomEvent('popup', { 'detail': xhr.response })
        document.dispatchEvent(popupEvent)
    }
}