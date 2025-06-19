// controllers/sidebar_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  createBlockPreview(event) {
    const blockType = event.currentTarget.dataset.blockType
    event.dataTransfer.setData("blockType", blockType)
  }
};
