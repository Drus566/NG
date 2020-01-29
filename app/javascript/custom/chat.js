console.log("AY")

document.addEventListener('turbolinks:load', function() {
    console.log("GGWP")
    let chat = document.querySelector('#chat')
    console.log(chat)
    if (chat.length > 0) {
        Rails.ajax({
            url: "/chat",
            type: "GET",
            data: "",   
            success: function(data) {
                console.log("data");
                chat.innerHTML = data;
            },
            error: function(data) {
                console.log(`error: ${data}`)
            }
        });

        // fetch('/chat', {
        //     method: 'get',
        //     headers: {
        //       'Content-Type': 'application/html',
        //       'X-CSRF-Token': Rails.csrfToken()
        //     },
        //     credentials: 'same-origin'
        //   }).then(function(response) {
        //     return response.json();
        //   }).then(function(data) {
        //     console.log(data);
        //   });
    }
})