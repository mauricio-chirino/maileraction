import { Controller } from "@hotwired/stimulus"
import $ from "jquery";
import "datatables.net";
import "datatables.net-responsive";
import "datatables.net-select";

export default class extends Controller {
  connect() {
    if (!$.fn.DataTable.isDataTable(this.element)) {
      $(this.element).DataTable({
        responsive: true,
        select: true,
        pageLength: 10,
        lengthMenu: [10, 25, 50, 100],
        language: {
          search: "Search:",
          lengthMenu: "Show _MENU_ entries",
          info: "Showing _START_ to _END_ of _TOTAL_ entries",
          paginate: {
            previous: "Previous",
            next: "Next"
          }
        }
      });
    }
  }

  disconnect() {
    if ($.fn.DataTable.isDataTable(this.element)) {
      $(this.element).DataTable().destroy();
    }
  }
};
