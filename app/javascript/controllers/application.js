// app/javascript/application.js
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

// Crea una nueva aplicación Stimulus
const application = Application.start()

// Carga todos los controladores desde la carpeta controllers
const context = require.context("controllers", true, /.js$/)
application.load(definitionsFromContext(context))