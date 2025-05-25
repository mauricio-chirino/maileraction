// app/javascript/controllers/index.js
import { application } from "../stimulus_application"



import InspectorController from "./inspector_controller"
import BootstrapController from "./bootstrap_controller"


import CanvasController from "./canvas_controller"
import BlockController from "./block_controller"


import SidebarController from "./sidebar_controller" 


application.register("inspector", InspectorController)
application.register("bootstrap", BootstrapController)



application.register("canvas", CanvasController)
application.register("block", BlockController)

application.register("sidebar", SidebarController) 