// app/javascript/application.js
import { Application } from "@hotwired/stimulus"


import { Turbo } from "@hotwired/turbo-rails"
window.Turbo = Turbo

import DatatableController from "./controllers/datatable_controller"


import ResponsiveController from "./controllers/responsive_controller"


import MapController from "./controllers/map_controller"


window.Stimulus = Application.start()
Stimulus.register("datatable", DatatableController)

Stimulus.register("responsive", ResponsiveController)
Stimulus.register("map", MapController)