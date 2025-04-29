// app/javascript/controllers/index.js
import { application } from "./application"

import { eagerLoadControllersFrom } from "@hotwired/stimulus"

eagerLoadControllersFrom("controllers", application)
