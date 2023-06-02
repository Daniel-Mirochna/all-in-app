import { Controller } from "@hotwired/stimulus"

const MAX_FILE_SIZE_MB = 10 // Maximum file size in MB
const MAX_FILE_COUNT = 10 // Maximum number of files

// Controller handling drag and drop files form
export default class extends Controller {
  static targets = ["form", "fileInput", "dragDropArea", "fileCounter", "fileList"]
  currentInputFileList = new DataTransfer()

  connect() {
    console.log("Hello, Uploads Controller!")
  }

  get form() {
    return this.formTarget
  }
  get fileInput() {
    return this.fileInputTarget
  }
  get dragDropArea() {
    return this.dragDropAreaTarget
  }
  get fileCounter() {
    return this.fileCounterTarget
  }
  get fileList() {
    return this.fileListTarget
  }


  // Handles click on the drag-and-drop area
  dragDropAreaClick() {
    this.fileInput.click()
  };

  // Handles file drag over the area
  dragDropAreaDragOver(e) {
    e.preventDefault()
    this.dragDropArea.classList.add('bg-sky-400/10')
  }

  // Handles file drag out of the area
  dragDropAreaDragLeave(e) {
    e.preventDefault()
    this.dragDropArea.classList.remove('bg-sky-400/10')
  }

  // Handles file drop on the area
  dragDropAreaDrop(e) {
    e.preventDefault()
    this.dragDropArea.classList.remove('bg-sky-400/10')
    const newFiles = e.dataTransfer.files

    if (this.isFilesValid(newFiles)){
      Array.from(newFiles).forEach((file) => {
        this.currentInputFileList.items.add(file)
      });

      this.handleFileInputState()
    }
  }

  // Checks file size and number of files limitations
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

  fileInputOnChange() {
    this.handleFileInputState()
  }
  
  // Shows how many files will be uploaded and generate file list
  handleFileInputState() {
    Array.from(this.fileInput.files).forEach((file) => {
      this.currentInputFileList.items.add(file)
    });
    this.deleteDuplicates()
    this.fileInput.files = this.currentInputFileList.files

    this.fileCounter.textContent = `Files to be uploaded: ${this.fileInput.files.length}`
    this.fileList.innerHTML = ''

    Array.from(this.currentInputFileList.files).forEach((file, index) => {
      this.fileList.appendChild(this.createFileTile(file, index))
    })
  }

  // Deletes duplicated files from upload queue
  deleteDuplicates() {
    const duplicateFileNames = [];
    Array.from(this.currentInputFileList.files).forEach(function(file, index, self) {
      if (self.findIndex(function(f) {
        return f.name === file.name && f.size === file.size
      }) !== index) {
        duplicateFileNames.push(file.name)
      }
    })

    if (duplicateFileNames.length > 0) {
      alert('The following files have already been selected: \n' + duplicateFileNames.join('\n '))
    }
    
    const uniqueFileList = Array.from(this.currentInputFileList.files).filter(function(file, index, self) {
      return self.findIndex(function(f) {
        return f.name === file.name && f.size === file.size
      }) === index
    })

    this.currentInputFileList.items.clear()
    uniqueFileList.forEach( (file) => {
      this.currentInputFileList.items.add(file)
    })
  }

  // Creates single file tile tile that can be deleted on click
  createFileTile(file, index) {
    let fileNodeWrapper = document.createElement("button")
    fileNodeWrapper.classList.add("block", "px-1","hover:outline", "hover:outline-2", "hover:outline-red-600", "rounded-sm", "text-ellipsis", "overflow-hidden", "whitespace-nowrap", "break-keep", "max-w-xs")
    fileNodeWrapper.addEventListener('click', (e) => {e.preventDefault(); this.removeFileFromFileList(index)})

    let fileNodeName = document.createTextNode(file.name)
    fileNodeWrapper.innerHTML += `<svg aria-hidden="true" class="w-5 h-5 inline align-text-bottom" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
      <span class="sr-only">Close modal</span>`
    fileNodeWrapper.appendChild(fileNodeName)

    return fileNodeWrapper
  }

  // Removes single file of index
  removeFileFromFileList(index) {
    this.currentInputFileList.items.remove(index)
    this.handleFileInputState()
  }

  // Last validation just before upload
  beforeUpload(e) {
    if (!this.isFilesValid(this.fileInput.files)) {
      e.preventDefault()
      return false
    }
  }
}