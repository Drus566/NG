import { Controller } from "stimulus"

export default class extends Controller {

    static targets = ['preview', 'view']

    view() {
        this.element.classList.add('view-catalog-item')
        this.viewTarget.classList.remove('catalog-info-block')
        this.previewTarget.classList.add('preview-catalog-item-block')
    }

    close() {
        this.element.classList.remove('view-catalog-item')
        this.viewTarget.classList.add('catalog-info-block')
        this.previewTarget.classList.remove('preview-catalog-item-block')
    }

}