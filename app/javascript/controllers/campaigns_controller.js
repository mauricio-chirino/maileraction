import { Controller } from "@hotwired/stimulus"
import { t } from "../helpers/i18n_helper"

export default class extends Controller {
  static targets = ["name", "subject", "body", "industry", "limit"]

  async new(event) {
    event.preventDefault()

    const name = prompt(t("campaign.nombre"))
    const subject = prompt(t("campaign.asunto"))
    const body = prompt(t("campaign.cuerpo"))
    const industry = prompt(t("campaign.industria"))
    const emailLimit = prompt(t("campaign.limite"))

    if (!name || !subject || !body || !industry || !emailLimit) {
      alert(t("campaign.todos_obligatorios"))
      return
    }

    const response = await fetch("/api/v1/campaigns", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").getAttribute("content")
      },
      body: JSON.stringify({
        name: name,
        subject: subject,
        body: body,
        industry_id: industry,
        email_limit: emailLimit
      })
    })

    if (response.ok) {
      const data = await response.json()
      alert(t("campaign.creada", { id: data.id }))
    } else {
      const error = await response.json()
      alert(t("campaign.error_crear", { mensaje: error.errors || error.message }))
    }
  }
}
