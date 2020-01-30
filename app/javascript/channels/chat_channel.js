import consumer from "./consumer"

document.addEventListener('turbolinks:load', function() {
    console.log('i upload')
    const chat = document.querySelectorAll('#chat')
    if (chat.length > 0) {
        consumer.subscriptions.create("ChatChannel", {

            connected() {
                console.log('connect')
            },

            disconnected() {

            },

            received(data) {
                let chatMessages = chat[0].querySelector('.chat-messages')
                chatMessages.insertAdjacentHTML('beforeEnd', data)
            },

            // speak: function(message) {
            //     console.log('i speaked')
            //     return this.perform('speak', message);
            // }
        });
    }
})

