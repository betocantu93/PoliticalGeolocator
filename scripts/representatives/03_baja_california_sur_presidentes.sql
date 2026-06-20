-- 03_baja_california_sur_presidentes.sql — 5 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Baja California Sur (2024-2027)". Verificar.

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Comondú','Roberto Pantoja Castro','MORENA'),
  ('Mulegé','Edith Aguilar Villavicencio','PAN'),
  ('La Paz','Milena Paola Quiroga Romero','MORENA'),
  ('Loreto','Paz del Alma Ochoa Amador','MORENA'),
  ('Los Cabos','Christian Agúndez Gómez','PT');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '03', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN'))
   = upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN'))
 and m.cve_ent = '03'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

-- Verificación: municipios de BCS sin presidente (debe salir vacío)
select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '03'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo);
