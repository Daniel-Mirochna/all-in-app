import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modals"
export default class extends Controller {
  static targets = ["confirm", "cancel", "closeModal"]
  
  get confirm() {
    return this.confirmTarget
  }
  get cancel() {
    return this.cancelTarget
  }
  get closeModal() {
    return this.closeModalTarget
  }
  
  connect() {
    console.log("Hello, Modals Controller!")
    
    // set the modal menu element
    const targetEl = document.getElementById('popup-modal')

    // options with default values
    const options = {
      placement: 'center',
      backdrop: 'dynamic',
      backdropClasses: 'bg-gray-900 bg-opacity-50 dark:bg-opacity-80 fixed inset-0 z-40',
      closable: true
    }

    const modal = new Modal(targetEl, options)
    this.confirmTarget.addEventListener("click", () => {modal.hide()} )
    this.cancelTarget.addEventListener("click", () => {modal.hide()} )
    this.closeModalTarget.addEventListener("click", () => {modal.hide()} )
    
    Turbo.setConfirmMethod((message, element) => {
      targetEl.querySelector("h3").textContent = message
      let elementId = `fileGridElement_${element.action.split('/').slice(-1)}`
      this.confirm.textContent = "Delete file"

      modal.show()
      return new Promise((resolve) => {
        this.confirm.addEventListener("click", () => {
          document.getElementById(elementId).innerHTML = "<div class='flex justify-center items-center h-full'><div class=\'lds-roller\'><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div></div></div>"
          resolve(true)
        }, { once: true})
      })
    })
  }
}
