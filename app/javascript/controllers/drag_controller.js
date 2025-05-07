// app/javascript/controllers/drag_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["block"]

  connect() {
    this.blockTargets.forEach(block => {
      block.addEventListener("dragstart", this.handleDragStart)
    })
  }

  handleDragStart(e) {
    const blockType = e.target.dataset.blockType
    e.dataTransfer.setData("text/plain", blockType)
  }
}