// app/javascript/helpers/api_helper.js

export function getToken() {
  return localStorage.getItem('maileraction_jwt');
}

export function removeToken() {
  localStorage.removeItem('maileraction_jwt');
}

// Función mejorada para fetch autorizado que maneja expiración automáticamente
export async function authorizedFetch(url, options = {}) {
  const token = getToken();
  const headers = { ...(options.headers || {}) };

  if (token) {
    headers['Authorization'] = `Bearer ${token}`;
  }
  headers['Accept'] = "application/json";

  const resp = await fetch(url, { ...options, headers });

  // Si el token expiró o no es válido, el backend debe responder 401 o 403
  if (resp.status === 401 || resp.status === 403) {
    // Elimina el token y redirige al login
    removeToken();

    // Puedes guardar la URL actual para redirigir después de login
    const currentUrl = window.location.pathname + window.location.search;
    localStorage.setItem('redirect_after_login', currentUrl);

    // Redirige (ajusta el path si tu login está en otro lado)
    window.location.href = "/login";
    return; // O puedes retornar un error explícito
  }

  return resp;
}

