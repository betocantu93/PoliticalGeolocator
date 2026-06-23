#!/usr/bin/env bash
# apply_all.sh — aplica TODOS los archivos SQL de representantes en el orden correcto.
# Para replicar la capa de representantes de un jalón (vía psql).
#
# NO incluye geografía ni cve_inegi (requieren descargas + ogr2ogr; ver OPERATIONS.md):
#   1) migraciones (supabase db push)  2) load.sh + transform.sql  3) este script
#   4) populate_cve_inegi.sql
#
# Uso:
#   export SUPABASE_DB_URL="postgresql://postgres.<ref>:<pwd>@aws-0-<region>.pooler.supabase.com:5432/postgres"
#   bash scripts/representatives/apply_all.sh
set -euo pipefail
: "${SUPABASE_DB_URL:?Exporta SUPABASE_DB_URL (Session pooler)}"
DIR="$(cd "$(dirname "$0")" && pwd)"

run() { echo ">> $(basename "$1")"; psql "$SUPABASE_DB_URL" -v ON_ERROR_STOP=1 -q -f "$1"; }

run "$DIR/gobernadores.sql"
run "$DIR/diputados_federales.sql"
for f in "$DIR"/[0-9][0-9]_*_locales.sql;     do run "$f"; done
for f in "$DIR"/[0-9][0-9]_*_presidentes.sql; do run "$f"; done
run "$DIR/_fixes_cvegeo.sql"   # ← correcciones por cvegeo: SIEMPRE al final

echo ">> Hecho. Valida con: psql \"\$SUPABASE_DB_URL\" -f scripts/checks.sql"
