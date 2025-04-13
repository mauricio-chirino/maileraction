// app/javascript/controllers/spinner_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["spinner"];

  showSpinner() {
    this.spinnerTarget.style.display = "block";
  }

  hideSpinner() {
    this.spinnerTarget.style.display = "none";
  }
}