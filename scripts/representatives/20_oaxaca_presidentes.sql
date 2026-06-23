-- 20_oaxaca_presidentes.sql — 152 presidentes municipales POR PARTIDO (2025-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Oaxaca (2025-2027)". Verificar.
-- ⚠️ Oaxaca tiene 570 municipios: estos son los 152 que eligen por PARTIDOS.
--    Los ~418 restantes son por USOS Y COSTUMBRES (Sistema Normativo Indígena) y NO
--    están aquí (sin fuente nacional consolidada). Ver PENDIENTES.md.
-- Partidos locales conservados: Unidad Popular, Partido Mujer, Fuerza por México.

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Acatlán de Pérez Figueroa','María Elvira Maciel Sosa','MORENA'),
  ('Asunción Cuyotepeji','Irene Virgina Vázquez Bravo','Nueva Alianza'),
  ('Asunción Ixtaltepec','Oswaldo Chiñas Cruz','MORENA'),
  ('Asunción Nochixtlán','Alfredo Feliciano López Santiago','MORENA'),
  ('Asunción Ocotlán','Isabel Luis Zárate','PVEM'),
  ('Ayotzintepec','René Luna Ramírez','PRI'),
  ('El Barrio de la Soledad','Roque Ruíz Toscano','MORENA'),
  ('Chahuites','Rossell Castillo Martínez','MORENA'),
  ('Chalcatongo de Hidalgo','Eduardo Nemecio Sánchez Arias','MC'),
  ('Ciénega de Zimatlán','Pawel Celaya Arellanes','Fuerza por México'),
  ('Ciudad Ixtepec','Roberto Carlos Gómez Morales','PT'),
  ('Cosolapa','Rogelio Peña Cruz','MORENA'),
  ('Cuilápam de Guerrero','Mayra Silva Fernández','MORENA'),
  ('Ejutla de Crespo','Carlos Armando Díaz Jiménez','MORENA'),
  ('El Espinal','Esperanza Benítez Arizmendi','MORENA'),
  ('Fresnillo de Trujano','Francisco Lucero Martínez','PVEM'),
  ('Guadalupe de Ramírez','Roberto Ramírez Ramírez','Partido Mujer'),
  ('Huajuapan de León','Luis de León Martínez Sánchez','PAN'),
  ('Huautepec','Nazareth García García','MORENA'),
  ('Huautla de Jiménez','David García Martínez','PRI'),
  ('Juchitán de Zaragoza','Miguel Sánchez Altamirano','MORENA'),
  ('Loma Bonita','Edgar Omar Lara Palma','MORENA'),
  ('Magdalena Ocotlán','Misael Quintín Rosalio Valencia','PVEM'),
  ('Magdalena Tequisistlán','Carlos Hernández Saavedra','MORENA'),
  ('Magdalena Tlacotepec','José Javier Morales Revuelta','Fuerza por México'),
  ('Mariscala de Juárez','Hugo Jairo Hernández Sánchez','PRI'),
  ('Mártires de Tacubaya','José Omar Martínez Salinas','MORENA'),
  ('Matías Romero Avendaño','Edwin Antonio Trinidad','PT'),
  ('Miahuatlán de Porfirio Díaz','Isidro César Figueroa Jiménez','MORENA'),
  ('Oaxaca de Juárez','Raymundo Chagoya Villanueva','MORENA'),
  ('Ocotlán de Morelos','Darío Antonio Meraz Concha','MC'),
  ('Pinotepa de Don Luis','Erika Mejía López','PT'),
  ('Putla Villa de Guerrero','Próspero Francisco Cruz Ricardo','Independiente'),
  ('Reforma de Pineda','Isidoro Geronimo Castellanos','PRI'),
  ('Salina Cruz','Daniel Méndez Sosa','PT'),
  ('San Agustín Amatengo','Italivy Sarahí Juárez Ramírez','PT'),
  ('San Agustín Atenango','Martina López Ávila','MORENA'),
  ('San Andrés Cabecera Nueva','Andrés Lucas Gómez','Fuerza por México'),
  ('San Andrés Dinicuiti','Yessica Ortiz Cruz','MORENA'),
  ('San Andrés Huaxpaltepec','Emilio Liborio Sánchez','PVEM'),
  ('San Andrés Zautla','Marcelino Ángel Félix','PRI'),
  ('San Antonino Castillo Velasco','Mario Hernández','Unidad Popular'),
  ('San Bartolomé Ayautla','Gaudencio Gerardo Campos Caravantes','PT'),
  ('San Blas Atempa','Adalberto Velázquez López','MORENA'),
  ('San Dionisio del Mar','Gregorio Pérez Matus','MORENA'),
  ('San Felipe Jalapa de Díaz','Ángel Terrero Olivera','MC'),
  ('San Felipe Usila','Leonardo Isidro Inocente','PRD'),
  ('San Francisco del Mar','Pedro Coheto Montero','Unidad Popular'),
  ('San Francisco Ixhuatán','Felipe López Matus','MORENA'),
  ('San Francisco Telixtlahuaca','Jaime López Gómez','Unidad Popular'),
  ('San Jacinto Amilpas','Fidel Alejandro Díaz Díaz','PT'),
  ('San Jerónimo Silacayoapilla','Adela Yocelina Cedillo Martínez','PAN'),
  ('San José Chiltepec','Griselda Molina Espinoza','PT'),
  ('San José Estancia Grande','Pedro Ramos Nazario','MC'),
  ('San José Independencia','Raymundo Misael Antonio Gómez','MORENA'),
  ('San José Tenango','Luis Lorenzo Carrera Juárez','MORENA'),
  ('San Juan Bautista Cuicatlán','Juan Hernández Cruz','MORENA'),
  ('San Juan Bautista Lo de Soto','Irasema Leyva Ojeda','MORENA'),
  ('San Juan Bautista Suchitepec','Nancy Adriana Peñaloza Vázquez','Nueva Alianza'),
  ('San Juan Bautista Tlacoatzintepec','Marta Regules Mendoza','MORENA'),
  ('San Juan Bautista Tuxtepec','Fernando Huerta Cerecedo','PT'),
  ('San Juan Cacahuatepec','Martha Elena Baños Tapia','MORENA'),
  ('San Juan Coatzospam','Jorge Campos Juárez','MORENA'),
  ('San Juan Colorado','Nicolás Álavez Nicolás','MORENA'),
  ('San Juan Guichicovi','Erick Rubiel Ramírez Pineda','MORENA'),
  ('San Juan Ihualtepec','Guadalupe Rueda Pomposo','MORENA'),
  ('San Lorenzo','Eduardo Alberto Sarmiento','PVEM'),
  ('San Lucas Ojitlán','Albertico Luna Hernández','PAN'),
  ('San Marcos Arteaga','Leonardo Villanueva Sánchez','Nueva Alianza'),
  ('San Martín Zacatepec','Genaro Balderrama Urrutia','Fuerza por México'),
  ('San Mateo Río Hondo','Eder Alfredo Velázquez Ramírez','MORENA'),
  ('San Miguel Ahuehuetitlán','Macario Bolaños Fuentes','MORENA'),
  ('San Miguel Amatitlán','Joel Ángel Bravo Martínez','PAN'),
  ('Villa Sola de Vega','Albert Carrera Jarquín','MORENA'),
  ('San Miguel Soyaltepec','Vicente Cabrera Castro','PRI'),
  ('San Miguel Tlacamama','Antonio Olmedo Mendoza','PT'),
  ('San Nicolás Hidalgo','Sandra Leticia Ramírez Ponce','PT'),
  ('San Pablo Huitzo','Verónica Maribel Reyes López','MORENA'),
  ('San Pablo Huixtepec','Miguel Ángel Rodríguez Bautista','Fuerza por México'),
  ('San Pablo Villa de Mitla','Esau López Quero','MORENA'),
  ('San Pedro Amuzgos','Rogelio Román Martínez Hernández','MORENA'),
  ('San Pedro Atoyac','Noél Larrea Cruz','PT'),
  ('San Pedro Comitancillo','Alejandro Osorio Solórzano','Fuerza por México'),
  ('San Pedro Huamelula','Daniel Gutiérrez Peña','MC'),
  ('San Pedro Huilotepec','Gabriel Castillo Sarabia','PVEM'),
  ('San Pedro Ixcatlán','Gildardo Vicente Matías','MORENA'),
  ('San Pedro Jicayán','Juan Francisco Alberto González','PRD'),
  ('San Pedro Pochutla','Amado Rodríguez Jijon','MORENA'),
  ('San Pedro Tapanatepec','Adriana Guadalupe Vázquez Cruz','MORENA'),
  ('Villa de Tututepec','Eder Muñoz Peña','PT'),
  ('Villa de Etla','Elías Roberto Mendoza Pérez','MC'),
  ('San Pedro y San Pablo Teposcolula','Adalberto Reyes Ávila','Nueva Alianza'),
  ('San Sebastián Ixcapa','Ricardo Estevez Merino','PVEM'),
  ('Santa Ana Zegache','Guadalupe Elizabeth Martínez León','PT'),
  ('Santa Catarina Juquila','Marco Antonio García Palacios','MORENA'),
  ('Santa Cruz Amilpas','Christian Baruch Castellanos Rodríguez','Independiente'),
  ('Santa Cruz Itundujia','Tomás Lucero Sánchez','PT'),
  ('Santa Cruz Tacache de Mina','Xóchitl Aguirre Méndez','MORENA'),
  ('Santa Cruz Xoxocotlán','Nancy Natalia Benítez Zárate','MORENA'),
  ('Santa Gertrudis','Flor Sumano Mendoza','MORENA'),
  ('Santa Lucía del Camino','Juan Carlos García Márquez','MORENA'),
  ('Heroica Ciudad de Tlaxiaco','Jorge Octavio Hernández Martínez','Fuerza por México'),
  ('Santa María Cortijo','Camilo Ignacio Ávila Ayona','Nueva Alianza'),
  ('Santa María Huatulco','Julio César Cárdenas Ortega','PVEM'),
  ('Santa María Huazolotitlán','Agustina Gómez Torres','MORENA'),
  ('Santa María Ipalapa','Emanuel Peláez Peláez','MORENA'),
  ('Santa María Jacatepec','Clara Itzel Carrillo Roy','PRD'),
  ('Santa María Jalapa del Marqués','Leticia Sibaja Mendoza','MORENA'),
  ('Santa María Mixtequilla','Alfredo Valdez Mendoza','MORENA'),
  ('Santa María Petapa','Teresa de Jesús Martínez García','MORENA'),
  ('Santa María Tecomavaca','Filiberta Narváez Ferrer','MORENA'),
  ('Santa María Teopoxco','Carlos Quevedo Fabián','PRI'),
  ('Santa María Texcatitlán','Alicia Cruz Hernández','MORENA'),
  ('Santa María Tonameca','César Ruíz Gutiérrez','PAN'),
  ('Santa María Xadani','José Jiménez Luis','PVEM'),
  ('Santa María Zacatepec','Rosa María Ramos Baños','PRI'),
  ('Santiago Ayuquililla','José Armando Romero Escobedo','Nueva Alianza'),
  ('Santiago Cacaloxtepec','Sonoa Patricia Aparicio Mendoza','MORENA'),
  ('Santiago Chazumba','Gabriela Pérez Morales','MORENA'),
  ('Santiago Huajolotitlán','José Guadalupe Barbosa Barragán','Fuerza por México'),
  ('Santiago Jamiltepec','Auberto Ramos Acevedo','PVEM'),
  ('Santiago Juxtlahuaca','Arsenio Lorenzo Mejía García','MORENA'),
  ('Santiago Laollaga','Basilio Manuel Guzmán','MORENA'),
  ('Santiago Llano Grande','Xóchitl Cruz Arellanes','MORENA'),
  ('Santiago Niltepec','Shen-Yu Chiu Meza','PVEM'),
  ('Santiago Pinotepa Nacional','Héctor Domingo Baños Toscano','PRD'),
  ('Santiago Suchilquitongo','Laura Isabel Román Figueroa','MORENA'),
  ('Santiago Tamazola','Elsa Méndez Ayala','MORENA'),
  ('Santiago Tapextla','Juan Verónica Silva','PT'),
  ('Villa Tejúpam de la Unión','Felipe Filogonio Montes Rojas','MORENA'),
  ('Santiago Tetepec','Obed Cruz Torres','MORENA'),
  ('Santo Domingo Ingenio','Raúl Ríos Carballo','MC'),
  ('Santo Domingo Armenta','Yonis Atenogenes Bolaños Bustos','PRI'),
  ('Santo Domingo Chihuitán','Helberg Rueda López','PVEM'),
  ('Santo Domingo Petapa','Crista Luz Jiménez Gaspar','MORENA'),
  ('Santo Domingo Tehuantepec','Ana Cecilia Pérez Velázquez','MORENA'),
  ('Santo Domingo Tonalá','Alí Martínez Martínez','PRI'),
  ('Santo Domingo Zanatepec','Aurora Terroso Ramos','MORENA'),
  ('Silacayoápam','Karina Vargas Nava','MORENA'),
  ('Soledad Etla','José Antonio Reyes Cruz','Nueva Alianza'),
  ('Villa de Tamazulapam del Progreso','Juan Isidoro Guerrero Ramírez','Fuerza por México'),
  ('Teotitlán de Flores Magón','Genaro Leonardo Sosa Sánchez','MORENA'),
  ('Tezoatlán de Segura y Luna','Tarcila Irma Celis Montesinos','PT'),
  ('Tlacolula de Matamoros','René Óscar Sánchez Chagoya','PT'),
  ('Trinidad Zaachila','Saydy Vinisa Ambrosio Vicente','MORENA'),
  ('Unión Hidalgo','José Carlos López Alonso','PT'),
  ('Valerio Trujano','Dante Roberto Miranda Morales','Unidad Popular'),
  ('San Juan Bautista Valle Nacional','Elso Pérez Sánchez','Nueva Alianza'),
  ('Villa de Zaachila','Ernesto Vargas López','MC'),
  ('Zapotitlán Lagunas','(Ayuntamiento vacante)', null),
  ('Zimatlán de Álvarez','Javier César Barroso Sánchez','PVEM');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '20', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '20'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

-- 5 que el INE escribe con prefijo oficial largo ("Heroica Ciudad de...", etc.), por cvegeo:
insert into public.representatives (role, cve_ent, cvegeo_mun, name, party) values
  ('municipal_president','20','20028','Carlos Armando Díaz Jiménez','MORENA'),   -- Ejutla de Crespo
  ('municipal_president','20','20037','Luis de León Martínez Sánchez','PAN'),    -- Huajuapan de León
  ('municipal_president','20','20043','Miguel Sánchez Altamirano','MORENA'),     -- Juchitán de Zaragoza
  ('municipal_president','20','20121','Adalberto Velázquez López','MORENA'),     -- San Blas Atempa
  ('municipal_president','20','20549','Tarcila Irma Celis Montesinos','PT')      -- Tezoatlán de Segura y Luna
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

-- Cuántos macheamos de los 152 (el resto son nombres que el INE escribe distinto).
select count(*) as cargados_de_152
from public.representatives where role='municipal_president' and cve_ent='20';

-- Los de la lista que NO machearon por nombre (para cerrarlos por cvegeo):
select t.nom
from tmp_pm t
left join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '20'
where m.cvegeo is null;
