import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu"
export default class extends Controller {
  toggle(){
       let burger = document.querySelector('#burger');
       let list = document.querySelector('#list');
       console.log('wpppp')
  }
}
