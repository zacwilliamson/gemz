document.addEventListener("turbo:load", function() {
    let reply_btn = document.querySelectorAll('.reply-btn');
    // let forms = document.querySelectorAll('.reply-form');

    reply_btn.forEach((btn) => {
        btn.addEventListener('click', function(){
            if(btn.name == 'arrow-undo'){
                reply_btn.forEach((other_btn) => {
                other_btn.nextElementSibling.classList.add('hidden')
                other_btn.name = 'arrow-undo'
                })

                btn.name = 'close-circle'
                btn.nextElementSibling.classList.remove('hidden')
            } else {
                btn.name = 'arrow-undo'
                btn.nextElementSibling.classList.add('hidden')
            }
        })
    })
});