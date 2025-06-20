// app/javascript/helpers/i18n_helper.js
export function t(key, replacements = {}) {
  const elem = document.getElementById('js-translations') // esta ligado a layouts/application.html.erb
  if (!elem) return key // Devuelve la clave si no hay traducción disponible

  const dataset = elem.dataset
  // Convierte "block.eliminado" en "blockEliminado"
  const dataKey = key.split('.').map((part, i) =>
    i === 0 ? part : part.charAt(0).toUpperCase() + part.slice(1)
  ).join('')
  let value = dataset[dataKey]
  if (!value) return key // Devuelve la clave si no hay traducción
  Object.entries(replacements).forEach(([k, v]) => {
    value = value.replace(new RegExp(`%\\{${k}\\}`, 'g'), v)
  })
  return value
}