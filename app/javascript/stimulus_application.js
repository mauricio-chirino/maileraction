// app/javascript/stimulus_application.js
import { Application } from "@hotwired/stimulus"

const application = Application.start()
export { application }

window.Stimulus = application