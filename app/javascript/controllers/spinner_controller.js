// app/javascript/controllers/spinner_controller.js
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["spinner"]

  connect() {
    this.spinnerTarget.style.display = "none"; // Asegura que el spinner esté oculto al cargar
  }

  showSpinner(event) {
    // Previene el envío del formulario de inmediato
    event.preventDefault()

    // Muestra el spinner
    this.spinnerTarget.style.display = "flex"

    // Enviar el formulario después de unos segundos (simula carga)
    setTimeout(() => {
      event.target.submit()  // Enviar el formulario
    }, 1000) // Ajusta el retraso si es necesario
  }
}