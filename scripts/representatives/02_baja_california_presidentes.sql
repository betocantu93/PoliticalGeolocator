-- 02_baja_california_presidentes.sql — 7 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Baja California (2024-2027)". Verificar.

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Ensenada','Claudia Josefina Agatón Muñiz','MORENA'),
  ('Mexicali','Norma Alicia Bustamante Martínez','MORENA'),
  ('Playas de Rosarito','María del Rocío Adame Muñoz','MORENA'),
  ('San Felipe','José Luis Dagnino López','MORENA'),
  ('San Quintín','Miriam Elizabeth Cano Núñez','MORENA'),
  ('Tecate','Román Cota Muñoz','MORENA'),
  ('Tijuana','Ismael Burgueño Ruiz','MORENA');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '02', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN'))
   = upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN'))
 and m.cve_ent = '02'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

-- Verificación: municipios de BC sin presidente (revisar si "Playas de Rosarito" machea)
select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '02'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo);
