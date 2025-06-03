// app/javascript/controllers/canvas_controller.js
import { Controller } from "@hotwired/stimulus"
import { uniqueBlockId } from "../helpers/block_id_helper" // 👈 Importa el helper

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
      const blockType = event.dataTransfer.getData("blockType")
      const dropBlock = event.target.closest(".email-block")

      if (blockType) {
        fetch(`/web/dashboard/campaigns/block_html?block_type=${blockType}`)
          .then(response => response.text())
          .then(html => {
            const id = uniqueBlockId(blockType)
            
            const blockWrapper = `
              <div class="email-block position-relative mb-3"
                  data-controller="block"
                  data-block-type="${blockType}"
                  data-block-id="${id}"
                  draggable="true"
                  data-action="click->block#select dragstart->canvas#dragStart dragover->canvas#dragOver drop->canvas#drop dragend->canvas#dragEnd">
                ${html}
              </div>`
            if (dropBlock) {
              dropBlock.insertAdjacentHTML("beforebegin", blockWrapper)
            } else {
              this.areaTarget.insertAdjacentHTML("beforeend", blockWrapper)
            }
            this.save && this.save()
          })
          this.cleanDragClasses();
          
      }

      if (this.draggedBlock && dropBlock && dropBlock !== this.draggedBlock) {
        this.areaTarget.insertBefore(this.draggedBlock, dropBlock)
        this.save && this.save()
      }
      this.cleanDragClasses()
    }



  dragLeave(event) {
    const block = event.target.closest(".email-block");
    if (block) block.classList.remove("drag-over");
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
};
