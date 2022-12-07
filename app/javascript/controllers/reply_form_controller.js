import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reply-form"
export default class extends Controller {
  toggle(){
    let reply_btn = document.querySelectorAll('.reply-btn');
    
    if(this.element.name == 'arrow-undo'){
        reply_btn.forEach((btn) => {
          btn.parentElement.parentElement.nextElementSibling.classList.add('hidden')
          btn.name = 'arrow-undo'
        })
        this.element.name = 'close-circle'
        this.element.parentElement.parentElement.nextElementSibling.classList.remove('hidden')
    } else {
      this.element.name = 'arrow-undo'
      this.element.parentElement.parentElement.nextElementSibling.classList.add('hidden')
    }
  }
}
