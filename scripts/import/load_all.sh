#!/usr/bin/env bash
# load_all.sh — carga TODOS los estados del INE BGD a staging en una pasada.
# No necesita psql: usa solo ogr2ogr y luego corres transform.sql UNA vez.
#
# Uso:
#   export SUPABASE_DB_URL="postgresql://postgres.<ref>:<pwd>@aws-0-<region>.pooler.supabase.com:5432/postgres"
#   bash scripts/import/load_all.sh ~/Downloads/bgd     # carpeta con las 32 carpetas de estado
#   # luego: pega scripts/import/transform.sql en el SQL Editor de Supabase y Run
#
# Estructura esperada:
#   ~/Downloads/bgd/01 AGUASCALIENTES/SECCION.shp ...
#   ~/Downloads/bgd/26 SONORA/SECCION.shp ...
set -euo pipefail

ROOT="${1:?Pasa la carpeta raíz con las carpetas de estado}"
: "${SUPABASE_DB_URL:?Exporta SUPABASE_DB_URL}"
PG="PG:${SUPABASE_DB_URL}"

first=1
for dir in "$ROOT"/*/; do
  [ -f "$dir/SECCION.shp" ] || { echo "skip (sin SECCION.shp): $dir"; continue; }

  # Primer estado crea la tabla (-overwrite); los demás agregan (-append).
  if [ $first -eq 1 ]; then mode="-overwrite"; first=0; else mode="-append"; fi
  echo "=== $(basename "$dir")  [$mode] ==="

  for pair in "ENTIDAD:staging_entidad" "MUNICIPIO:staging_municipios" "SECCION:staging_secciones"; do
    shp="${pair%%:*}"; tbl="${pair##*:}"
    ogr2ogr -f PostgreSQL "$PG" $mode \
      -nlt PROMOTE_TO_MULTI -t_srs EPSG:4326 \
      -lco GEOMETRY_NAME=geom -nln "$tbl" "$dir/$shp.shp"
  done
done

echo ">> Los 32 estados están en staging."
echo ">> Ahora corre UNA vez: scripts/import/transform.sql (SQL Editor o psql)."
