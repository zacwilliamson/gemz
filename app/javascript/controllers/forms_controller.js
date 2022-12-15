import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="forms"
export default class extends Controller {
  connect() {
    this.element.addEventListener("submit", clear)
  }

  clear(){
    this.element.reset()
  }
}
