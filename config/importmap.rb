# Pin npm packages by running ./bin/importmap


pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true

# Elimina esto si está duplicado:
# pin_all_from "app/javascript/controllers", under: "controllers"

# Registra manualmente uno por uno (más controlado y sin conflictos)
pin "controllers", to: "controllers/index.js"


pin "controllers/bootstrap_controller", to: "controllers/bootstrap_controller.js"
pin "controllers/inspector_controller", to: "controllers/inspector_controller.js"
# agrega los demás según los tengas
#
# Helpers
pin "helpers/api_helper", to: "helpers/api_helper.js"
# pin "sneat/config", to: "sneat/config.js"
# pin "sneat/main", to: "sneat/main.js"
pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js", preload: true




pin "controllers/canvas_controller", to: "controllers/canvas_controller.js"
pin "controllers/block_controller", to: "controllers/block_controller.js"
pin "controllers/sidebar_controller", to: "controllers/sidebar_controller.js"
