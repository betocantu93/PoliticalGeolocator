-- 06_colima_presidentes.sql — 10 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Colima (2024-2027)". Verificar.

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Armería','Cruz Méndez González','MORENA'),
  ('Colima','Riult Rivera Gutiérrez','PAN'),
  ('Comala','Daniela Orozco Pineda','MORENA'),
  ('Coquimatlán','Carlos Antonio Chavira George','PAN'),
  ('Cuauhtémoc','María Guadalupe Solís Ramírez','MORENA'),
  ('Ixtlahuacán','Alexis Rafael Verduzco Mendoza','Nueva Alianza'),
  ('Manzanillo','Rosa María Bayardo Cabrera','MORENA'),
  ('Minatitlán','Cicerón Alejandro Mancilla González','Nueva Alianza'),
  ('Tecomán','Armando Reyna Magaña','MORENA'),
  ('Villa de Álvarez','Esther Gutiérrez Andrade','PAN');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '06', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN'))
   = upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN'))
 and m.cve_ent = '06'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

-- Verificación: municipios de Colima sin presidente (debe salir vacío)
select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '06'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo);
