// app/javascript/application.js

// Importa Stimulus y la aplicación principal de Stimulus
import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers";







// Crea una nueva instancia de la aplicación Stimulus
const application = Application.start()

// Configura Stimulus para que cargue los controladores de forma automática
const context = require.context("controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))





document.addEventListener("DOMContentLoaded", () => {
    const phrases = [
      I18n.t("hero.phrases")[0], // Esto obtiene la primera frase en el idioma seleccionado
      I18n.t("hero.phrases")[1],
      I18n.t("hero.phrases")[2],
      I18n.t("hero.phrases")[3],
      I18n.t("hero.phrases")[4]
    ];
  
    let current = 0;
    const el = document.getElementById("dynamic-heading");
  
    if (el) {
      setInterval(() => {
        el.classList.add("fade-out");
        setTimeout(() => {
          current = (current + 1) % phrases.length;
          el.textContent = phrases[current];
          el.classList.remove("fade-out");
        }, 1000);
      }, 5000);
    }
  });