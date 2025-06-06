import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  connect() {
    // Reinicializa solo si Bootstrap está disponible
    if (typeof bootstrap !== "undefined" && bootstrap.Dropdown) {
      this.initializeDropdowns()
    }
  }

  initializeDropdowns() {
    const dropdowns = this.element.querySelectorAll('[data-bs-toggle="dropdown"]')
    dropdowns.forEach((el) => {
      if (el._dropdownInstance) {
        el._dropdownInstance.dispose()
      }
      el._dropdownInstance = new bootstrap.Dropdown(el)
    })
  }
}