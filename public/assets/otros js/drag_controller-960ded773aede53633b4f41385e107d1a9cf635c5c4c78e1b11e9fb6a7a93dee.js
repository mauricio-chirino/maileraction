// app/javascript/controllers/drag_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  addBlock(event) {
    // ... tu lógica para agregar el bloque al canvas ...
    
    // Llama a save()
    const canvasController = this.application.getControllerForElementAndIdentifier(
      document.querySelector('[data-controller~="canvas"]'),
      "canvas"
    )
    if (canvasController) {
      canvasController.save()
    }
  }
};
