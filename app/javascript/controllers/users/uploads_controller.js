import { Controller } from "@hotwired/stimulus"

const MAX_FILE_SIZE_MB = 5 // Maximum file size in MB
const MAX_FILE_COUNT = 10 // Maximum number of files

// Controller handling drag and drop files form
export default class extends Controller {
  static targets = ["form", "filesInput", "dragDropArea", "hiddenField", "filesList"]

  connect() {
    console.log("Hello, Uploads Controller!")
  }

  get form() {
    return this.formTarget
  }
  get filesInput() {
    return this.filesInputTarget
  }
  get dragDropArea() {
    return this.dragDropAreaTarget
  }
  get filesList() {
    return this.filesListTarget
  }


  // Handling click on the drag-and-drop area
  dragDropAreaClick() {
    this.filesInput.click()
  };

  //  Handling file drag on the area
  dragDropAreaDragOver(e) {
    e.preventDefault()
    this.dragDropArea.classList.add('bg-sky-400/10')
  }

  dragDropAreaDragLeave(e) {
    e.preventDefault()
    this.dragDropArea.classList.remove('bg-sky-400/10')
  }

  dragDropAreaDrop(e) {
    e.preventDefault()
    this.dragDropArea.classList.remove('bg-sky-400/10')
    const files = e.dataTransfer.files
    // Checking file size and number of files limitations
    if (files.length > MAX_FILE_COUNT) {
      alert(`You can attach up to ${MAX_FILE_COUNT} files.`)
      return
    }
    for (let i = 0; i < files.length; i++) {
      const file = files[i]
      if (file.size > MAX_FILE_SIZE_MB * 1024 * 1024) {
        alert(`File size of "${file.name}" exceeds the limit of ${MAX_FILE_SIZE_MB} MB.`)
        return
      }
    }
    this.filesInput.files = files
    this.filesInputOnChange()
  }
  
  filesInputOnChange() {
    this.filesList.textContent = `Files to be uploaded: ${this.filesInput.files.length}`
  }

  // Check if files input is not empty
  beforeUpload(e) {
    if (this.filesInput.files.length <= 0) {
      e.preventDefault()
      alert(`Please attach minimum one file.`)
      return
    }
  }
}