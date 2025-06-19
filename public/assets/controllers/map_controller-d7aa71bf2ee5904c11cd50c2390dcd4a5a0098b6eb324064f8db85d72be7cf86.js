// app/javascript/controllers/map_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["map", "country", "region", "city", "industry"]

  connect() {
    this.loadCountries()
    this.loadIndustries()
    // Aquí puedes inicializar OpenLayers si aún no lo has hecho
  }

  async loadCountries() {
    try {
      const res = await fetch("https://countriesnow.space/api/v0.1/countries/positions")
      const data = await res.json()

      this.countryTarget.innerHTML = '<option value="">Selecciona un país</option>'
      data.data.forEach(country => {
        const option = document.createElement("option")
        option.value = country.name
        option.textContent = country.name
        this.countryTarget.appendChild(option)
      })
    } catch (e) {
      console.error("Error cargando países:", e)
    }
  }

  async loadRegions() {
    const selectedCountry = this.countryTarget.value
    if (!selectedCountry) return

    try {
      const res = await fetch("https://countriesnow.space/api/v0.1/countries/states", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ country: selectedCountry })
      })
      const data = await res.json()

      this.regionTarget.innerHTML = '<option value="">Selecciona una región</option>'
      data.data.states.forEach(region => {
        const option = document.createElement("option")
        option.value = region.name
        option.textContent = region.name
        this.regionTarget.appendChild(option)
      })
    } catch (e) {
      console.error("Error cargando regiones:", e)
    }
  }

  async loadCities() {
    const selectedCountry = this.countryTarget.value
    const selectedRegion = this.regionTarget.value
    if (!selectedCountry || !selectedRegion) return

    try {
      const res = await fetch("https://countriesnow.space/api/v0.1/countries/state/cities", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ country: selectedCountry, state: selectedRegion })
      })
      const data = await res.json()

      this.cityTarget.innerHTML = '<option value="">Selecciona una ciudad</option>'
      data.data.forEach(city => {
        const option = document.createElement("option")
        option.value = city
        option.textContent = city
        this.cityTarget.appendChild(option)
      })
    } catch (e) {
      console.error("Error cargando ciudades:", e)
    }
  }

  async loadIndustries() {
    try {
      const res = await fetch("/api/v1/industries")
      const data = await res.json()

      this.industryTarget.innerHTML = '<option value="">Selecciona un rubro</option>'
      data.forEach(industry => {
        const option = document.createElement("option")
        option.value = industry.name
        option.textContent = industry.name
        this.industryTarget.appendChild(option)
      })
    } catch (e) {
      console.error("Error cargando rubros:", e)
    }
  }

  filter() {
    const filters = {
      country: this.countryTarget.value,
      region: this.regionTarget.value,
      city: this.cityTarget.value,
      industry: this.industryTarget.value
    }
    console.log("Aplicando filtros:", filters)
    // Aquí puedes interactuar con OpenLayers o realizar una llamada a tu backend para obtener los puntos
  }

  reset() {
    this.countryTarget.value = ""
    this.regionTarget.innerHTML = '<option value="">Selecciona una región</option>'
    this.cityTarget.innerHTML = '<option value="">Selecciona una ciudad</option>'
    this.industryTarget.value = ""
    console.log("Filtros reiniciados")
  }
};
