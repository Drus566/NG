import { Controller } from "stimulus"

export default class extends Controller {
    
    connect() {
        this.element.addEventListener("trix-file-accept", function(event) {
            const maxFileSize = 10485760 // 10485760 // 10MB 5242880 // 5 MB
            const acceptedTypes = ['image/jpeg', 'image/png']
            const maxImg = 4
            const countImg = this.querySelectorAll('img').length

            if (!acceptedTypes.includes(event.file.type)){     
                console.log('Accept Types error')
                let customEvent = new CustomEvent('notify', { detail: '<div class="error">Недопустимый формат загружаемого файла</div>' })
                document.dispatchEvent(customEvent)
                event.preventDefault()
            }

            if (event.file.size > maxFileSize) {
                console.log('Image size error')
                let customEvent = new CustomEvent('notify', { detail: `<div class="error">Размер изображения не может быть более ${maxFileSize}</div>` })
                document.dispatchEvent(customEvent)
                event.preventDefault()
            } 

            if (countImg > maxImg) {
                console.log('Count image error')
                let customEvent = new CustomEvent('notify', { detail: `<div class="error">Количество загружаемых изображений не может быть более ${maxImg}</div>` })
                document.dispatchEvent(customEvent)
                event.preventDefault()
            }
        })
    }
}