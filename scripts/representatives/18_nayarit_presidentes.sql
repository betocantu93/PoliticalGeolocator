-- 18_nayarit_presidentes.sql — 20 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Nayarit (2024-2027)". Verificar.
-- MLN = Movimiento de Liberación Nacional (partido local).

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Acaponeta','Manuel Ramón Salcedo Osuna','MORENA'),
  ('Ahuacatlán','Manuel Ángel Andalon Aguilar','MORENA'),
  ('Amatlán de Cañas','Azucena Becerra Vázquez','MC'),
  ('Compostela','Gustavo Alfonso Ayon Aguirre','MORENA'),
  ('Huajicori','Sergio Rangel Cervantes','MORENA'),
  ('Ixtlán del Río','José Guillermo Ramírez Jiménez','PT'),
  ('Jala','Marco Antonio Cambero Gómez','PAN'),
  ('Xalisco','Anabel Margarita Guerrero Benítez','MORENA'),
  ('Del Nayar','Imelda Escobedo López','PVEM'),
  ('Rosamorada','José Ampelio Gutiérrez García','PRI'),
  ('Ruiz','Adolfo Betancourt Salas','MLN'),
  ('San Blas','José Antonio Barajas López','PAN'),
  ('San Pedro Lagunillas','Xochitl Carmina Velazco Hernández','MORENA'),
  ('Santa María del Oro','Rodrigo Polanco Sojo','MORENA'),
  ('Santiago Ixcuintla','Sergio González García','MORENA'),
  ('Tecuala','Nora Lilia Burgara Alarcón','PVEM'),
  ('Tepic','Geraldine Ponce Méndez','MORENA'),
  ('Tuxpan','Gabriel Correa Alvarado','PVEM'),
  ('La Yesca','Rosa Elena Reyes Jiménez','MORENA'),
  ('Bahía de Banderas','Héctor Javier Santana García','MORENA');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '18', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '18'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '18'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo)
order by m.nom_mun;
