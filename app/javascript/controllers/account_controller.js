import { Controller } from "stimulus"

export default class extends Controller {

    static targets = ["dropdown"]
    
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
}