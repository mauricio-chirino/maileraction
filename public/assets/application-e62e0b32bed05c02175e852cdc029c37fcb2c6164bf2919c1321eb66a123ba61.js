// app/javascript/application.js
import { Application } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"

import DatatableController from "./controllers/datatable_controller"

window.Stimulus = Application.start()
Stimulus.register("datatable", DatatableController);
