// app/javascript/application.js
import { Application } from "@hotwired/stimulus"

window.Stimulus = Application.start()

import HelloController from "./controllers/hello_controller.js"

Stimulus.register("hello", HelloController)

