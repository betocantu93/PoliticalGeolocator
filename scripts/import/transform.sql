-- transform.sql — normaliza staging_* (INE BGD crudo) hacia las tablas finales.
-- Ejecutar:  psql "$SUPABASE_DB_URL" -f scripts/import/transform.sql
--
-- Idempotente (on conflict do update): seguro re-correr y procesar estado por estado.
-- Campos reales del INE BGD (DIC 2025), verificados con ogrinfo:
--   ENTIDAD.shp   : entidad, nombre
--   MUNICIPIO.shp : entidad, municipio, nombre
--   SECCION.shp   : entidad, distrito_f, distrito_l, municipio, seccion, tipo
-- cve_ent/cve_mun se normalizan a TEXT zero-padded.

begin;

-- ===== ESTADO(S) =====
insert into public.states (cve_ent, nom_ent, geom)
select lpad(entidad::text, 2, '0'),
       nombre,
       ST_Multi(ST_MakeValid(geom))::geometry(MultiPolygon, 4326)
from staging_entidad
on conflict (cve_ent) do update
  set nom_ent = excluded.nom_ent, geom = excluded.geom;

-- ===== MUNICIPIOS =====
insert into public.municipalities (cvegeo, cve_ent, nom_mun, geom)
select lpad(entidad::text,2,'0') || lpad(municipio::text,3,'0'),
       lpad(entidad::text,2,'0'),
       nombre,
       ST_Multi(ST_MakeValid(geom))::geometry(MultiPolygon, 4326)
from staging_municipios
on conflict (cvegeo) do update
  set nom_mun = excluded.nom_mun, geom = excluded.geom;

-- ===== SECCIONES (capa atómica; trae distrito federal y local) =====
insert into public.electoral_sections (cve_ent, seccion, distrito_federal, distrito_local, geom)
select lpad(entidad::text,2,'0'),
       seccion::int,
       distrito_f::int,
       distrito_l::int,
       ST_Multi(ST_MakeValid(geom))::geometry(MultiPolygon, 4326)
from staging_secciones
on conflict (cve_ent, seccion) do update
  set distrito_federal = excluded.distrito_federal,
      distrito_local   = excluded.distrito_local,
      geom             = excluded.geom;

analyze public.states, public.municipalities, public.electoral_sections;

commit;

-- Verificación:
--   select count(*) from public.states;
--   select count(*) from public.municipalities;
--   select count(*) from public.electoral_sections;
