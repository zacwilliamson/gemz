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

  close(){
    let replyForm = this.element.parentElement.parentElement.parentElement.parentElement
    let textArea = this.element.parentElement.previousElementSibling
    let reply_btn = document.querySelectorAll('.reply-btn');
    console.log(textArea.value.length)
     
    if(replyForm.classList.contains('reply-form') && textArea.value.trim().length > 0 && textArea.value.length <= 250){
      replyForm.classList.add('hidden')
      reply_btn.forEach((btn) => {
        btn.name = 'arrow-undo'
      })
    }
  }
}

// || textArea.value.length <= 250