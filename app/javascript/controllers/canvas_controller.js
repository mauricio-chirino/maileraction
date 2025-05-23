// app/javascript/controllers/canvas_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["area"]

  connect() {
    this.draggedBlock = null
  }

  dragStart(event) {
    this.draggedBlock = event.currentTarget
  }

  dragOver(event) {
    event.preventDefault()
    const overBlock = event.target.closest(".email-block")
    if (overBlock && overBlock !== this.draggedBlock) {
      overBlock.classList.add("drag-over")
    }
  }

  drop(event) {
    event.preventDefault()
    const dropBlock = event.target.closest(".email-block")
    if (dropBlock && dropBlock !== this.draggedBlock) {
      this.areaTarget.insertBefore(this.draggedBlock, dropBlock)
      this.save()
    }
    this.cleanDragClasses()
  }

  dragEnd(event) {
    if (this.draggedBlock) {
      this.draggedBlock.classList.remove("dragging")
      this.draggedBlock = null
    }
    this.cleanDragClasses()
  }

  cleanDragClasses() {
    document.querySelectorAll(".email-block.drag-over").forEach(el => {
      el.classList.remove("drag-over")
    })
  }

  save() {
    // Serializa los bloques
    const blocks = Array.from(this.element.querySelectorAll(".email-block"))
    const data = blocks.map(b => ({
      id: b.dataset.blockId,
      type: b.dataset.blockType,
      html: b.innerHTML
    }))
    localStorage.setItem('current_campaign', JSON.stringify(data))
  }
}
