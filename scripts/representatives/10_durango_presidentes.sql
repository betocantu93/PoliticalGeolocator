-- 10_durango_presidentes.sql — 39 presidentes municipales (2025-2028).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Durango (2025-2028)". Verificar.

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Canatlán','Dora Elena González Tremillo','PAN'),
  ('Canelas','Verónica Jiménez Zavala','PRI'),
  ('Coneto de Comonfort','Jaime Soto Ochoa','MORENA'),
  ('Cuencamé','Edith Bernarda Orozco Machado','PRI'),
  ('Durango','José Antonio Ochoa Rodríguez','PAN'),
  ('General Simón Bolívar','Silvia Rangel Orona','PRI'),
  ('Gómez Palacio','Betzabé Martínez Arango','MORENA'),
  ('Guadalupe Victoria','J. Carmen Fernández Padilla','PRI'),
  ('Guanaceví','Rogelio Ayala Arzola','PRI'),
  ('Hidalgo','Rocío Ávila Hernández','PRI'),
  ('Indé','Lorena Lucero Bustamante','PRI'),
  ('Lerdo','Susy Carolina Torrecillas Salazar','PRI'),
  ('Mapimí','Maria de los Angeles de Llano Marin','PRI'),
  ('Mezquital','Nicolas Rodriguez Luna','PVEM'),
  ('Nazas','Darío Medina Reyes','PAN'),
  ('Nombre de Dios','Nanci Carolina Vásquez Luna','PAN'),
  ('Nuevo Ideal','Zaira Guadalupe Quiñones Valenzuela','PAN'),
  ('Ocampo','Teresa de Jesús Rosales Reyes','PRI'),
  ('El Oro','Tito Jesús López','PT'),
  ('Otáez','Daniel Guerrero Sarabia','MORENA'),
  ('Pánuco de Coronado','Gaston Armando Briseño Castañeda','PAN'),
  ('Peñón Blanco','Elías Bustamante Hernández','MORENA'),
  ('Poanas','Armando García Meza','PVEM'),
  ('Pueblo Nuevo','Nancy Flores Ornelas','MORENA'),
  ('Rodeo','Jesús Eduardo Estrada Meraz','MC'),
  ('San Bernardo','Manuel Eulogio Rodríguez Aguirre','MORENA'),
  ('San Dimas','José Antonio Villegas Sarabia','PAN'),
  ('San Juan de Guadalupe','María Alejandrina Ramírez Acosta','MORENA'),
  ('San Juan del Río','José Manuel Gallegos Rangel','PRI'),
  ('San Luis del Cordero','Andrés Rubio Castro','MC'),
  ('San Pedro del Gallo','Reginaldo Carrillo Valdez','MORENA'),
  ('Santa Clara','Hermelinda Cruz Rivera','PRI'),
  ('Santiago Papasquiaro','Karen Fernanda Pérez Herrera','MORENA'),
  ('Súchil','Benjamín Páez Pérez','PT'),
  ('Tamazula','Ricardo Ochoa Beltran','MORENA'),
  ('Tepehuanes','José Ramón Sánchez Abdalá','MORENA'),
  ('Tlahualilo','Alfredo Hernández Martínez','MC'),
  ('Topia','Mirna Yuneli Robles Vizcarra','MORENA'),
  ('Vicente Guerrero','César Salas Ortiz','PRI');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '10', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '10'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '10'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo);
