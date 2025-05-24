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
    // Visual feedback solo si reordenando (draggedBlock existe)
    const overBlock = event.target.closest(".email-block")
    if (overBlock && overBlock !== this.draggedBlock) {
      overBlock.classList.add("drag-over")
    }
  }

drop(event) {
    event.preventDefault()
    // --- ¿VIENE DE SIDEBAR O ES REORDEN? ---
    const blockType = event.dataTransfer.getData("blockType")
    const blockHtml = event.dataTransfer.getData("text/html")
    const dropBlock = event.target.closest(".email-block")

    if (blockType && blockHtml) {
      // --- VIENE DEL SIDEBAR, CREA BLOQUE NUEVO ---
      // Puedes envolver blockHtml con clases y data-* si lo necesitas
      const id = `block-${Date.now()}`
      const html = `
        <div class="email-block position-relative mb-3"
             data-controller="block"
             data-block-type="${blockType}"
             data-block-id="${id}"
             draggable="true"
             data-action="click->block#select dragstart->canvas#dragStart dragover->canvas#dragOver drop->canvas#drop dragend->canvas#dragEnd"
        >
          ${blockHtml}
        </div>
      `
      if (dropBlock) {
        dropBlock.insertAdjacentHTML("beforebegin", html)
      } else {
        // Si no hay bloque debajo, agrega al final del canvas
        this.areaTarget.insertAdjacentHTML("beforeend", html)
      }
      this.save()
    } else if (this.draggedBlock && dropBlock && dropBlock !== this.draggedBlock) {
      // --- SOLO REORDENANDO ---
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
