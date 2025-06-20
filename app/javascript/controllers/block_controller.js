// app/javascript/controllers/block_controller.js
import { Controller } from "@hotwired/stimulus"
import { authorizedFetch } from "../helpers/api_helper"
import { t } from "../helpers/i18n_helper"

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
    const campaignId = document.querySelector('[data-controller="canvas"]').dataset.canvasCampaignId
    let rawBlockId = this.element.dataset.blockId
    let blockId = rawBlockId.replace(/^block-/, '')
    const resp = await authorizedFetch(`/api/v1/campaigns/${campaignId}/email_blocks/${blockId}`, {
      method: "DELETE",
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        "Accept": "application/json"
      }
    })

    // Borra el bloque del DOM **independiente** del resultado, porque ya no existe en backend
    //this.element.remove()

    if (resp.ok) {
      // Sincroniza con el backend: fuerza recarga
      const canvasController = this.application.getControllerForElementAndIdentifier(
        document.querySelector('[data-controller~="canvas"]'),
        "canvas"
      )
      if (canvasController) {
        await canvasController.loadBlocksFromAPI(campaignId)
      }
      alert(t("block.eliminado"))
    } else {
      alert(t("block.error_eliminar"))
    }
  }





  duplicate() {
    const clone = this.element.cloneNode(true)
    this.element.parentNode.insertBefore(clone, this.element.nextSibling)
    alert(t("block.duplicado"))
  }

  saveCanvas() {
    const canvasController = this.application.getControllerForElementAndIdentifier(
      document.querySelector('[data-controller~="canvas"]'),
      "canvas"
    )
    if (canvasController) canvasController.save()
  }

  select(event) {
    document.querySelectorAll(".email-block.selected").forEach(b => b.classList.remove("selected"))
    this.element.classList.add("selected")
    const blockType = this.element.dataset.blockType
    const category = this.element.dataset.category || "navigation"
    window.dispatchEvent(new CustomEvent("block:selected", {
      detail: { category, blockType, blockId: this.element.dataset.blockId }
    }))
  }

  editProperties(event) {
    event.stopPropagation()
    const blockType = this.element.dataset.blockType
    const category = this.element.dataset.category || "navigation"
    const blockId = this.element.dataset.blockId
    window.dispatchEvent(new CustomEvent("block:selected", {
      detail: { category, blockType, blockId }
    }))
  }

  moveUp(event) {
    event.preventDefault()
    const area = this.element.closest('#canvas-area-blocks')
    const blocks = Array.from(area.children).filter(child =>
      child.classList.contains('email-block')
    )
    const idx = blocks.indexOf(this.element)
    if (idx > 0) {
      area.insertBefore(this.element, blocks[idx - 1])
      if (typeof this.saveCanvas === "function") this.saveCanvas()
    }
  }

  moveDown(event) {
    event.preventDefault()
    const area = this.element.closest('#canvas-area-blocks')
    const blocks = Array.from(area.children).filter(child =>
      child.classList.contains('email-block')
    )
    const idx = blocks.indexOf(this.element)
    if (idx !== -1 && idx < blocks.length - 1) {
      area.insertBefore(blocks[idx + 1], this.element)
      if (typeof this.saveCanvas === "function") this.saveCanvas()
    }
  }
}
