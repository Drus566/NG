import { Controller } from "stimulus"
import { DirectUpload } from "@rails/activestorage"

export default class extends Controller {

    static targets = ['template', 'select']

    //onChange
    selectFile(event) {
        let files = event.target.files
        this.handleFiles(files)
    }

    handleFiles(files) {
        ([...files]).forEach(function(file) {
            this.validateFile(file)
        }, this)
    }
    
    validateFile(file) {
        if (file && file.type.startsWith('image/') && file.size <= this.maxFileSize) {
            this.templateTarget.setAttribute('src', URL.createObjectURL(file))
        } else {
            this.addError('Недопустимый загружаемый файл')
        }
    }

    uploadFiles(files) {
        this.selectTarget.files = files
    }

    enterDrag(event) {
        event.stopPropagation();
        event.preventDefault();
    }

    overDrag(event) {
        event.stopPropagation();
        event.preventDefault();
    }

    fileDrop(event) {
        event.stopPropagation();
        event.preventDefault();
        
        if (typeof(window.FileReader) == 'undefined') {
            this.addError('Не поддерживается браузером')
            return false
        }

        let data = event.dataTransfer
        let files = data.files      

        this.handleFiles(files)
        this.uploadFiles(files)
    }

    // removeAvatar() {
    //     event.stopPropagation();
    //     event.preventDefault();

    //     this.templateTarget.setAttribute('src', '')
    //     this.selectTarget.setAttribute('value', '')
        
    //     let fileBuffer = this.createFileList(this.selectTarget.files)
    //     console.log(fileBuffer)
    //     fileBuffer.shift(0, 1)
    //     console.log(fileBuffer)
    //     this.selectTarget.files = fileBuffer
    //     console.log(this.selectTarget.files)
    // }

    removeAllFiles() {
        event.stopPropagation();
        event.preventDefault();

        this.templateTarget.setAttribute('src', '')
        this.selectTarget.setAttribute('value', '')

        let dataTransfer =  new DataTransfer()
        this.selectTarget.files = dataTransfer.files
    }

    // createFileList(files) {
    //     let fileBuffer = []
    //     Array.prototype.push.apply(fileBuffer, files)
    //     return fileBuffer
    // }

    addError(message) {
        document.dispatchEvent(new CustomEvent('notify', { detail: `<div class="error">${message}</div>` }))
    }

    get maxFileSize() {
        return 10485760 // 10 mB
    }
}