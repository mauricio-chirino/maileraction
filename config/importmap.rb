pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2


pin "application", to: "application.js"
pin "controllers", to: "controllers/index.js"
pin_all_from "app/javascript/controllers", under: "controllers"
