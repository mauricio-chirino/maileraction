// app/javascript/controllers/drop_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["canvas"]

  connect() {
    this.canvasTarget.addEventListener("dragover", this.allowDrop)
    this.canvasTarget.addEventListener("drop", this.dropBlock)
  }

  allowDrop(event) {
    event.preventDefault()
  }

  dropBlock(event) {
    event.preventDefault()
    const blockType = event.dataTransfer.getData("text/plain")

    const newElement = document.createElement("div")
    newElement.classList.add("my-3")

    switch (blockType) {
      case "heading":
        newElement.innerHTML = "<h2 class='text-center'>Nuevo Título</h2>"
        break
      case "text":
        newElement.innerHTML = "<p class='text-center'>Nuevo párrafo de texto.</p>"
        break
      case "image":
        newElement.innerHTML = "<img src='https://via.placeholder.com/600x200' class='img-fluid rounded mx-auto d-block' alt='Imagen' />"
        break
      case "button":
        newElement.innerHTML = "<div class='text-center'><button class='btn btn-success'>Botón</button></div>"
        break
      case "divider":
        newElement.innerHTML = "<hr />"
        break
      default:
        newElement.innerHTML = `<p class='text-center'>Bloque desconocido: ${blockType}</p>`
    }

    this.canvasTarget.appendChild(newElement)
  }
}
