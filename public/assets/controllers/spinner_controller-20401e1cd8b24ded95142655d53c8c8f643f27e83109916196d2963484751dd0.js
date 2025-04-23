import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["spinner"];

  connect() {
    console.log("Spinner Controller conectado"); // Confirma que Stimulus cargó
    if (this.hasSpinnerTarget) {
      console.log("Spinner encontrado en DOM, ocultándolo...");
      this.spinnerTarget.classList.add("spinner-hidden");
    }
  }

  showSpinner(event) {
    event.preventDefault();
    console.log("showSpinner activado");

    if (this.hasSpinnerTarget) {
      console.log("Antes de mostrar el spinner:", this.spinnerTarget.style.display);
      this.spinnerTarget.classList.remove("spinner-hidden");
      console.log("Después de mostrar el spinner:", this.spinnerTarget.style.display);
    } else {
      console.error("spinnerTarget no encontrado");
    }

    requestAnimationFrame(() => {
      event.target.submit();
      setTimeout(() => this.hideSpinner(), 1000);
    });
  }

  hideSpinner() {
    if (this.hasSpinnerTarget) {
      console.log("Ocultando el spinner...");
      this.spinnerTarget.classList.add("spinner-hidden");
    }
  }
};
