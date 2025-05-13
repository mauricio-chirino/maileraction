// app/javascript/controllers/index.js
import { application } from "application"

import BootstrapController from "bootstrap_controller"

import DragController from "drag_controller"
import DropController from "drop_controller"


import { eagerLoadControllersFrom } from "@hotwired/stimulus"

eagerLoadControllersFrom("controllers", application)


application.register("bootstrap", BootstrapController)

application.register("drag", DragController)
application.register("drop", DropController)