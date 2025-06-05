// app/javascript/controllers/canvas_controller.js
import { Controller } from "@hotwired/stimulus"
import { uniqueBlockId } from "../helpers/block_id_helper"
import { authorizedFetch } from "../helpers/api_helper"

export default class extends Controller {
  static targets = ["area"]

  connect() {
    this.draggedBlock = null
    // Carga bloques desde backend usando API autorizada
    this.loadBlocksFromAPI(this.data.get("campaignId"))
  }



  async loadBlocksFromAPI(campaignId) {
    console.log("TOKEN JWT ANTES DE LLAMAR A authorizedFetch:", localStorage.getItem('maileraction_jwt'));

    const response = await authorizedFetch(`/api/v1/campaigns/${campaignId}/email_blocks`);
    let blocks;
    try {
      blocks = await response.json();
    } catch (e) {
      blocks = [];
    }
    if (!Array.isArray(blocks)) return; // evita error y NO limpia demo
    this.renderBlocks(blocks);
  }
  






  renderBlocks(blocks) {
    //this.areaTarget.innerHTML = ""
    // Sólo limpia el canvas si HAY bloques de verdad
    if (!Array.isArray(blocks) || blocks.length === 0) return; // deja demo
    if (blocks.length === 0) {
      // La lógica de demo la controla Rails al renderizar
      return
    }
    // Si HAY bloques, entonces sí limpia y agrega los reales
    this.areaTarget.innerHTML = "";
    blocks.forEach(block => {
      // Render parcial en HTML desde backend (mejorable, pero simple para MVP)
      const el = document.createElement("div");
      el.className = "email-block position-relative mb-3";
      el.setAttribute("data-controller", "block");
      el.setAttribute("data-block-type", block.block_type);
      el.setAttribute("data-block-id", block.id);
      el.setAttribute("draggable", "true");
      el.setAttribute(
        "data-action",
        "click->block#select dragstart->canvas#dragStart dragover->canvas#dragOver drop->canvas#drop dragend->canvas#dragEnd"
      );
      el.innerHTML = block.content // Contenido HTML del bloque
      this.areaTarget.appendChild(el);
    })
  }

  dragStart(event) {
    this.draggedBlock = event.currentTarget
  }

  dragOver(event) {
    event.preventDefault()
    const overBlock = event.target.closest(".email-block")
    if (overBlock && overBlock !== this.draggedBlock) overBlock.classList.add("drag-over")
  }

  async drop(event) {
    event.preventDefault()
    const blockType = event.dataTransfer.getData("blockType")
    const dropBlock = event.target.closest(".email-block")
    const campaignId = this.data.get("campaignId")

    if (blockType) {
      // Usa el endpoint para obtener el HTML parcial (no necesita JWT porque es vista)
      const resp = await fetch(`/web/dashboard/campaigns/block_html?block_type=${blockType}`)
      const html = await resp.text()
      // Guarda bloque en backend (usa JWT)
      const apiResp = await authorizedFetch(`/api/v1/campaigns/${campaignId}/email_blocks`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        },
        body: JSON.stringify({
          email_block: { block_type: blockType, category: "navigation", content: html }
        })
      })
      const block = await apiResp.json()
      // Agrega al DOM
      this.renderBlocks([...this.getCurrentBlocks(), block])
    }

    if (this.draggedBlock && dropBlock && dropBlock !== this.draggedBlock) {
      this.areaTarget.insertBefore(this.draggedBlock, dropBlock)
      this.save()
    }
    this.cleanDragClasses()
  }

  getCurrentBlocks() {
    return Array.from(this.areaTarget.children).map(b => ({
      id: b.dataset.blockId,
      block_type: b.dataset.blockType,
      content: b.innerHTML
    }))
  }

  dragLeave(event) {
    const block = event.target.closest(".email-block")
    if (block) block.classList.remove("drag-over")
  }

  dragEnd(event) {
    if (this.draggedBlock) {
      this.draggedBlock.classList.remove("dragging")
      this.draggedBlock = null
    }
    this.cleanDragClasses()
  }

  cleanDragClasses() {
    document.querySelectorAll(".email-block.drag-over").forEach(el => el.classList.remove("drag-over"))
  }

  save() {
    // Si quieres: sincroniza orden con backend aquí (pendiente para el MVP)
  }
}
