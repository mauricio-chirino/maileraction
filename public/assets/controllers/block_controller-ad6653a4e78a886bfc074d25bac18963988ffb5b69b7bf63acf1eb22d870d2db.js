// app/javascript/controllers/block_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { id: String }

  connect() {
    this.allowDrag = false
    this.element.setAttribute('draggable', 'true')
  }

  enableDrag(event) {
    this.allowDrag = true
    event.currentTarget.classList.add('active-handle')
  }
  
  disableDrag(event) {
    this.allowDrag = false
    event.currentTarget.classList.remove('active-handle')
  }

  dragStart(event) {
    if (!this.allowDrag) { event.preventDefault(); return false }
    this.element.classList.add("dragging")
    event.dataTransfer.effectAllowed = "move"
    event.dataTransfer.setData("blockType", this.element.dataset.blockType)
    this.allowDrag = false
  }

  dragEnd(event) { this.element.classList.remove("dragging") }

  async remove() {
    const campaignId = document.querySelector('[data-controller="canvas"]').dataset.campaignId
    const blockId = this.element.dataset.blockId
    const resp = await fetch(`/api/v1/campaigns/${campaignId}/email_blocks/${blockId}`, {
      method: "DELETE",
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        "Accept": "application/json"
      }
    })
    if (resp.ok) this.element.remove()
  }

  duplicate() {
    const clone = this.element.cloneNode(true)
    this.element.parentNode.insertBefore(clone, this.element.nextSibling)
    // O puedes hacer una petición POST para duplicar en backend
  }

  saveCanvas() {
    const canvasController = this.application.getControllerForElementAndIdentifier(
      document.querySelector('[data-controller~="canvas"]'),
      "canvas"
    )
    if (canvasController) canvasController.save()
  }


  select(event) {
    document.querySelectorAll(".email-block.selected").forEach(b => b.classList.remove("selected"));
    this.element.classList.add("selected");
    const blockType = this.element.dataset.blockType;
    const category = this.element.dataset.category || "navigation";
    window.dispatchEvent(new CustomEvent("block:selected", {
      detail: { category, blockType, blockId: this.element.dataset.blockId }
    }));
  }


  editProperties(event) {
    event.stopPropagation(); // Para que no dispare select()
    const blockType = this.element.dataset.blockType;
    const category = this.element.dataset.category || "navigation";
    const blockId = this.element.dataset.blockId;
    window.dispatchEvent(new CustomEvent("block:selected", {
      detail: { category, blockType, blockId }
    }));
  }









  
};
