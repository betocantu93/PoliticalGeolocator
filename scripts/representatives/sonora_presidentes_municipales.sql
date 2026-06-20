-- sonora_presidentes_municipales.sql
-- Presidentes municipales de Sonora 2024-2027 (72 municipios).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Sonora (2024-2027)".
--   -> VERIFICAR contra fuentes oficiales antes de producción.
-- Estrategia: carga por NOMBRE a una temp y JOIN contra public.municipalities
-- (normalizando acentos/mayúsculas) para obtener el cvegeo real de tu base.

begin;

-- sin "on commit drop": la temp sobrevive al commit para poder verificar abajo
create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Aconchi','Judith Reyna del Carmen Icedo Quijada','MORENA'),
  ('Agua Prieta','José Manuel Quijada Lamadrid','MORENA'),
  ('Álamos','Samuel Borbón Lara','PVEM'),
  ('Altar','Luis Ángel Valenzuela Mendivil','MORENA'),
  ('Arivechi','Francisco Flores Robles','PT'),
  ('Arizpe','Dulce Griselda Alvarado Morales','PAN'),
  ('Átil','Juan Francisco Calderón Méndez','Partido Sonorense'),
  ('Bacadéhuachi','Luis Alfonso Sierra Villaescusa','PT'),
  ('Bacanora','Nora Alicia Biebrich Duarte','PT'),
  ('Bacerac','Virgen Ignacia López Valenzuela','MORENA'),
  ('Bacoachi','Daniela María Gallego Gálvez','PVEM'),
  ('Bácum','Serge Enríquez Tolano','PT'),
  ('Banámichi','Edna Patricia Serrano Peña','Nueva Alianza'),
  ('Baviácora','Jesús Francisco Martín Miranda Villa','PAN'),
  ('Bavispe','Conrado Durazo Montaño','MORENA'),
  ('Benito Juárez','Edna Sofía Rascón Luzanilla','MORENA'),
  ('Benjamín Hill','Yessica Yuridia Barraza Celaya','PT'),
  ('Caborca','Abraham David Mier Nogales','MORENA'),
  ('Cajeme','Carlos Javier Lamarque Cano','MORENA'),
  ('Cananea','Carmen Esmeralda González Tapia','PVEM'),
  ('Carbó','Sylvia Lenika Placencia Leal','PT'),
  ('La Colorada','Fernando Vidal Encinas','PRI'),
  ('Cucurpe','Edgar Aarón Palomino Ayon','MORENA'),
  ('Cumpas','Jesús Alberto Ojeda Castellanos','PRI'),
  ('Divisaderos','Claudio Peralta Gracia','MORENA'),
  ('Empalme','Luis Fuentes Aguilar','PVEM'),
  ('Etchojoa','Luis Arturo Robles Higuera','MORENA'),
  ('Fronteras','Israel Quijada Hernández','Movimiento Ciudadano'),
  ('General Plutarco Elías Calles','Uriel López Ríos','Partido Sonorense'),
  ('Granados','José Vinicio Durazo Durazo','Movimiento Ciudadano'),
  ('Guaymas','Karla Córdova González','MORENA'),
  ('Hermosillo','Antonio Francisco Astiazarán Gutiérrez','PAN'),
  ('Huachinera','Samuel Dávila Ballesteros','Partido Sonorense'),
  ('Huásabas','Jesús Alberto Urquijo Ramírez','Nueva Alianza'),
  ('Huatabampo','Alberto Vázquez Valencia','PT'),
  ('Huépac','Gloria Rita Contreras López','Nueva Alianza'),
  ('Ímuris','Jesús Leonardo García Acedo','PRI'),
  ('Magdalena','Francisco Arturo Duarte Valdez','PAN'),
  ('Mazatán','Leobardo Paco Olguin','PT'),
  ('Moctezuma','Francisco Arnaldo Monge Araiza','Independiente'),
  ('Naco','José Lorenzo Villegas Vázquez','PAN'),
  ('Nácori Chico','Guillermo Amaya Córdova','MORENA'),
  ('Nacozari de García','Pedro Morghen Rivera','Independiente'),
  ('Navojoa','Jorge Alberto Elías Retes','MORENA'),
  ('Nogales','Juan Francisco Gim Nogales','Nueva Alianza'),
  ('Ónavas','Verónica Valenzuela Áviles','Movimiento Ciudadano'),
  ('Opodepe','Lorenzo Favian Santa María Brockman','PT'),
  ('Oquitoa','Samuel Chaira Federico','Partido Sonorense'),
  ('Pitiquito','Janeth García Mazon','MORENA'),
  ('Puerto Peñasco','Óscar Eduardo Castro Castro','MORENA'),
  ('Quiriego','Fredi Renato Flores Campos','Partido Sonorense'),
  ('Rayón','Alejandro Luis Grijalva Robles','PRI'),
  ('Rosario','Gerardo Mendivil Valenzuela','PVEM'),
  ('Sahuaripa','Luis Carlos Galindo Duarte','PRI'),
  ('San Felipe de Jesús','Jesús Alberto Ballesteros Quiroga','Movimiento Ciudadano'),
  ('San Javier','José Alberto Alday Ayala','PRI'),
  ('San Ignacio Río Muerto','Abel González Ambriz','PT'),
  ('San Luis Río Colorado','César Iván Sandoval Gamez','MORENA'),
  ('San Miguel de Horcasitas','Germán Gerardo Ochoa Esparza','PRI'),
  ('San Pedro de la Cueva','Alejandro Lameda Andrade','Partido Sonorense'),
  ('Santa Ana','Javier Francisco Moreno Dávila','PRI'),
  ('Santa Cruz','Alma Guadalupe Tellez Salomón','Movimiento Ciudadano'),
  ('Sáric','Edgardo Valenzuela Quiróz','MORENA'),
  ('Soyopa','Paulette Encinas Miranda','Movimiento Ciudadano'),
  ('Suaqui Grande','Gildardo Olivarria Ruiz','PAN'),
  ('Tepache','Juan Carlos Moreno Moreno','MORENA'),
  ('Trincheras','Rafael Murrieta Mata','Encuentro Solidario'),
  ('Tubutama','Irabien Núñez Montoya','Partido Sonorense'),
  ('Ures','Héctor Gastón Rodríguez Galindo','PRD'),
  ('Villa Hidalgo','Francisco Javier Campa Durazo','Movimiento Ciudadano'),
  ('Villa Pesqueira','Francisca Icela Córdova Gálvez','PVEM'),
  ('Yécora','Diana Zuleth Ruiz Acuña','MORENA');

-- Inserta haciendo match por nombre normalizado (sin acentos, mayúsculas, trim)
insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '26', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN'))
   = upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN'))
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

-- ===== Verificación: ¿qué no macheó? =====
-- (a) Nombres de la lista que NO encontraron municipio en tu base:
select t.nom as no_macheo
from tmp_pm t
left join public.municipalities m
  on upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN'))
   = upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN'))
where m.cvegeo is null;
-- (la temp ya no se borra al commit, así que este SELECT corre bien al final del run)

-- (b) Municipios SIN presidente asignado (lo inverso, siempre disponible):
-- select m.cvegeo, m.nom_mun
-- from public.municipalities m
-- left join public.representatives r
--   on r.role = 'municipal_president' and r.cvegeo_mun = m.cvegeo
-- where r.id is null
-- order by m.nom_mun;
