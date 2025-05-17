// app/javascript/controllers/inspector_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["placeholder", "headingSettings", "buttonSettings"];

  connect() {
    console.log("InspectorController connected");
  }

  show(event) {
    const type = event.currentTarget.dataset.blockType;
    this.hideAll();

    switch (type) {
      case "heading":
        this.headingSettingsTarget.classList.remove("d-none");
        break;
      case "button":
        this.buttonSettingsTarget.classList.remove("d-none");
        break;
      default:
        this.placeholderTarget.classList.remove("d-none");
    }
  }

  hideAll() {
    this.placeholderTarget.classList.add("d-none");
    this.headingSettingsTarget.classList.add("d-none");
    this.buttonSettingsTarget.classList.add("d-none");
  }
}

