// app/javascript/application.js
// Establece Stimulus como la app principal
import { Application } from "@hotwired/stimulus"

// Inicia Stimulus y lo asigna globalmente
window.Stimulus = Application.start()

// Importa todos los controladores desde controllers/
import "./controllers"

// Importa jQuery (necesitas haber hecho: bin/importmap pin "jquery")
import "jquery"

// Si usas efectos como tooltips, popovers, etc., activa jQuery globalmente
window.$ = window.jQuery = $;
