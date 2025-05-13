// import "@hotwired/turbo-rails"
// import "controllers"



// app/javascript/controllers/application.js

import "@hotwired/turbo-rails"

import { Application } from "@hotwired/stimulus"
import DatatableController from "controllers/datatable_controller"
import ResponsiveController from "controllers/responsive_controller"
import MapController from "controllers/map_controller"
import BootstrapController from "controllers/bootstrap_controller"

const application = Application.start()
window.Stimulus = application

application.register("datatable", DatatableController)
application.register("responsive", ResponsiveController)
application.register("map", MapController)
application.register("bootstrap", BootstrapController)