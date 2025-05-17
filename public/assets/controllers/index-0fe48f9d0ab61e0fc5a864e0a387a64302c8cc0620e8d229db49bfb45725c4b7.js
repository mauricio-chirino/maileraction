// app/javascript/controllers/index.js
import { application } from "../stimulus_application"

import HelloController from "./hello_controller"
import DragController from "./drag_controller"
import DropController from "./drop_controller"
import InspectorController from "./inspector_controller"
import BootstrapController from "./bootstrap_controller"

application.register("hello", HelloController)
application.register("drag", DragController)
application.register("drop", DropController)
application.register("inspector", InspectorController)
application.register("bootstrap", BootstrapController);
