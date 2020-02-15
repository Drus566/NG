import { Controller } from "stimulus"

export default class extends Controller {

    static targets = ['template']

    processFile(event) {
        let file = event.target.files[0]

        if (file && file.type.startsWith('image/')) {
            this.templateTarget.setAttribute('src', URL.createObjectURL(file))
        }
    }
}