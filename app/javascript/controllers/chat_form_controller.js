import { Controller } from "stimulus"

const CODES = {
    ":smiley:": "😀",
    ":stuck_out_tongue_winking_eye:": "😜",
    ":bowtie:": "🤵",
}

const PATTERN = new RegExp(Object.keys(CODES).join("|"))

export default class extends Controller {
    
    static targets = ["editor", "countSymbols", "smilesDropdown"]

    convert() {
        this.text.replace(PATTERN, (code, offset) => {
            this.editor.setSelectedRange([offset, offset + code.length])
            this.editor.insertString(CODES[code])
        })
    }

    showCountSymbols() {
        this.countSymbolsTarget.innerText = `${this.countSymbols}/200`
    }

    inputKeyword(event) {
        if ((event.keyCode === 13 || event.key == "Enter") && !event.shiftKey) {
            (this.countSymbols <= 200) ? this.sendForm() : this.showError(event, 'Слишком длинное сообщение')
        }    
    }

    sendForm() {
        document.querySelector('#chat-btn').click()
        this.clearText()
    }

    clearText() {
        this.editor.setSelectedRange([0,9999])
        this.editor.deleteInDirection("forward")
    }

    showError(event, error) {
        event.preventDefault()
        console.log(error)
    }

    dropSmiles() {
        if (this.data.get('dropdown-smiles') == 'close') {
            this.data.set('dropdown-smiles', 'open')
            this.smilesDropdownTarget.classList.add('chat-smiles-active')
        } else {
            this.data.set('dropdown-smiles', 'close')
            this.smilesDropdownTarget.classList.remove('chat-smiles-active')
        }
    }

    setSmile(event) {
        console.log('setsmile')
        let smileCode = event.target.dataset.code
        this.editor.insertString(smileCode)
        this.dropSmiles()
    }

    get countSymbols() {
        return this.text.length - 1
    }

    get editor() {
        return this.editorTarget.editor
    }

    get text() {
        return this.editor.getDocument().toString()
    }
}