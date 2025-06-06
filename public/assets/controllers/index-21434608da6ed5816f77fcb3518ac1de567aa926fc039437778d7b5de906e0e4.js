// app/javascript/controllers/index.js
import { application } from "../stimulus_application"

// General UI controllers
import BootstrapController from "./bootstrap_controller"
import SidebarController from "./sidebar_controller"

// Editor controllers
import InspectorController from "./inspector_controller"
import CanvasController from "./canvas_controller"
import BlockController from "./block_controller"

// Register controllers
application.register("bootstrap", BootstrapController)
application.register("sidebar", SidebarController)

application.register("inspector", InspectorController)
application.register("canvas", CanvasController)
application.register("block", BlockController);
