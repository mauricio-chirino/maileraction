
import { application } from "../stimulus_application"
import { definitionsFromContext } from "@hotwired/stimulus"

const context = require.context(".", true, /\.js$/)
application.load(definitionsFromContext(context));
