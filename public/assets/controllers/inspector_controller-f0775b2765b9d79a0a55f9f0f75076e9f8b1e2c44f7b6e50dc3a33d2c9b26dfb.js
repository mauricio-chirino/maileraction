// app/javascript/controllers/inspector_controller.js
import { Controller } from "@hotwired/stimulus"
import { t } from "../helpers/i18n_helper"

export default class extends Controller {
  static targets = [
    "panel",
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
    console.log(t("data.inspector_conectado"), this.panelTarget, this.element)
    window.addEventListener("block:selected", (e) => {
      this.loadProperties(e.detail.category, e.detail.blockType, e.detail.blockId)
    })
  }

  show(event) {
    const type = event.currentTarget.dataset.blockType
    this.hideAll()
    switch (type) {
      case "hero": this.heroSettingsTarget.classList.remove("d-none"); break;
      case "heading": this.headingSettingsTarget.classList.remove("d-none"); break;
      case "text": this.textSettingsTarget.classList.remove("d-none"); break;
      case "button": this.buttonSettingsTarget.classList.remove("d-none"); break;
      case "badges": this.badgesSettingsTarget.classList.remove("d-none"); break;
      case "cards": this.cardsSettingsTarget.classList.remove("d-none"); break;
      case "social": this.socialSettingsTarget.classList.remove("d-none"); break;
      default: this.placeholderTarget.classList.remove("d-none");
    }
  }

  handleBlockSelected(event) { this.show(event) }

  hideAll() {
    this.placeholderTarget.classList.add("d-none")
    this.heroSettingsTarget.classList.add("d-none")
    this.headingSettingsTarget.classList.add("d-none")
    this.textSettingsTarget.classList.add("d-none")
    this.buttonSettingsTarget.classList.add("d-none")
    this.badgesSettingsTarget.classList.add("d-none")
    this.cardsSettingsTarget.classList.add("d-none")
    this.socialSettingsTarget.classList.add("d-none")
  }

  disconnect() {
    window.removeEventListener("block:selected", this._handleBlockSelected)
  }

  async loadProperties(category, blockType, blockId) {
    const url = `/web/dashboard/inspector/${category}/${blockType}_property`
    const resp = await fetch(url)
    this.panelTarget.innerHTML = await resp.text()
    this.element.dataset.currentBlockId = blockId
    const block = document.querySelector(`.email-block[data-block-id="${blockId}"]`)
    if (block) {
      const navLinks = block.querySelectorAll('a')
      const input1 = this.panelTarget.querySelector('input[name="menu_item_1"]')
      if (input1 && navLinks[0]) input1.value = navLinks[0].textContent
    }
  }

  updateLogoUrl(event) {
    const url = event.target.value
    const blockId = this.element.dataset.currentBlockId
    const block = document.querySelector(`.email-block[data-block-id="${blockId}"]`)
    if (block) {
      const img = block.querySelector("img")
      if (img) img.src = url
    }
  }

  updateLogoName(event) {
    const name = event.target.value
    const blockId = this.element.dataset.currentBlockId
    const block = document.querySelector(`.email-block[data-block-id="${blockId}"]`)
    if (block) {
      const span = block.querySelector("span.fw-semibold")
      if (span) span.textContent = name
    }
  }
};
