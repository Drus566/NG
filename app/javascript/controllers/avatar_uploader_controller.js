import { Controller } from "stimulus"

export default class extends Controller {

    static targets = ['template', 'select']

    processFile(event) {
        console.log(event)
        console.log('processFile')
        let file = event.target.files[0]
        this.validationFile(file)
    }

    validationFile(file) {
        if (file && file.type.startsWith('image/')) {
            this.templateTarget.setAttribute('src', URL.createObjectURL(file))
        }
    }

    enterDrag(event) {
        event.stopPropagation();
        event.preventDefault();
        console.log('dragenter')
    }

    overDrag(event) {
        event.stopPropagation();
        event.preventDefault();
        console.log('dragover')
    }

    fileDrop(event) {
        event.stopPropagation();
        event.preventDefault();
        console.log('drop')
      
        let data = event.dataTransfer      
        this.validationFile(data.files[0])
    }

    removeAvatar() {
        event.stopPropagation();
        event.preventDefault();
        this.templateTarget.setAttribute('src', '')
        this.selectTarget.setAttribute('value', '')
        console.log(this.selectTarget.files)
        this.selectTarget.dispatchEvent(new Event('change'))
    }
}