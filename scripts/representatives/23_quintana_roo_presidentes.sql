-- 23_quintana_roo_presidentes.sql — 11 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Quintana Roo (2024-2027)". Verificar.

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Cozumel','José Luis Chacon Méndez','MORENA'),
  ('Felipe Carrillo Puerto','María del Carmen Candelaria Hernández Solís','MORENA'),
  ('Isla Mujeres','Teresa Atenea Gómez Ricalde','MORENA'),
  ('Othón P. Blanco','Yensunni Idalia Martínez Hernández','MORENA'),
  ('Benito Juárez','Ana Patricia Peralta de la Peña','MORENA'),
  ('José María Morelos','Erik Noé Borges Yam','MORENA'),
  ('Lázaro Cárdenas','Josue Nivardo Mena Villanueva','PT'),
  ('Solidaridad','Angy Estefanía Mercado Asencio','MORENA'),
  ('Tulum','Diego Castañón Trejo','MORENA'),
  ('Bacalar','José Alfredo Contreras Méndez','MORENA'),
  ('Puerto Morelos','Blanca Merari Tziu Muñoz','PVEM');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '23', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '23'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '23'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo)
order by m.nom_mun;
