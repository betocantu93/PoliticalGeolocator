-- populate_cve_inegi.sql — llena municipalities.cve_inegi con la clave INEGI,
-- por MATCH ESPACIAL contra el Marco Geoestadístico de INEGI (no por nombre, así
-- evita los problemas de DR./GRAL./acentos).
--
-- PASO 1 (Terminal) — descarga el INEGI Marco Geoestadístico (capa de municipios
-- nacional: 00mun.shp) y cárgalo a staging. Verifica campos con ogrinfo; suelen ser
-- CVEGEO (5 díg INEGI), CVE_ENT, CVE_MUN, NOMGEO.
--
--   ogr2ogr -f PostgreSQL "PG:${SUPABASE_DB_URL}" \
--     "/ruta/inegi/00mun.shp" -nln staging_inegi_mun \
--     -nlt PROMOTE_TO_MULTI -t_srs EPSG:4326 -lco GEOMETRY_NAME=geom -overwrite -progress
--
-- PASO 2 (SQL Editor / psql) — corre este archivo.

begin;

-- Reset (por si ya se corrió la versión ingenua antes).
update public.municipalities set cve_inegi = null;

-- Match: entre los municipios INEGI que traslapan, PREFIERE el del mismo nombre
-- (normalizado), y usa el área de traslape como desempate. Esto evita que dos
-- municipios INE chicos se "roben" el mismo código INEGI del vecino.
with cand as (
  select m.cvegeo as ine_cvegeo,
         s.cvegeo as inegi_cvegeo,
         ST_Area(ST_Intersection(m.geom, s.geom)) as overlap,
         (replace(upper(translate(m.nom_mun, 'áéíóúüÁÉÍÓÚÜñÑ','aeiouuAEIOUUnN')),' ','')
          = replace(upper(translate(s.nomgeo,  'áéíóúüÁÉÍÓÚÜñÑ','aeiouuAEIOUUnN')),' ','')) as name_match
  from public.municipalities m
  join staging_inegi_mun s on s.geom && m.geom
),
best as (
  select distinct on (ine_cvegeo) ine_cvegeo, inegi_cvegeo
  from cand
  order by ine_cvegeo, name_match desc, overlap desc   -- 1º nombre igual, 2º mayor área
)
update public.municipalities m
set cve_inegi = b.inegi_cvegeo
from best b
where m.cvegeo = b.ine_cvegeo;

commit;

-- ===== Verificación =====
-- (a) Cobertura: ¿cuántos municipios quedaron con cve_inegi? (meta: todos)
select count(*) filter (where cve_inegi is not null) as con_inegi,
       count(*) filter (where cve_inegi is null)     as sin_inegi,
       count(*) as total
from public.municipalities;

-- (b) Los que no machearon (revisar a mano; suelen ser islas o bordes raros)
select cve_ent, cvegeo, nom_mun
from public.municipalities
where cve_inegi is null
order by cve_ent, cvegeo;

-- (c) Sanity: que no haya cve_inegi duplicado dentro de un estado
select cve_ent, cve_inegi, count(*)
from public.municipalities
where cve_inegi is not null
group by cve_ent, cve_inegi having count(*) > 1;

-- Ejemplo esperado tras poblar: Hermosillo -> cvegeo INE 26049, cve_inegi 26030.
-- select cvegeo, cve_inegi, nom_mun from public.municipalities where nom_mun ilike 'HERMOSILLO%';
