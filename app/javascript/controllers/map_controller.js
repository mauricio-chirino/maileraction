import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const map = L.map(this.element).setView([-33.45, -70.6667], 6); // Santiago de Chile

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; OpenStreetMap contributors'
    }).addTo(map);

    L.marker([-33.45, -70.6667]).addTo(map).bindPopup("Santiago").openPopup();
  }
}