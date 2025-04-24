// app/javascript/controllers/index.js
// Carga todos los controladores automáticamente
import { application } from "../application";

import HelloController from "./hello_controller";
application.register("hello", HelloController);


