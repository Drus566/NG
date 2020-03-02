import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ['newBtn', 'newForm']

    show(event) {
        let [data, status, xhr] = event.detail
        this.element.innerHTML += xhr.response
        this.newBtnTarget.classList.add('display-none')
        console.log('show')
    }

    create() {
        console.log('create')
    }

    addError() {
        console.log('error')
    }

    close() {
        console.log('close')
        this.newBtnTarget.className="new-catalog-item-btn"
        this.newFormTarget.remove()
    }
}