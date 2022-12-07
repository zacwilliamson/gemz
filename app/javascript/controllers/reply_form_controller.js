import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reply-form"
export default class extends Controller {
  // connect() {
  //   console.log('hello!', this.element)
  // }

  toggle(){
    let reply_btn = document.querySelectorAll('.reply-btn');
    
    if(this.element.name == 'arrow-undo'){
        this.element.name = 'close-circle'
    } else {
      this.element.name = 'arrow-undo'
    }

    // reply_btn.forEach((btn) => {
    //     btn.addEventListener('click', function(){
    //         if(btn.name == 'arrow-undo'){
    //             reply_btn.forEach((other_btn) => {
    //             other_btn.parentElement.parentElement.nextElementSibling.classList.add('hidden')
    //             other_btn.name = 'arrow-undo'
    //             })

    //             btn.name = 'close-circle'
    //             btn.parentElement.parentElement.nextElementSibling.classList.remove('hidden')
    //             console.log(btn.parentElement)
    //         } else {
    //             btn.name = 'arrow-undo'
    //             btn.parentElement.parentElement.nextElementSibling.classList.add('hidden')
    //         }
    //     })
    // })
  }
}
