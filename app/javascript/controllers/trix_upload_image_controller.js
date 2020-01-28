import { Controller } from "stimulus"

export default class extends Controller {
    
    connect() {
        this.element.addEventListener("trix-file-accept", function(event) {
            const maxFileSize = 1242880 // 10485760 // 10MB 5242880 // 5 MB
            const acceptedTypes = ['image/jpeg', 'image/png']
            const maxImg = 4
            const countImg = this.querySelectorAll('img').length

            if (!acceptedTypes.includes(event.file.type)){
                console.log('Accept Types error')
                event.preventDefault()
            }

            if (event.file.size > maxFileSize) {
                console.log('Image size error')
                event.preventDefault()
            } 

            if (countImg >= maxImg) {
                console.log('Count image error')
                event.preventDefault()
            }
        })
    }
}