import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = []

  selectTemplate(event) {
    const templateId = event.currentTarget.dataset.templateId
    const locale = document.documentElement.lang || "en"
    // Puedes enviar otros datos por URL (ej: campaign_name si lo necesitas)
    // Redirige al editor visual con el template cargado
    const url = `/${locale}/web/dashboard/dashboard?section=campaign_create&editor=visual&template_id=${templateId}`
    Turbo.visit(url, { frame: "dashboard_section" })
  }
}
