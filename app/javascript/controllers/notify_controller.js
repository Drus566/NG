import { Controller } from "stimulus"

export default class extends Controller {

    static targets = ["notify"]

    addNotify(event) {
        console.log(event.detail)
        console.log('addNotify')
    }
}