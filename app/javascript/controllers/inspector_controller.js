// app/javascript/controllers/inspector_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "placeholder",
    "heroSettings",
    "headingSettings",
    "textSettings",
    "buttonSettings",
    "badgesSettings",
    "cardsSettings",
    "socialSettings"
  ];

  connect() {
      window.addEventListener("block:selected", (e) => {
        this.loadProperties(e.detail.category, e.detail.blockType)
      })
  }

  show(event) {
    const type = event.currentTarget.dataset.blockType;
    this.hideAll();

    switch (type) {
      case "hero":
        this.heroSettingsTarget.classList.remove("d-none");
        break;
      case "heading":
        this.headingSettingsTarget.classList.remove("d-none");
        break;
      case "text":
        this.textSettingsTarget.classList.remove("d-none");
        break;
      case "button":
        this.buttonSettingsTarget.classList.remove("d-none");
        break;
      case "badges":
        this.badgesSettingsTarget.classList.remove("d-none");
        break;
      case "cards":
        this.cardsSettingsTarget.classList.remove("d-none");
        break;
      case "social":
        this.socialSettingsTarget.classList.remove("d-none");
        break;
      default:
        this.placeholderTarget.classList.remove("d-none");
    }
  }

  handleBlockSelected(event) {
    const type = event.detail.blockType;
    this.hideAll();

    switch (type) {
      case "hero":
        this.heroSettingsTarget.classList.remove("d-none");
        break;
      case "heading":
        this.headingSettingsTarget.classList.remove("d-none");
        break;
      case "text":
        this.textSettingsTarget.classList.remove("d-none");
        break;
      case "button":
        this.buttonSettingsTarget.classList.remove("d-none");
        break;
      case "badges":
        this.badgesSettingsTarget.classList.remove("d-none");
        break;
      case "cards":
        this.cardsSettingsTarget.classList.remove("d-none");
        break;
      case "social":
        this.socialSettingsTarget.classList.remove("d-none");
        break;
      default:
        this.placeholderTarget.classList.remove("d-none");
    }
  }

  hideAll() {
    this.placeholderTarget.classList.add("d-none");
    this.heroSettingsTarget.classList.add("d-none");
    this.headingSettingsTarget.classList.add("d-none");
    this.textSettingsTarget.classList.add("d-none");
    this.buttonSettingsTarget.classList.add("d-none");
    this.badgesSettingsTarget.classList.add("d-none");
    this.cardsSettingsTarget.classList.add("d-none");
    this.socialSettingsTarget.classList.add("d-none");
  }

  disconnect() {
    window.removeEventListener("block:selected", this._handleBlockSelected);
  }


  async loadProperties(category, blockType) {
    const resp = await fetch(`/web/dashboard/inspector/${category}/${blockType}_property`)
    this.panelTarget.innerHTML = await resp.text()
  }



  
}
