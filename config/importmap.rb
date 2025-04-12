# config/importmap.rb
pin "stimulus", to: "stimulus.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
