import { Controller } from "stimulus"

export default class extends Controller {

    static targets = [ 'menu', 'active' ]

    change(event) {
        if (event.target.dataset.open == 'true') {
            this.menuTarget.className = 'tags-dropdown'
            event.target.dataset.open = 'false'
        } else {
            this.menuTarget.classList.add('active-menu-tags')
            event.target.dataset.open = 'true'
        }
    }

    add(event) {
        let element = event.target
        this.activeTarget.append(element)
    }
}