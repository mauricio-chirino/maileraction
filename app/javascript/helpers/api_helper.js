// app/javascript/helpers/api_helper.js

import { t } from "./i18n_helper";

export function getToken() {
  
  return localStorage.getItem('maileraction_jwt');
}

export async function authorizedFetch(url, options = {}) {
  const token = getToken();
  const headers = { ...(options.headers || {}) };
  if (token) {
    headers['Authorization'] = `Bearer ${token}`;
  } else {
    console.warn(t("api_helper.no_token")); // traducción
  }
  headers['Accept'] = "application/json";

  const resp = await fetch(url, { ...options, headers });
  // Manejo expiración (ejemplo: si el backend responde 401)
  if (resp.status === 401) {
    alert(t("api_helper.token_expirado")); // traducción
    // Opcional: removeToken() y redirigir al login
    localStorage.removeItem('maileraction_jwt');
    window.location.href = "/login"; // ajusta según tu ruta de login
    return resp; // igual retornamos la respuesta para quien la use
  }
  return resp;
}

export function removeToken() {
  localStorage.removeItem('maileraction_jwt');
}
