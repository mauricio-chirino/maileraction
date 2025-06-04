// app/javascript/helpers/api_helper.js

export function getToken() {
  return localStorage.getItem('maileraction_jwt');
}

export function authorizedFetch(url, options = {}) {
  const token = getToken();
  const headers = options.headers || {};
  if (token) {
    headers['Authorization'] = `Bearer ${token}`;
  }
  headers['Accept'] = "application/json";
  return fetch(url, { ...options, headers });
}


export function removeToken() {
  localStorage.removeItem('maileraction_jwt');
}