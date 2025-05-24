// controllers/sidebar_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  createBlockPreview(event) {
    // Guarda el tipo de bloque siendo arrastrado en el dataTransfer
    const blockType = event.currentTarget.dataset.blockType;
    event.dataTransfer.setData("blockType", blockType);

    // Opcional: pasa HTML como dataTransfer (para pegarlo directo)
    event.dataTransfer.setData("text/html", event.currentTarget.innerHTML);
  }
}