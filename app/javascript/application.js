// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Application } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"

import HelloController from "./controllers/hello_controller.js"

window.Stimulus = Application.start()


Stimulus.register("hello", HelloController)
