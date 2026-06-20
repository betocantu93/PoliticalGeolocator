-- 22_queretaro_presidentes.sql — 18 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Querétaro (2024-2027)". Verificar.

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Amealco de Bonfil','Óscar Pérez Martínez','MC'),
  ('Pinal de Amoles','María Guadalupe Ramírez Plaza','PAN'),
  ('Arroyo Seco','Fernando Sánchez Gil','PRI'),
  ('Cadereyta de Montes','Astrid Alejandra Ortega Vázquez','MORENA'),
  ('Colón','Gaspar Ramón Trueba Moncada','MC'),
  ('Corregidora','Josué David Guerrero Trápala','PAN'),
  ('Ezequiel Montes','Iván Resendiz Ramírez','MORENA'),
  ('Huimilpan','Jairo Iván Morales Martínez','PAN'),
  ('Jalpan de Serra','Rubén Hernández Robles','Independiente'),
  ('Landa de Matamoros','Yunuen Araceli Benítez Maldonado','PRI'),
  ('El Marqués','Rodrigo Monsalvo Castelán','PAN'),
  ('Pedro Escobedo','Juan Alberto Nava Cruz','MORENA'),
  ('Peñamiller','Ana Karen Jiménez Guillén','PAN'),
  ('Querétaro','Felipe Fernando Macías Olvera','PAN'),
  ('San Joaquín','Carlos Manuel Ledesma Robles','PVEM'),
  ('San Juan del Río','Roberto Carlos Cabrera Valencia','PAN'),
  ('Tequisquiapan','Héctor Iván Magaña Rentería','MORENA'),
  ('Tolimán','Alejo Sánchez de Santiago','PVEM');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '22', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '22'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '22'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo)
order by m.nom_mun;
