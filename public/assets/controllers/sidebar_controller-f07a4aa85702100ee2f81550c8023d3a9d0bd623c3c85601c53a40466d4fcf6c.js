import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["block"]

  showBlockPreview(event) {
    // Solo en hover
    const block = event.currentTarget
    const preview = block.querySelector('.block-preview-html')
    if (preview) preview.style.display = 'block'
  }

  hideBlockPreview(event) {
    // En mouseout, mousedown o dragstart
    const block = event.currentTarget
    const preview = block.querySelector('.block-preview-html')
    if (preview) preview.style.display = 'none'
  }
};
