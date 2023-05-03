// set the modal menu element
const targetEl = document.getElementById('popup-modal');

// options with default values
const options = {
  placement: 'center',
  backdrop: 'dynamic',
  backdropClasses: 'bg-gray-900 bg-opacity-50 dark:bg-opacity-80 fixed inset-0 z-40',
  closable: true,
  onHide: () => {
    console.log('modal is hidden');
  },
  onShow: () => {
    console.log('modal is shown');
  },
  onToggle: () => {
    console.log('modal has been toggled');
  }
};

let modal = new Modal(targetEl, options);
let hideModal = () => { modal.hide() }

Turbo.setConfirmMethod((message) => {


  //let cancelButtons = targetEl.querySelectorAll("button[value='cancel']")
  let confirmButton = targetEl.querySelector("button[value='confirm']")

  // cancelButtons.forEach((e) => e.removeEventListener("click", hideModal, true ) )
  // confirmButton.removeEventListener("click", hideModal, true )
  // cancelButtons.forEach((e) => e.addEventListener("click", hideModal ) )
  // confirmButton.addEventListener("click", hideModal )

  targetEl.querySelector("h3").textContent = message
  confirmButton.textContent = "Delete file"

  modal.show()
  return new Promise((resolve) => {
    confirmButton.addEventListener("click", () => {
      resolve(true)
    }, { once: true})
  })
})

// Turbo.setConfirmMethod((message, element) => {
//   let dialog = document.getElementById("confirm-popup-modal")
//   function onClick(event) {
//     if (event.target === dialog) {
//       dialog.close();
//     }
//   }
//   dialog.addEventListener("click", onClick);
//   dialog.querySelector("h3").textContent = message
//   dialog.showModal()
//   console.log("dialog open")
//
//   return new Promise((resolve, reject) => {
//     dialog.addEventListener("close", () => {
//       resolve(dialog.returnValue == "confirm")
//     }, { once: true})
//   })
// })
