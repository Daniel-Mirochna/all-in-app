import { Controller } from "@hotwired/stimulus"

const MAX_FILE_SIZE_MB = 10 // Maximum file size in MB
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

  // Handling file drag over the area
  dragDropAreaDragOver(e) {
    e.preventDefault()
    this.dragDropArea.classList.add('bg-sky-400/10')
  }

  // Handling file drag out of the area
  dragDropAreaDragLeave(e) {
    e.preventDefault()
    this.dragDropArea.classList.remove('bg-sky-400/10')
  }

  // Handling file drop on the area
  dragDropAreaDrop(e) {
    e.preventDefault()
    this.dragDropArea.classList.remove('bg-sky-400/10')
    const files = e.dataTransfer.files
    if (this.isFilesValid(files)){
      this.filesInput.files = files
      this.filesInputOnChange()
    }
  }

  // Checking file size and number of files limitations
  isFilesValid(files) {
    if (files.length <= 0) {
      alert(`Please attach minimum one file.`)
      return false
    }
    if (files.length > MAX_FILE_COUNT) {
      alert(`You can attach up to ${MAX_FILE_COUNT} files.`)
      return false
    }
    for (let i = 0; i < files.length; i++) {
      const file = files[i]
      if (file.size > MAX_FILE_SIZE_MB * 1024 * 1024) {
        alert(`File size of "${file.name}" exceeds the limit of ${MAX_FILE_SIZE_MB} MB.`)
        return false
      }
    }
    return true
  }

  // Show how many files will be uploaded
  filesInputOnChange() {
    this.filesList.textContent = `Files to be uploaded: ${this.filesInput.files.length}`
  }

  // Last validation just before upload
  beforeUpload(e) {
    if (!this.isFilesValid(this.filesInput.files)) {
      e.preventDefault()
      return false
    }
  }
}