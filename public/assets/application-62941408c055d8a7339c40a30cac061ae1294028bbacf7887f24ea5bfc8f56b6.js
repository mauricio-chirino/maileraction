// app/javascript/application.js
// app/javascript/application.js

import { Turbo } from "@hotwired/turbo-rails"
window.Turbo = Turbo

import { Application } from "@hotwired/stimulus"
window.Stimulus = Application.start()

import DatatableController from "./controllers/datatable_controller"
import ResponsiveController from "./controllers/responsive_controller"
import MapController from "./controllers/map_controller"

Stimulus.register("datatable", DatatableController)
Stimulus.register("responsive", ResponsiveController)
Stimulus.register("map", MapController)


;
