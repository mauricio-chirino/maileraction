// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// app/javascript/application.js

// app/javascript/application.js
import "@hotwired/turbo-rails"
import "./stimulus_application" // <- Este importa y arranca Stimulus
import "controllers"



import "bootstrap"




// global_helpers.js
window.updateNavMenuItem = function(input, idx) {
  // Busca el inspector y extrae el id del bloque actualmente editado
  const inspector = document.querySelector('[data-controller="inspector"]');
  const blockId = inspector?.dataset?.currentBlockId;
  if (!blockId) return;

  // Busca el bloque en el canvas central por su id único
  const block = document.querySelector(`.email-block[data-block-id="${blockId}"]`);
  if (!block) return;

  // Encuentra los links (a) del bloque y actualiza el indicado
  const links = block.querySelectorAll('a');
  if (links[idx]) links[idx].textContent = input.value;
};
