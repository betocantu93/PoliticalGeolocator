-- 0003_seed_representatives.sql
-- Gobernadores: datos reales vigentes (jun-2026). Opcional.
-- OJO: si vas a aplicar las FKs (0005), solo siembra estados cuya geometría ya
-- cargaste, o aplica las FKs después y limpia colgados (ver README / 0005).
-- Los demás cargos (diputados, presidentes) se capturan por estado — ver README Paso 2.

insert into public.representatives (role, cve_ent, name, party) values
  ('governor', '26', 'Francisco Alfonso Durazo Montaño', 'MORENA'),
  ('governor', '09', 'Clara Marina Brugada Molina',       'MORENA'),
  ('governor', '15', 'Delfina Gómez Álvarez',             'MORENA'),
  ('governor', '14', 'Pablo Lemus Navarro',               'MC'),
  ('governor', '19', 'Samuel Alejandro García Sepúlveda', 'MC'),
  ('governor', '11', 'Libia Dennise García Muñoz Ledo',   'PAN')
on conflict do nothing;
