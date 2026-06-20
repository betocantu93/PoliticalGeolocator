-- 27_tabasco_presidentes.sql — 17 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Tabasco (2024-2027)". Verificar.

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Balancán','Beatriz Castañón Félix','MORENA'),
  ('Cárdenas','Euclídes Alejandro Alejandro','MORENA'),
  ('Centla','Saúl Armando Rodríguez Rodríguez','MORENA'),
  ('Centro','Yolanda del Carmen Osuna Huerta','MORENA'),
  ('Comalcalco','Ovidio Salvador Peralta Suárez','MORENA'),
  ('Cunduacán','María de la Cruz López','MORENA'),
  ('Emiliano Zapata','José Armin Marín Saury','MC'),
  ('Huimanguillo','Mariluz Velázquez Jiménez','MORENA'),
  ('Jalapa','José Manuel Hernández Pérez','PT'),
  ('Jalpa de Méndez','José del Carmen Olán Olán','MORENA'),
  ('Jonuta','María Soledad Villamayor Notario','MORENA'),
  ('Macuspana','Gaspar Trinidad Díaz Falcón','MORENA'),
  ('Nacajuca','Roberto Ocaña Leyva','PT'),
  ('Paraíso','Alfonso Jesús Baca Sevilla','MC'),
  ('Tacotalpa','Ricki Antonio Arcos Pérez','MC'),
  ('Teapa','Miguel Ángel Contreras Verdugo','MORENA'),
  ('Tenosique','Sandra Beatriz Hernández Jiménez','PT');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '27', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '27'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '27'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo)
order by m.nom_mun;
