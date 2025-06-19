#!/bin/bash

echo "🔍 Buscando 'javascript_include_tag' en archivos .erb..."

grep -rn --include="*.erb" "javascript_include_tag" app/views

echo "✅ Búsqueda completada."
