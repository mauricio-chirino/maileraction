# config/importmap.rb
pin "application"


pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.2/dist/stimulus.js"

pin "@hotwired/turbo-rails", to: "https://ga.jspm.io/npm:@hotwired/turbo-rails@7.3.0/app/assets/javascripts/turbo.js"




pin_all_from "app/javascript/controllers", under: "controllers"
