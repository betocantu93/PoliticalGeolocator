#!/usr/bin/env bash
# load.sh — carga UN estado del INE BGD (Base Geográfica Digital) a tablas staging.
# Requiere GDAL (ogr2ogr).
#
# Uso:
#   export SUPABASE_DB_URL="postgresql://postgres.<ref>:<pwd>@aws-0-<region>.pooler.supabase.com:5432/postgres"
#   bash scripts/import/load.sh "/Users/me/Downloads/26 SONORA"
#   psql "$SUPABASE_DB_URL" -f scripts/import/transform.sql
#
# El folder del estado viene del INE BGD y trae ENTIDAD.shp, MUNICIPIO.shp y
# SECCION.shp (entre muchos otros que NO usamos). Los nombres de archivo son
# iguales en los 32 estados; solo cambia la carpeta.
set -euo pipefail

STATE_DIR="${1:?Pasa la carpeta del estado, p.ej. \"/Users/me/Downloads/26 SONORA\"}"
: "${SUPABASE_DB_URL:?Exporta SUPABASE_DB_URL con la cadena de conexión de Supabase}"

PG="PG:${SUPABASE_DB_URL}"

# -t_srs EPSG:4326 reproyecta desde el .prj de CADA estado (cada uno viene en su
#   propia zona UTM). NO hace falta saber la zona: ogr2ogr la lee del shapefile.
# -nlt PROMOTE_TO_MULTI vuelve los Polygon en MultiPolygon (lo que espera el esquema).
common=(-f PostgreSQL "$PG" -nlt PROMOTE_TO_MULTI -t_srs EPSG:4326
        -lco GEOMETRY_NAME=geom -lco FID=gid -overwrite -progress)

echo ">> Cargando estado: $STATE_DIR"
ogr2ogr "${common[@]}" -nln staging_entidad    "$STATE_DIR/ENTIDAD.shp"
ogr2ogr "${common[@]}" -nln staging_municipios "$STATE_DIR/MUNICIPIO.shp"
ogr2ogr "${common[@]}" -nln staging_secciones  "$STATE_DIR/SECCION.shp"

echo ">> Staging listo. Ahora normaliza a las tablas finales:"
echo "   psql \"\$SUPABASE_DB_URL\" -f scripts/import/transform.sql"
