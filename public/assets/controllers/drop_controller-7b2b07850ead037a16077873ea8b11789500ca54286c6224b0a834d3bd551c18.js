// app/javascript/controllers/drop_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["canvas"]

  connect() {
    this.element.addEventListener("dragover", e => e.preventDefault())
    this.element.addEventListener("drop", this.handleDrop.bind(this))
  }

  handleDrop(e) {
    e.preventDefault()
    const blockType = e.dataTransfer.getData("text/plain")
    const canvas = this.canvasTarget

    const element = this.buildBlock(blockType)
    if (element) canvas.appendChild(element)
  }

  buildBlock(type) {
    const div = document.createElement("div")
    div.classList.add("mb-3")

    switch (type) {
      case "heading":
        div.innerHTML = "<h2 class='text-center'>Título Aquí</h2>"
        break
      case "image":
        div.innerHTML = "<img src='https://via.placeholder.com/600x200' class='img-fluid' alt='Imagen'>"
        break
      case "text":
        div.innerHTML = "<p>Este es un párrafo de texto editable...</p>"
        break
      case "button":
        div.innerHTML = "<div class='text-center'><a href='#' class='btn btn-primary'>Llamar a la acción</a></div>"
        break
      case "divider":
        div.innerHTML = "<hr />"
        break
      default:
        return null
    }

    return div
  }
};
