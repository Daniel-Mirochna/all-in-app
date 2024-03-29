import { Controller } from "@hotwired/stimulus"

window.pageTimer = 0;
// Connects to data-controller="cryptocurrencies"
export default class extends Controller {
  static targets = [ "pageNumber" ]

  initialize() {
    this.currentPage = 1
    this.timeout = null
  }

  connect() {
    console.log("Hello, Cryptocurrencies controller!")
  }

  disconnect() {
    clearTimeout(this.timeout)
  }

  // sorting mechanism from https://stackoverflow.com/a/49041392
  getCellValue = (tr, idx) =>
    tr.children[idx].getAttribute("data-value") || tr.children[idx].innerText || tr.children[idx].textContent

  tableComparer = (idx, asc) => (a, b) => ((v1, v2) =>
    v1 !== '' && v2 !== '' && !isNaN(v1) && !isNaN(v2) ? v1 - v2 : v1.toString().localeCompare(v2)
    )(this.getCellValue(asc ? a : b, idx), this.getCellValue(asc ? b : a, idx))

  clearOrderClasses(thElement) {
    document.querySelectorAll(".order-asc").forEach(e => e.classList.remove("order-asc"))
    document.querySelectorAll(".order-desc").forEach(e => e.classList.remove("order-desc"))

    const orderClass = this.asc ? "order-asc" : "order-desc"
    thElement.classList.add(orderClass)
  }

  sortTable(e) {
    const thElement = e.target
    const tbody = thElement.closest('table').querySelector("tbody")

    Array.from(tbody.querySelectorAll('tr:nth-child(n+1)'))
      .sort(this.tableComparer(Array.from(thElement.parentNode.children).indexOf(thElement), this.asc = !this.asc))
      .forEach(tr => tbody.appendChild(tr))

    this.clearOrderClasses(thElement)
  }

  setCookieAndReloadData(e) {
    const selectedCurrency = e.target.value
    const currentCurrencyCookie = this.getCookie("currency")
    if (selectedCurrency !== currentCurrencyCookie) {
      this.setCookie("currency", selectedCurrency)
      document.getElementById("coins_list").src = document.getElementById("coins_list").src
    }
  }

  getCookie(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) return parts.pop().split(";").shift();
  }

  setCookie(name, value) {
    let expirationDate = new Date();
    expirationDate.setDate(expirationDate.getDate() + 180);
    let cookieString = name + "=" + encodeURIComponent(value) + "; expires=" + expirationDate.toUTCString() + "; path=/";
    document.cookie = cookieString;
  }

  nextPage() {
    if (this.currentPage < 38) {
      clearTimeout(this.timeout)
      this.currentPage += 1
      this.pageNumberTarget.textContent = this.currentPage
      this.timeout = setTimeout(() => {
        this.reloadCoinsList(this.currentPage)
      }, 750)
    } else {
      alert("You've reached data end.")
    }
  }

  prevPage() {
    if (this.currentPage > 1) {
      clearTimeout(this.timeout)
      this.currentPage -= 1
      this.pageNumberTarget.textContent = this.currentPage
      this.timeout = setTimeout(() => {
        this.reloadCoinsList(this.currentPage)
      }, 750)
    }
  }

  reloadCoinsList(page) {
    let coinsListFrame = document.getElementById("coins_list")
    let url = new URL(coinsListFrame.src)
    url.searchParams.set("page", page)

    coinsListFrame.src = url.toString()
    if (coinsListFrame.getElementsByTagName("tbody") !== undefined) {
      coinsListFrame.getElementsByTagName("tbody")[0].innerHTML = `<tr role="status" class="">
      <td colspan="7">
      <svg aria-hidden="true" class="w-8 h-8 m-auto my-5 text-gray-200 animate-spin dark:text-gray-600 fill-blue-600" viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z" fill="currentColor"/><path d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z" fill="currentFill"/></svg>
      <span class="sr-only">Loading...</span>
      </td>
      </tr>`
    }
  }
}
