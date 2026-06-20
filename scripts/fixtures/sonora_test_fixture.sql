-- 0004_seed_sonora_fixture.sql
-- FIXTURE DE PRUEBA para Sonora (cve_ent '26').
-- ⚠️ La geometría son RECTÁNGULOS sintéticos que contienen Hermosillo, NO fronteras
--    reales del INEGI/INE. Sirve para validar resolve_coordinate end-to-end sin
--    descargar shapefiles. BORRAR antes de cargar datos reales (ver pie del archivo).

-- ---- Estado: Sonora (envelope aprox. del estado) ----
insert into public.states (cve_ent, nom_ent, geom) values
  ('26', 'Sonora',
   ST_Multi(ST_MakeEnvelope(-115.0, 26.0, -108.4, 32.5, 4326))::geometry(MultiPolygon,4326))
on conflict (cve_ent) do nothing;

-- ---- Municipio: Hermosillo (envelope alrededor del municipio) ----
insert into public.municipalities (cvegeo, cve_ent, nom_mun, geom) values
  ('26030', '26', 'Hermosillo',
   ST_Multi(ST_MakeEnvelope(-111.6, 28.5, -110.3, 29.6, 4326))::geometry(MultiPolygon,4326))
on conflict (cvegeo) do nothing;

-- ---- Sección electoral en Hermosillo centro ----
-- distrito_federal / distrito_local son ILUSTRATIVOS (ajustar con datos reales del INE).
insert into public.electoral_sections (cve_ent, seccion, distrito_federal, distrito_local, geom) values
  ('26', 1000, 4, 13,
   ST_Multi(ST_MakeEnvelope(-111.05, 29.00, -110.85, 29.15, 4326))::geometry(MultiPolygon,4326))
on conflict (cve_ent, seccion) do nothing;

-- ---- Representantes de Sonora ----
-- Gobernador y presidente municipal: datos REALES (vigentes jun-2026).
-- Diputados: EJEMPLO, con distrito que coincide con la sección de arriba.
insert into public.representatives (role, cve_ent, cvegeo_mun, distrito, name, party) values
  ('governor',            '26', null,    null, 'Francisco Alfonso Durazo Montaño',   'MORENA'),
  ('municipal_president', '26', '26030', null, 'Antonio Francisco Astiazarán Gutiérrez', 'PRI'),
  ('federal_deputy',      '26', null,    4,    'EJEMPLO — capturar', null),
  ('local_deputy',        '26', null,    13,   'EJEMPLO — capturar', null)
on conflict do nothing;

-- ===========================================================================
-- Para revertir el fixture antes de cargar datos reales:
--   delete from public.representatives where cve_ent = '26';
--   delete from public.electoral_sections where cve_ent = '26';
--   delete from public.municipalities where cve_ent = '26';
--   delete from public.states where cve_ent = '26';
-- ===========================================================================
