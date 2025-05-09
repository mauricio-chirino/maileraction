# Pin npm packages by running ./bin/importmap

pin "application"


# config/importmap.rb

pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

pin "ol", to: "https://cdn.skypack.dev/ol"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
