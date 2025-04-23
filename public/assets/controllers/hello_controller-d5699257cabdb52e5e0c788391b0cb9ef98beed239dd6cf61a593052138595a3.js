import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  greet() {
    alert("¡Hola desde Stimulus!")
  }
};
