// app/javascript/packs/application.js (o el archivo JS adecuado en tu proyecto)

document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("signup_form");
    const submitButton = document.getElementById("submit_button");
    const loadingSpinner = document.getElementById("loading_spinner");
  
    form.addEventListener("submit", function() {
      // Mostrar el spinner
      loadingSpinner.style.display = "flex";
      
      // Deshabilitar el botón de submit para evitar envíos múltiples
      submitButton.disabled = true;
    });
  });