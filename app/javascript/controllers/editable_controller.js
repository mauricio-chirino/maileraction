// app/javascript/controllers/editable_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Guardar automáticamente cuando el usuario edite el texto
    this.element.addEventListener("input", this.saveCanvas.bind(this))
  }

  saveCanvas() {
    const canvasController = this.application.getControllerForElementAndIdentifier(
      document.querySelector('[data-controller~="canvas"]'),
      "canvas"
    )
    if (canvasController) {
      canvasController.save()
    }
  }
}
