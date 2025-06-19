import { Controller } from "@hotwired/stimulus"
import { t } from "../helpers/i18n_helper"

export default class extends Controller {
  connect() {
    console.log(t("data.hello_controller_funcionando"))
  }
}
