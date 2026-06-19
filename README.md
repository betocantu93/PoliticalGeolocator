# geoelectoral

Servicio mínimo: coordenada `lat/lng` → representantes políticos en México.
PostGIS + Supabase. Sin IA, sin edge functions, sin dependencias.

## Cómo funciona

`resolve_coordinate(lat, lng)` hace 3 point-in-polygon (`ST_Intersects`) contra
estados, municipios y secciones electorales, y une por atributos la tabla manual
de representantes. Los distritos federal/local salen como atributo de la sección,
por eso **no hay capas de distritos**.

## Tablas (4)

| Tabla | Fuente | Para resolver |
|---|---|---|
| `states` | INEGI Marco Geoestadístico | estado |
| `municipalities` | INEGI Marco Geoestadístico | municipio |
| `electoral_sections` | INE Base Geográfica Electoral | sección + distrito federal + distrito local |
| `representatives` | Tabla manual | gobernador, presidente municipal, diputado federal/local |

## Migraciones

```
0001_schema.sql               PostGIS, 4 tablas, índices GIST
0002_resolve_coordinate.sql   función resolve_coordinate(lat,lng)
0003_seed_representatives.sql  gobernadores reales + ejemplos
```

Aplicar: `supabase db push`

## Cargar geometría

Verifica los nombres de campo reales con `ogrinfo -so -al <shp>` (varían por
vintage) y carga a staging; luego normaliza `cve_ent` a TEXT zero-padded.

```bash
PG="PG:host=$PGHOST dbname=postgres user=postgres password=$PGPASSWORD"

# INEGI: entidades y municipios
ogr2ogr -f PostgreSQL "$PG" 00ent.shp -nln staging_estados \
  -nlt PROMOTE_TO_MULTI -t_srs EPSG:4326 -lco GEOMETRY_NAME=geom -overwrite
ogr2ogr -f PostgreSQL "$PG" 00mun.shp -nln staging_municipios \
  -nlt PROMOTE_TO_MULTI -t_srs EPSG:4326 -lco GEOMETRY_NAME=geom -overwrite

# INE: secciones (traen distrito federal y local como atributos)
ogr2ogr -f PostgreSQL "$PG" SECCION.shp -nln staging_secciones \
  -nlt PROMOTE_TO_MULTI -t_srs EPSG:4326 -lco GEOMETRY_NAME=geom -overwrite
```

Transformar staging → tablas finales (ajusta nombres de columna a tu shapefile):

```sql
insert into public.states (cve_ent, nom_ent, geom)
select lpad(cve_ent::text,2,'0'), coalesce(nomgeo,nom_ent),
       ST_Multi(ST_MakeValid(geom))::geometry(MultiPolygon,4326)
from staging_estados;

insert into public.municipalities (cvegeo, cve_ent, nom_mun, geom)
select lpad(cve_ent::text,2,'0')||lpad(cve_mun::text,3,'0'),
       lpad(cve_ent::text,2,'0'), coalesce(nomgeo,nom_mun),
       ST_Multi(ST_MakeValid(geom))::geometry(MultiPolygon,4326)
from staging_municipios;

insert into public.electoral_sections (cve_ent, seccion, distrito_federal, distrito_local, geom)
select lpad(entidad::text,2,'0'), seccion::int, distrito::int, distrito_l::int,
       ST_Multi(ST_MakeValid(geom))::geometry(MultiPolygon,4326)
from staging_secciones;

analyze public.states, public.municipalities, public.electoral_sections;
```

## Uso

```sql
select public.resolve_coordinate(19.4326, -99.1332);
```

```json
{
  "estado": { "cve_ent": "09", "nombre": "Ciudad de México" },
  "municipio": { "cvegeo": "09015", "nombre": "Cuauhtémoc" },
  "seccion": 4567,
  "distrito_federal": 6,
  "distrito_local": 8,
  "gobernador": { "name": "Clara Marina Brugada Molina", "party": "MORENA" },
  "presidente_municipal": { "name": "EJEMPLO — capturar", "party": null },
  "diputado_federal": { "name": "EJEMPLO — capturar", "party": null },
  "diputado_local": { "name": "EJEMPLO — capturar", "party": null }
}
```

## Nota

Los diputados y presidentes municipales del seed son **placeholders**: no existe
fuente nacional limpia ligada a geometría, se capturan a mano. Los gobernadores sí
son datos reales. Si necesitas histórico, agrega `valid_from/valid_to` a
`representatives` (hoy es solo-vigente por simplicidad).
