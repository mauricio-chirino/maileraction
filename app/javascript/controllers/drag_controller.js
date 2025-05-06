// app/javascript/controllers/drag_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["block"]

  connect() {
    this.blockTargets.forEach(block => {
      block.addEventListener("dragstart", this.startDrag)
    })
  }

  startDrag(event) {
    const blockType = event.target.dataset.blockType
    event.dataTransfer.setData("text/plain", blockType)
  }
}
