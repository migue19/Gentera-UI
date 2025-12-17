#!/usr/bin/env bash
set -euo pipefail
cd docs

# Hacer rutas relativas
perl -0777 -pi -e 's/var baseUrl = "\/"/var baseUrl = "."/g' index.html
perl -0777 -pi -e 's/href="\//href="/g; s/src="\//src="/g' index.html

# Archivo de tema requerido por el viewer
cat > theme-settings.json <<'EOF'
{
  "colorScheme": "auto"
}
EOF
