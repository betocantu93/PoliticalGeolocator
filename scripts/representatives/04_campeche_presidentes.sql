-- 04_campeche_presidentes.sql — 13 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Campeche (2024-2027)". Verificar.

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Calkiní','Milton Ulises Millán Atoche','MC'),
  ('Campeche','Bibi Karen Rabelo de la Torre','MC'),
  ('Carmen','Pablo Gutiérrez Lázarus','MORENA'),
  ('Champotón','Claudeth Sarricolea Castillejo','MORENA'),
  ('Hecelchakán','José Cevastián Yam Poot','MC'),
  ('Hopelchén','Hiram Aranda Calderón','PRI'),
  ('Palizada','Pedro Javier Ayala Cámara','PT'),
  ('Tenabo','Mariela Sánchez Espinoza','PVEM'),
  ('Escárcega','Juan Carlos Hernández Rath','MORENA'),
  ('Calakmul','Guadalupe Acevedo Rodríguez','PT'),
  ('Candelaria','Jaime Muñóz Morfín','MORENA'),
  ('Dzitbalché','Luis Antonio Chan Puc','MC'),
  ('Seybaplaya','Magdalena del Socorro Jiménez Pacheco','PT');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '04', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN'))
   = upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN'))
 and m.cve_ent = '04'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

-- Verificación: municipios de Campeche sin presidente (debe salir vacío)
select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '04'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo);
