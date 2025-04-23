import { Controller } from "@hotwired/stimulus"

// Conecta este controller al botón o link de crear campaña
export default class extends Controller {
  static targets = ["name", "subject", "body", "industry", "limit"]

  async new(event) {
    event.preventDefault()

    const name = prompt("Nombre de la campaña:")
    const subject = prompt("Asunto del email:")
    const body = prompt("Cuerpo del mensaje (HTML permitido):")
    const industry = prompt("ID de la industria:")
    const emailLimit = prompt("Límite de emails a enviar:")

    if (!name || !subject || !body || !industry || !emailLimit) {
      alert("Todos los campos son obligatorios.")
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
      alert(`Campaña creada exitosamente: ID ${data.id}`)
    } else {
      const error = await response.json()
      alert("Error al crear campaña: " + (error.errors || error.message))
    }
  }
};
