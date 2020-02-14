import { Controller } from "stimulus"

export default class extends Controller {

    static targets = [ 'menu', 'id', 'btn' ]

    change(event) {
        if (event.target.dataset.open == 'true') {
            this.menuTarget.className = 'sections-dropdown'
            event.target.dataset.open = 'false'
        } else {
            this.menuTarget.classList.add('active-sections')
            event.target.dataset.open = 'true'
        }
    }

    setSection(event) {
        let sectionName = event.target.innerText
        let sectionId = event.target.dataset.sectionId

        if (this.hasBtnTarget) {
            this.btnTarget.innerText = sectionName
            this.btnTarget.className = `section-btn selected section-${sectionId}`
        }

        if (this.hasIdTarget) {
            this.idTarget.setAttribute('value', sectionId)
        }

        this.menuTarget.className = 'sections-dropdown'
        this.btnTarget.dataset.open = 'false'
    }

    removeSection(event) {
        if (this.hasBtnTarget) {
            this.btnTarget.innerText = 'Раздел'
            this.btnTarget.className = 'section-btn'
        }

        if (this.hasIdTarget) {
            this.idTarget.removeAttribute('value')
        }

        this.menuTarget.className = 'sections-dropdown'
        this.btnTarget.dataset.open = 'false'
    }
}