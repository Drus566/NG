import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
    
    static targets = ['content', 'text']

    connect() {
        
    }

    processEnter() {

    }

    clearText() {

    }
}