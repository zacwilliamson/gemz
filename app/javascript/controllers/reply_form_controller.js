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

  // attempted to create alert/notices on submission, needs to be cleaned up
  close(){
    let replyForm = this.element.parentElement.parentElement.parentElement.parentElement
    let textArea = this.element.parentElement.previousElementSibling
    let reply_btn = document.querySelectorAll('.reply-btn');
    let alert = document.querySelector('#reply-alert')
    let notice = document.querySelector('#reply-notice')

    if(textArea.value.trim().length == 0){
      alert.classList.remove('hidden')
      alert.textContent = 'Content can not be empty'
      setTimeout(() => {
        alert.classList.add('hidden');
      }, 2500);
    } else if(textArea.value.length > 250){
      alert.classList.remove('hidden')
      alert.textContent = 'Exceeds 250 characters'
      setTimeout(() => {
        alert.classList.add('hidden');
      }, 2500);
    } else {
      if(replyForm.classList.contains('reply-form')){
        replyForm.classList.add('hidden')
        reply_btn.forEach((btn) => {
          btn.name = 'arrow-undo'
        })
      }

      notice.classList.remove('hidden')
      notice.textContent = 'Your post is live'
      setTimeout(() => {
        notice.classList.add('hidden');
      }, 2500);
    }
  }
}
