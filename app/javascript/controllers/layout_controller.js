import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if (typeof Layout !== "undefined" && Layout.init) {
      Layout.init(); // <-- reinicia el comportamiento del layout Sneat
    }
  }
}