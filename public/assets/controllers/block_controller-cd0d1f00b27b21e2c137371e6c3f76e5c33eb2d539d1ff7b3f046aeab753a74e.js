// app/javascript/controllers/block_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { id: String }

  connect() {
    // Bandera interna para drag
    this.allowDrag = false
    this.element.setAttribute('draggable', 'true')
  }

  enableDrag(event) {
    this.allowDrag = true
    // Para feedback visual en el handle
    event.currentTarget.classList.add('active-handle')
  }

  disableDrag(event) {
    this.allowDrag = false
    event.currentTarget.classList.remove('active-handle')
  }

  dragStart(event) {
    // SOLO permite drag si el arrastre viene del handle
    if (!this.allowDrag) {
      event.preventDefault()
      return false
    }
    // Feedback visual
    this.element.classList.add("dragging")
    event.dataTransfer.effectAllowed = "move"
    event.dataTransfer.setData("text/plain", this.element.dataset.blockId)
    this.allowDrag = false // Siempre reset
  }

  dragEnd(event) {
    this.element.classList.remove("dragging")
  }

  moveUp() {
    const prev = this.element.previousElementSibling
    if (prev) {
      prev.parentNode.insertBefore(this.element, prev)
      this.saveCanvas()
    }
  }

  moveDown() {
    const next = this.element.nextElementSibling
    if (next) {
      next.parentNode.insertBefore(next, this.element)
      this.saveCanvas()
    }
  }

  remove() {
    this.element.remove()
    this.saveCanvas()
  }

  duplicate() {
    const clone = this.element.cloneNode(true)
    this.element.parentNode.insertBefore(clone, this.element.nextSibling)
    this.saveCanvas()
  }

  startEdit() {
    const heading = this.element.querySelector('[contenteditable]')
    if (heading) heading.focus()
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

  select(event) {
    // Opcional: resalta el bloque seleccionado
    document.querySelectorAll(".email-block.selected").forEach(b => b.classList.remove("selected"));
    this.element.classList.add("selected");

    // Dispara el evento global
    const blockType = this.element.dataset.blockType;
    window.dispatchEvent(new CustomEvent("block:selected", { 
      detail: { 
        blockType: this.element.dataset.blockType,
        blockId: this.element.dataset.blockId
      } 
    }));

    // Opcional: scroll al inspector si quieres en móviles
  }


  editProperties(event) {
    const blockType = this.element.dataset.blockType;   // ej: nav_main
    const category = this.element.dataset.category || "navigation";
    const blockId = this.element.dataset.blockId;
    window.dispatchEvent(new CustomEvent("block:selected", {
      detail: { category, blockType, blockId }
    }));
  }




};
