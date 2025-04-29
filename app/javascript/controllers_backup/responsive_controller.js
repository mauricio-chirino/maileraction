import { Controller } from "@hotwired/stimulus"

// Este controlador maneja mostrar/ocultar elementos según el tamaño de pantalla
export default class extends Controller {
  static targets = ["toggleButton"]

  connect() {
    this.updateButtonVisibility()
    window.addEventListener("resize", this.updateButtonVisibility.bind(this))
  }

  disconnect() {
    window.removeEventListener("resize", this.updateButtonVisibility.bind(this))
  }

  updateButtonVisibility() {
    const isMobile = window.innerWidth < 768 // Aquí defines qué es "pantalla pequeña"
    if (isMobile) {
      this.toggleButtonTarget.classList.remove("d-none")
    } else {
      this.toggleButtonTarget.classList.add("d-none")
    }
  }
}