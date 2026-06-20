-- 28_tamaulipas_presidentes.sql — 43 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Tamaulipas (2024-2027)". Verificar.

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Abasolo','Yazmín Alejandra Saldaña Pérez','PT'),
  ('Aldama','María Noemi Sosa Villarreal','MORENA'),
  ('Altamira','Armando Martínez Manríquez','MORENA'),
  ('Antiguo Morelos','Evangelina Ávila Cabriales','PAN'),
  ('Burgos','Marco Polo Garza Martínez','PAN'),
  ('Bustamante','Maricela Rodríguez González','PAN'),
  ('Camargo','Ernestina Perales Ortiz','PVEM'),
  ('Casas','Jorge Humberto Hinojosa García','PT'),
  ('Ciudad Madero','Erasmo González Robledo','MORENA'),
  ('Cruillas','Diana Vanessa Leal López','PAN'),
  ('Gómez Farías','Frank Yussef de León Ávila','PAN'),
  ('González','Miguel Alejandro Zúñiga Rodríguez','MORENA'),
  ('Güémez','José Lorenzo Morales Amaro','PRI'),
  ('Guerrero','Laura Verónica Peña Martínez','PVEM'),
  ('Gustavo Díaz Ordaz','Nataly García Díaz','PT'),
  ('Hidalgo','Práxedis Guajardo Reyna','MORENA'),
  ('Jaumave','Manuel Báez Martínez','MORENA'),
  ('Jiménez','Corina Esther Garza Arreola','PVEM'),
  ('Llera','Moisés Antonio Borjon Olvera','PAN'),
  ('Mainero','María Dolores Mansilla Huerta','MORENA'),
  ('El Mante','Martha Patricia Chio de la Garza','MORENA'),
  ('Matamoros','José Alberto Granados Favila','MORENA'),
  ('Méndez','Juan Mendoza Fuerte','PAN'),
  ('Mier','Adriana Hinojosa Ibáñez','PVEM'),
  ('Miguel Alemán','Ramiro Cortez Barrera','PAN'),
  ('Miquihuana','Gladis Magalis Vargas Rangel','PAN'),
  ('Nuevo Laredo','Carmen Lilia Canturosas Villareal','MORENA'),
  ('Nuevo Morelos','Yaneth Cristal Najera Cedillo','PAN'),
  ('Ocampo','Melchor Budarth Báez','PAN'),
  ('Padilla','Carlos Ernesto Quintanilla Selvera','MC'),
  ('Palmillas','Sindy Paoleth Monita Ramírez','PT'),
  ('Reynosa','Carlos Víctor Peña Ortiz','MORENA'),
  ('Río Bravo','Miguel Ángel Almaraz Maldonado','PAN'),
  ('San Carlos','Gaudisela Ramírez Zavala','MORENA'),
  ('San Fernando','Verónica Adriana Aguirre de los Santos','MORENA'),
  ('San Nicolás','Analy Becerra Resendez','PRI'),
  ('Soto la Marina','Glynnis Georgina Jiménez Vázquez','PVEM'),
  ('Tampico','Mónica Zacil Villarreal Anaya','MORENA'),
  ('Tula','René Lara Cisneros','MORENA'),
  ('Valle Hermoso','Alberto Enrique Alanis Villarreal','PAN'),
  ('Victoria','Eduardo Abraham Gattás Báez','MORENA'),
  ('Villagrán','María Isabel Ríos Tovar','MORENA'),
  ('Xicoténcatl','Mariela López Sosa','PAN');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '28', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '28'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '28'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo)
order by m.nom_mun;
