#!/bin/bash

# Verificar que estamos en la rama base correcta
git checkout development/panel-admin || exit 1

# Lista de subfuncionalidades
ramas=(
  "campaign"
  "transactional"
  "contacts"
  "integrations"
  "authentication"
  "reports"
  "administration"
  "users"
  "roles-permissions"
  "authentications"
  "account"
  "my-profile"
  "settings"
  "plans-credits"
  "invoice"
  "misc"
  "academy"
  "support-feedback"
)

# Crear y subir cada rama basada en development/panel-admin
for r in "${ramas[@]}"; do
  nombre_rama="feature/panel-admin/$r"
  echo "✅ Creando rama: $nombre_rama desde development/panel-admin"
  git checkout -b "$nombre_rama"
  git push -u origin "$nombre_rama"
  git checkout development/panel-admin
done

echo "🎉 Todas las ramas fueron creadas y subidas correctamente desde development/panel-admin."
