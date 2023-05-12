import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cryptocurrencies"
export default class extends Controller {
  static target = [ "select" ]

  connect() {
    console.log("Hello, Cryptocurrencies controller!")
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
}
