// app/javascript/controllers/drop_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  removeBlock(event) {
    event.target.closest('.email-block').remove()
    
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
