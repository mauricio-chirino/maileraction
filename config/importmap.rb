# Pin npm packages by running ./bin/importmap


pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true

# Elimina esto si está duplicado:
# pin_all_from "app/javascript/controllers", under: "controllers"

# Registra manualmente uno por uno (más controlado y sin conflictos)
pin "controllers", to: "controllers/index.js"
pin "controllers/hello_controller", to: "controllers/hello_controller.js"
pin "controllers/drag_controller", to: "controllers/drag_controller.js"
pin "controllers/drop_controller", to: "controllers/drop_controller.js"
pin "controllers/bootstrap_controller", to: "controllers/bootstrap_controller.js"
pin "controllers/inspector_controller", to: "controllers/inspector_controller.js"
# agrega los demás según los tengas
#
#
# pin "sneat/config", to: "sneat/config.js"
# pin "sneat/main", to: "sneat/main.js"
pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js", preload: true
