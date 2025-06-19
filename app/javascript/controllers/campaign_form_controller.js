import { Controller } from "@hotwired/stimulus"
import { t } from "../helpers/i18n_helper"

export default class extends Controller {
  static targets = ["name", "useTemplate", "editor"]

  connect() {
    this.toggleButtons()
  }

  toggleButtons() {
    const namePresent = this.nameTarget.value.trim().length > 0
    this.useTemplateTarget.disabled = !namePresent
    this.editorTarget.disabled = !namePresent
  }

  openEditor(event) {
    if (this.editorTarget.disabled) {
      event.preventDefault()
      return
    }
    const locale = document.documentElement.lang || "en"
    const url = `/${locale}/web/dashboard/dashboard?section=campaign_create&editor=visual`
    Turbo.visit(url, { frame: "dashboard_section" })
  }

  openTemplates(event) {
    if (this.useTemplateTarget.disabled) {
      event.preventDefault()
      return
    }
    const locale = document.documentElement.lang || "en"
    const campaignName = this.nameTarget.value
    const url = `/${locale}/web/dashboard/templates?campaign_name=${encodeURIComponent(campaignName)}`
    Turbo.visit(url, { frame: "dashboard_section" })
  }
}
