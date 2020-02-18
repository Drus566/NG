import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ['newBtn']

    show(event) {
        this.event.target.classList.add('display-none')
        let [data, status, xhr] = event.detail
        
        this.catalogWrapper.insertAdjacentElement('afterbegin', xhr.response)
    }

    create() {
        
    }

    addError() {
        console.log('error')
    }

    get catalogWrapper() {
        return document.querySelector('#catalog-items-wrapper')
    }
}