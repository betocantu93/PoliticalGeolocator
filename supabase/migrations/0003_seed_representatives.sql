-- 0003_seed_representatives.sql
-- Seed mínimo. Gobernadores: datos reales vigentes (jun-2026).
-- Diputados y presidente municipal: filas de EJEMPLO (no hay fuente nacional
-- limpia ligada a geometría; reemplazar con captura manual real).

-- Gobernadores reales
insert into public.representatives (role, cve_ent, name, party) values
  ('governor', '09', 'Clara Marina Brugada Molina',       'MORENA'),
  ('governor', '15', 'Delfina Gómez Álvarez',             'MORENA'),
  ('governor', '14', 'Pablo Lemus Navarro',               'MC'),
  ('governor', '19', 'Samuel Alejandro García Sepúlveda', 'MC'),
  ('governor', '11', 'Libia Dennise García Muñoz Ledo',   'PAN');

-- Ejemplos (reemplazar)
insert into public.representatives (role, cve_ent, cvegeo_mun, distrito, name, party) values
  ('municipal_president', '09', '09015', null, 'EJEMPLO — capturar', null),
  ('federal_deputy',      '09', null,    1,    'EJEMPLO — capturar', null),
  ('local_deputy',        '09', null,    1,    'EJEMPLO — capturar', null);
