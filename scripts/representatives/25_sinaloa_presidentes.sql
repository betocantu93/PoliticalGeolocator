-- 25_sinaloa_presidentes.sql — 20 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Sinaloa (2024-2027)". Verificar.
-- Ahome y Culiacán: titulares vigentes (2025/2026). Partido Sinaloense (PAS) local.

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Ahome','Antonio Menéndez del Llano','MORENA'),
  ('Angostura','Alberto Rivera Camacho','Partido Sinaloense'),
  ('Badiraguato','José Paz López Elenes','MORENA'),
  ('Concordia','Óscar Zamudio Pérez','MORENA'),
  ('Cosalá','Carla Úrsula Corrales Corrales','MORENA'),
  ('Culiacán','Ana Miriam Ramos Villarreal','MORENA'),
  ('Choix','Yoneida Vázquez Gámez','PAN'),
  ('Elota','Richard Millán Vázquez','MC'),
  ('Escuinapa','Víctor Manuel Díaz Simental','PT'),
  ('El Fuerte','Gildardo Leyva Ortega','MORENA'),
  ('Guasave','Cecilia Ramírez Montoya','MORENA'),
  ('Mazatlán','Estrella Palacios Domínguez','MORENA'),
  ('Mocorito','Enrique Parra Melecio','MORENA'),
  ('Rosario','Claudia Liliana Valdez Aguilar','MORENA'),
  ('Salvador Alvarado','Guadalupe López González','MORENA'),
  ('San Ignacio','Luis Fernando Loaiza Bañuelos','MORENA'),
  ('Sinaloa','Rolando X. Mercado','MORENA'),
  ('Navolato','Jorge Rosario Bojórquez Berrelleza','PRI'),
  ('Eldorado','Faustino Torres Núñez','MORENA'),
  ('Juan José Ríos','Evangelina Llanes Carreón','MORENA');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '25', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '25'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '25'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo)
order by m.nom_mun;
