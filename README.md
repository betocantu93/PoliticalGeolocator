# geoelectoral

Servicio mínimo: coordenada `lat/lng` → contexto político de México (estado,
municipio, sección, distrito federal/local, gobernador, presidente municipal,
diputado federal y local). PostGIS + Supabase. Sin IA, sin edge functions.

`resolve_coordinate(lat, lng)` hace 3 point-in-polygon (`ST_Intersects`) contra
estados, municipios y secciones, y une por atributos la tabla manual de
representantes. Los distritos federal/local vienen como **atributo de la sección**,
por eso no hay capas de distrito separadas.

---

## Fuente de datos: INE BGD (una sola descarga)

> **Aprendizaje clave:** NO se necesita INEGI. El **INE BGD – Base Geográfica
> Digital** trae las tres capas que ocupamos (entidad, municipio, sección) en un
> solo paquete por estado, con nombres de municipio incluidos.

- Portal: **INE → Productos Cartográficos → BGD – Base Geográfica Digital**
  (https://www.ine.mx/, sección Cartografía Electoral / SIGE).
- Selecciona **ENTIDAD = <estado>**, **FORMATO = Shapefile**, corte vigente (DIC 2025).
- El ZIP trae decenas de capas; solo usamos **3**: `ENTIDAD.shp`, `MUNICIPIO.shp`,
  `SECCION.shp`. Carpeta típica: `"26 SONORA"`.
- Proyección: cada estado viene en **su propia zona UTM** (Sonora = UTM 12N /
  EPSG:32612). `ogr2ogr -t_srs EPSG:4326` reproyecta solo leyendo el `.prj`.

### ⚠️ Clave de municipio: INE ≠ INEGI

El INE BGD **numera los municipios distinto a INEGI.** Ejemplo: Hermosillo es
`26049` en INE BGD pero `26030` en INEGI. Aplica a **todos** los municipios del país.

- El campo `municipalities.cvegeo` es la **clave del INE BGD** — es la clave canónica
  interna del servicio. Todo (secciones, presidentes municipales) usa esta clave, así
  que `resolve_coordinate` es 100% consistente.
- Por eso los presidentes municipales se cargan por **JOIN de nombre** (no por clave
  hardcodeada): si se hubieran fijado claves INEGI, nada habría macheado.
- Para cruzar con datos de **INEGI** (censo, INPC, etc.) está la columna
  `municipalities.cve_inegi` (migración `0007`), que se llena por match espacial con
  `scripts/import/populate_cve_inegi.sql`. `resolve_coordinate` la expone en
  `municipio.cve_inegi`.

### Nombres de campo reales (verificados con `ogrinfo`)

| Shapefile | Campos que usamos |
|---|---|
| `ENTIDAD.shp` | `entidad`, `nombre` |
| `MUNICIPIO.shp` | `entidad`, `municipio`, `nombre` |
| `SECCION.shp` | `entidad`, `distrito_f`, `distrito_l`, `seccion` |

Si una edición futura cambia nombres, verifica con
`ogrinfo -so -al "/ruta/SECCION.shp"` y ajusta `scripts/import/transform.sql`.

---

## Prerrequisitos

```bash
brew install gdal libpq        # ogr2ogr + psql (carga). Se puede desinstalar después.
```

**Cadena de conexión** (Supabase Dashboard → botón **Connect** → **Session pooler**;
en free tier el pooler es IPv4 y funciona para cargar):

```bash
export SUPABASE_DB_URL="postgresql://postgres.<ref>:<DB_PASSWORD>@aws-0-<region>.pooler.supabase.com:5432/postgres"
```
`<DB_PASSWORD>` = la contraseña de la base que pusiste al crear el proyecto
(Settings → Database → Reset database password si no la tienes).

---

## Paso 0 — Esquema (una sola vez)

Aplica las migraciones (SQL Editor del dashboard, en orden, o `supabase db push`):

```
0001_schema.sql                PostGIS, 4 tablas, índices GIST
0002_resolve_coordinate.sql    función resolve_coordinate(lat,lng)
0003_seed_representatives.sql   gobernadores reales (opcional)
0005_foreign_keys.sql          FKs (opcional; ver más abajo)
```

---

## Paso 1 — Geografía de un estado

```bash
# 1) Sube las 3 capas a staging (UTM -> 4326 automático)
bash scripts/import/load.sh "/Users/me/Downloads/26 SONORA"

# 2) Normaliza staging -> tablas finales (idempotente)
psql "$SUPABASE_DB_URL" -f scripts/import/transform.sql
```

Verifica (SQL Editor):
```sql
select count(*) from public.states;          -- +1 por estado
select count(*) from public.municipalities;  -- p.ej. 72 (Sonora)
select count(*) from public.electoral_sections;
-- Que la geometría quedó en lat/lng (no UTM):
select ST_AsText(ST_PointOnSurface(geom)) from public.municipalities limit 1;  -- POINT(-110.x 29.x)
```

---

## Paso 2 — Representantes (manual, por estado)

No hay fuente nacional limpia; se captura. La tabla `representatives` distingue por
`role` (`governor`, `municipal_president`, `federal_deputy`, `local_deputy`).
**Solo cargos por distrito/territorio** (los plurinominales/RP se omiten: no resuelven
por coordenada).

> 🔁 **Para actualizar tras una elección** (2027+), o para cargar un estado nuevo sin
> teclear a mano, usa el generador y el manual:
> - `scripts/representatives/build_state_reps.py` — pega la tabla (Wikipedia/IEE) → SQL.
> - [UPDATE_GUIDE.md](UPDATE_GUIDE.md) — procedimiento por capa + catálogo de gotchas.
> - `scripts/representatives/apply_all.sh` — aplica toda la capa de representantes de un jalón.
>
> Lo de abajo es la referencia conceptual; el flujo operativo real está en UPDATE_GUIDE.

### 2a. Gobernador (1)
```sql
insert into public.representatives (role, cve_ent, name, party)
values ('governor','26','Francisco Alfonso Durazo Montaño','MORENA');
```

### 2b. Diputados federales (por distrito federal)
Fuente: **Cámara de Diputados** → https://web.diputados.gob.mx/inicio/tusDiputados
(filtra por estado, legislatura vigente). Toma solo los que tienen número de distrito
en "Ditto./Circ." (los de "Na. Circunscripción" son RP → omitir).
```sql
insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('federal_deputy','26',1,'<nombre>','<partido>'), ...;
```

### 2c. Diputados locales (por distrito local)
Fuente: **Congreso del estado** (p.ej. https://congresoson.gob.mx/diputados) o el
anexo de Wikipedia de la legislatura vigente. Mismo formato, `role='local_deputy'`.

### 2d. Presidentes municipales (uno por municipio)
El más voluminoso. Truco para no equivocar claves: carga por **nombre** y haz JOIN
contra tus municipios reales (normalizando acentos). Ver plantilla completa en
[`scripts/representatives/sonora_presidentes_municipales.sql`](scripts/representatives/sonora_presidentes_municipales.sql).

Saber cuántos/cuáles distritos y municipios necesitas (desde tu propia base):
```sql
select distinct distrito_federal from public.electoral_sections order by 1;  -- diputados federales
select distinct distrito_local   from public.electoral_sections order by 1;  -- diputados locales
select cvegeo, nom_mun from public.municipalities order by cvegeo;           -- presidentes
```

Detectar faltantes:
```sql
select m.cvegeo, m.nom_mun
from public.municipalities m
left join public.representatives r
  on r.role='municipal_president' and r.cvegeo_mun = m.cvegeo
where r.id is null order by m.nom_mun;
```

---

## Hacerlo para los 32 estados

1. Descarga las 32 carpetas del INE BGD (una por entidad) en un directorio, p.ej.
   `~/Downloads/bgd/` con carpetas `01 AGUASCALIENTES`, …, `32 ZACATECAS`.
2. Loop de carga (cada estado: overwrite staging → transform upsert):
   ```bash
   for dir in ~/Downloads/bgd/*/; do
     echo "=== $dir ==="
     bash scripts/import/load.sh "$dir"
     psql "$SUPABASE_DB_URL" -f scripts/import/transform.sql
   done
   ```
   `transform.sql` usa `on conflict do update`, así que `public.*` acumula los 32 sin
   duplicar. Al final: `select count(*) from public.states;` → **32**.
3. Representantes: repite el Paso 2 por estado (gobernador, diputados, presidentes).
   Sugerencia: un archivo SQL por estado en `scripts/representatives/<cve>_<estado>.sql`.

> Las claves `entidad`/`municipio` del INE coinciden con las de INEGI, así que
> `cvegeo` es estándar nacional (`<2 dígitos entidad><3 dígitos municipio>`).

---

## Foreign keys (opcional)

Por diseño no había FKs. [`0005_foreign_keys.sql`](supabase/migrations/0005_foreign_keys.sql)
agrega: municipio→estado, sección→estado, representante→estado, presidente→municipio.
`representatives.distrito` no tiene FK (no existe tabla de distritos, es atributo de la
sección). **Prerrequisito:** no debe haber representantes de estados sin geometría cargada:
```sql
delete from public.representatives
where cve_ent not in (select cve_ent from public.states);
```
Con FKs, el orden de carga es estado → municipios → secciones → representantes (el
flujo de arriba ya lo cumple).

---

## Probar

```sql
select public.resolve_coordinate(29.0729, -110.9559);  -- Hermosillo
```
Devuelve JSONB con estado, municipio, sección, distritos y los 4 cargos.

## Mantenimiento

- **Geometría**: recargar cuando el INE publique nuevo corte / redistritación
  (mismo `load.sh` + `transform.sql`, son idempotentes).
- **Representantes**: actualizar por calendario electoral (federal cada 3 años;
  locales/gobernador/municipios según cada estado). Es una tabla "solo-vigente":
  se sobrescribe el ocupante. Si quieres histórico, agrega `valid_from/valid_to`.
