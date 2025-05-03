import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["column"]

  connect() {
    this.updateColumns()
    window.addEventListener("resize", this.updateColumns.bind(this))
  }

  disconnect() {
    window.removeEventListener("resize", this.updateColumns.bind(this))
  }

  updateColumns() {
    const isLargeScreen = window.innerWidth >= 1200

    this.columnTargets.forEach((column) => {
      if (isLargeScreen) {
        column.classList.remove("dtr-hidden")
        column.style.display = ""
      } else {
        column.classList.add("dtr-hidden")
        column.style.display = "none"
      }
    })
  }
};
