-- checks.sql — verificación de salud de los datos. Corre esto tras cada carga.
-- Pégalo en el SQL Editor de Supabase. Todo lo que salga en "PROBLEMA" hay que revisar.

-- 1) Conteos generales (cobertura)
select 'estados'      as capa, count(*) as filas from public.states
union all select 'municipios',         count(*) from public.municipalities
union all select 'secciones',          count(*) from public.electoral_sections
union all select 'gobernadores',       count(*) from public.representatives where role='governor'
union all select 'dip_federales',      count(*) from public.representatives where role='federal_deputy'
union all select 'dip_locales',        count(*) from public.representatives where role='local_deputy'
union all select 'pres_municipales',   count(*) from public.representatives where role='municipal_president';

-- 2) ¿Cuántos estados cubre cada capa? (debería tender a 32)
select 'secciones'        as capa, count(distinct cve_ent) as estados from public.electoral_sections
union all select 'municipios',     count(distinct cve_ent) from public.municipalities
union all select 'gobernadores',   count(distinct cve_ent) from public.representatives where role='governor';

-- 3) PROBLEMA: geometría en UTM en vez de lat/lng (debe ser POINT(-1xx.x xx.x))
select 'states' as t, ST_AsText(ST_PointOnSurface(geom)) muestra from public.states limit 1;

-- 4) PROBLEMA: secciones sin distrito (no podrán resolver diputado)
select count(*) as secciones_sin_distrito
from public.electoral_sections
where distrito_federal is null or distrito_local is null;

-- 5) PROBLEMA: representantes huérfanos (cve_ent sin estado cargado)
select r.role, r.cve_ent, count(*) as filas
from public.representatives r
left join public.states s on s.cve_ent = r.cve_ent
where s.cve_ent is null
group by r.role, r.cve_ent;

-- 6) PROBLEMA: municipios sin presidente asignado (cobertura de presidentes)
select cve_ent, count(*) as municipios_sin_presidente
from public.municipalities m
where not exists (
  select 1 from public.representatives r
  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo)
group by cve_ent order by cve_ent;

-- 7) Smoke test de la función (centro de Hermosillo)
select public.resolve_coordinate(29.0729, -110.9559);
