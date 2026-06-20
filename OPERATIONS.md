# OPERATIONS — runbook de geoelectoral

Pasos exactos para cargar, verificar y **actualizar** los datos. Cada paso dice
**dónde** se corre:

- 🖥️ **Terminal** = la app Terminal de tu Mac (donde corres `ogr2ogr`).
- 🟢 **SQL Editor** = Supabase Dashboard → SQL Editor (donde pegas SQL).

> Variable que usan los comandos de Terminal (sácala de Dashboard → Connect → **Session pooler**):
> ```bash
> export SUPABASE_DB_URL="postgresql://postgres.<ref>:<DB_PASSWORD>@aws-0-<region>.pooler.supabase.com:5432/postgres"
> ```

---

## Playbook 0 — Setup inicial (una sola vez)

🟢 **SQL Editor** — aplica las migraciones en orden (pega el contenido de cada una y Run):
```
supabase/migrations/0001_schema.sql          esquema + índices GIST
supabase/migrations/0002_resolve_coordinate.sql   función resolve_coordinate
supabase/migrations/0003_seed_representatives.sql  gobernadores (opcional)
supabase/migrations/0006_update_calendar.sql       calendario de mantenimiento
supabase/migrations/0005_foreign_keys.sql     FKs (aplicar AL FINAL, ver Playbook 5)
```

🖥️ **Terminal** — instala la herramienta de carga (una vez):
```bash
brew install gdal
```

---

## Playbook 1 — Cargar geografía de UN estado

🖥️ **Terminal** (ejemplo Sonora; la carpeta sale del INE BGD):
```bash
bash scripts/import/load.sh "/Users/me/Downloads/26 SONORA"
```

🟢 **SQL Editor** — pega y corre el contenido de:
```
scripts/import/transform.sql
```

🟢 **SQL Editor** — verifica:
```sql
select count(*) from public.municipalities;   -- p.ej. 72 (Sonora)
```

---

## Playbook 2 — Cargar geografía de LOS 32

Requisito: las 32 carpetas del INE BGD en un solo directorio (`~/Downloads/bgd/`).

🖥️ **Terminal** — carga todo a staging en una pasada:
```bash
bash scripts/import/load_all.sh ~/Downloads/bgd
```

🟢 **SQL Editor** — corre UNA vez el contenido de `scripts/import/transform.sql`, luego:
```sql
select count(*) from public.states;   -- 32
```

---

## Playbook 3 — Gobernadores (32)

🟢 **SQL Editor** — pega y corre:
```
scripts/representatives/gobernadores.sql
```
Verifica: `select count(*) from public.representatives where role='governor';` → 32

**Actualizar** (cuando un estado cambie): edita el archivo y vuelve a correrlo
(usa `on conflict do update`, así que sobreescribe sin duplicar).

---

## Playbook 4 — Diputados federales (300)

1. 🌐 Exporta el xlsx oficial: https://web.diputados.gob.mx/inicio/tusDiputados
   → quita filtros → botón **Excel** → guarda como `~/Downloads/Diputados.xlsx`.
2. 🖥️ **Terminal** — regenera el SQL desde el xlsx:
   ```bash
   python3 scripts/representatives/build_diputados_federales.py ~/Downloads/Diputados.xlsx
   ```
3. 🟢 **SQL Editor** — pega y corre el resultado:
   ```
   scripts/representatives/diputados_federales.sql
   ```
   Verifica: `select count(*) from public.representatives where role='federal_deputy';` → 300

**Actualizar** (cada 3 años, sep): repite los 3 pasos con el xlsx de la nueva legislatura.

---

## Playbook 5 — Diputados locales + presidentes (POR estado)

No hay fuente nacional; se hace estado por estado (anexos de Wikipedia / congreso / OPLE).
Patrón por estado (ejemplo Sonora ya hecho):

- Diputados locales → INSERT directo (ver formato en `gobernadores.sql`), `role='local_deputy'`,
  `distrito` = distrito local.
- Presidentes municipales → usa el truco de JOIN por nombre:
  ```
  scripts/representatives/sonora_presidentes_municipales.sql   (plantilla)
  ```
  Copia el archivo, reemplaza la lista de municipios del nuevo estado, corre.

🟢 Después, aplica FKs si aún no:
```sql
-- Prerrequisito: sin representantes de estados sin geometría
delete from public.representatives where cve_ent not in (select cve_ent from public.states);
```
luego pega `supabase/migrations/0005_foreign_keys.sql`.

---

## Playbook 6 — Verificar salud (tras cualquier carga)

🟢 **SQL Editor** — pega y corre:
```
scripts/checks.sql
```
Revisa cualquier fila bajo "PROBLEMA": geometría en UTM, secciones sin distrito,
representantes huérfanos, municipios sin presidente.

---

## Playbook 7 — Actualizar (mantenimiento por cadencia)

🟢 **SQL Editor** — ¿qué se vence en los próximos 90 días?
```sql
select cargo_type, cve_ent, next_election, notes
from public.update_calendar
where next_election <= current_date + interval '90 days'
order by next_election;
```

Según lo que salga:

| Si toca… | Haz… |
|---|---|
| **Geografía** (nuevo corte INE) | Playbook 2 (re-correr es idempotente) |
| **Diputados federales** (año electoral) | Playbook 4 con el nuevo xlsx |
| **Gobernador** de un estado | Playbook 3 (edita la fila, re-corre) |
| **Locales/municipales** de un estado | Playbook 5 para ese estado |

Tras actualizar, marca la fecha:
```sql
update public.update_calendar
set last_updated = current_date
where cargo_type = '<...>' and cve_ent = '<...>';
```
Y corre el **Playbook 6** (checks) para validar.

> Regla de oro: cada actualización = un commit en git. Así tienes bitácora de qué
> cambió y cuándo, y puedes revertir.

---

## Referencia de archivos

```
supabase/migrations/   esquema, función, FKs, calendario (Playbook 0)
scripts/import/        load.sh, load_all.sh, transform.sql (Playbooks 1-2)
scripts/representatives/  gobernadores, diputados_federales, plantilla presidentes (3-5)
scripts/checks.sql     health checks (Playbook 6)
scripts/fixtures/      fixture sintético de prueba (no producción)
```
