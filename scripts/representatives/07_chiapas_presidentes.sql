-- 07_chiapas_presidentes.sql — 124 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Chiapas (2024-2027)". Verificar.
-- Casos especiales resueltos al titular VIGENTE (desde 2025):
--   Bella Vista, Frontera Comalapa, Pantelhó.
-- Oxchuc se rige por usos y costumbres (party = null).
-- Partidos locales se conservan: Partido Chiapas Unido, Mover a Chiapas, RSP.

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Acacoyagua','José Antonio Meza','Partido Chiapas Unido'),
  ('Acala','María Patricia Coello Zapata','MORENA'),
  ('Acapetahua','César Martínez Antonio','MORENA'),
  ('Altamirano','Gaspar Santiz Jiménez','PT'),
  ('Amatán','Majin Aguilar Utrilla','RSP'),
  ('Amatenango de la Frontera','Ernesto Teodomiro Osorio Escobar','PVEM'),
  ('Amatenango del Valle','Julieta Gómez Jiménez','MORENA'),
  ('Ángel Albino Corzo','Manuel de Jesús Moreno Fernández','PVEM'),
  ('Arriaga','Alejandro Aquiles Patrinos Fernández','PVEM'),
  ('Bejucal de Ocampo','Onécimo Esaú Santizo Robledo','PES'),
  ('Bella Vista','Annette Aylin Velázquez Zunún','Partido Chiapas Unido'),
  ('Berriozábal','Jorge Arturo Acero Gómez','MORENA'),
  ('Bochil','Sergio Luis Zenteno Meneses','MORENA'),
  ('El Bosque','José Napoleón Gómez Gómez','Mover a Chiapas'),
  ('Cacahoatán','Víctor Alonso Pérez Saldaña','PVEM'),
  ('Catazajá','José Luis Damas Ortiz','PVEM'),
  ('Cintalapa','Ernesto Cruz Díaz','MORENA'),
  ('Coapilla','Yadira Pérez Pérez','MORENA'),
  ('Comitán de Domínguez','Mario Antonio Guillén Domínguez','PT'),
  ('La Concordia','Emanuel de Jesús Cordova García','RSP'),
  ('Copainalá','Carlos Cruz Cruz','MORENA'),
  ('Chalchihuitán','Manuel García Núñez','PT'),
  ('Chamula','Pascual Sánchez Gómez','PT'),
  ('Chanal','Alejandro Gómez Entzin','RSP'),
  ('Chapultenango','Amancio Federico Lucas Hernández','PVEM'),
  ('Chenalhó','Alberto López González','PRI'),
  ('Chiapa de Corzo','Limbano Domínguez Román','PVEM'),
  ('Chiapilla','Bersaín Gómez Gómez','RSP'),
  ('Chicoasén','Bersaín Gutiérrez González','Mover a Chiapas'),
  ('Chicomuselo','Lizandro Borrallas Verdugo','PT'),
  ('Chilón','Mario Hernández Aguilar','PT'),
  ('Escuintla','Carlos González Moreno','MORENA'),
  ('Francisco León','Arcides Sánchez Ramírez','PT'),
  ('Frontera Comalapa','Marlin Trejo Posada','MORENA'),
  ('Frontera Hidalgo','Juana Elizabeth de la Cruz Mazariegos','RSP'),
  ('La Grandeza','José Armando Díaz Pérez','RSP'),
  ('Huehuetán','Sixto López Pérez','RSP'),
  ('Huitiupán','Amalia del Carmen Ochoa Ramos','MORENA'),
  ('Huixtán','Romeo Damian Huet Álvarez','PT'),
  ('Huixtla','Regulo Palomeque Sánchez','PT'),
  ('La Independencia','Jhony Sebastián López López','MORENA'),
  ('Ixhuatán','María Guadalupe López Camacho','MORENA'),
  ('Ixtacomitán','Miguel Ángel Moreno Palacios','MORENA'),
  ('Ixtapa','Roberto Jordan Aguilar Pavón','PT'),
  ('Ixtapangajoya','Juan Ignacio González García','RSP'),
  ('Jiquipilas','Blanca Yaneth Chiu López','MORENA'),
  ('Jitotol','José Gregorio Pérez Molina','RSP'),
  ('Juárez','Oscar Serra Cantoral','PVEM'),
  ('Larráinzar','Andrés Ruíz Gómez','PRI'),
  ('La Libertad','Porfirio Correa López','Independiente'),
  ('Mapastepec','Amando Espinosa Cruz','PVEM'),
  ('Las Margaritas','Bladimir Hernández Álvarez','MORENA'),
  ('Mazapa de Madero','Wilder Alberto Jacob Guzmán','Partido Chiapas Unido'),
  ('Mazatán','Sara Barrera Solís','MORENA'),
  ('Metapa','Luis Salgado Sánchez','RSP'),
  ('Mitontic','María Velázquez Ortiz','PVEM'),
  ('Motozintla','Alfonso Meza Pivaral','PT'),
  ('Nicolás Ruíz','Audelio Jiménez Gómez','MORENA'),
  ('Ocosingo','Manuela Ángelica Méndez Cruz','PVEM'),
  ('Ocotepec','Isidro Baldemar Ramos Bonifas','PT'),
  ('Ocozocoautla de Espinosa','Francisco Javier Chambe Morales','PVEM'),
  ('Ostuacán','Víctor Manuel López Jiménez','MORENA'),
  ('Osumacinta','Samuel Alegría Pérez','PAN'),
  ('Palenque','Jorge Cabrera Aguilar','PVEM'),
  ('Pantelhó','Julio Pérez Pérez','RSP'),
  ('Pantepec','Osmar Willian Velasco García','Partido Chiapas Unido'),
  ('Pichucalco','Andrés Carballo Córdova','MORENA'),
  ('Pijijiapan','Carlos Alberto Albores Lima','MORENA'),
  ('El Porvenir','Josue Maximiliano González Pérez','PT'),
  ('Pueblo Nuevo Solistahuacán','Erlen Sánchez Hernández','Mover a Chiapas'),
  ('Rayón','Domingo González Trejo','RSP'),
  ('Reforma','Pedro Ramírez Ramos','MC'),
  ('Las Rosas','Jesús Antonio Orantes Noriega','MORENA'),
  ('Sabanilla','Carlos Cleber González Cabello','MORENA'),
  ('Salto de Agua','Humberto Sánchez Díaz','PVEM'),
  ('San Cristóbal de Las Casas','Fabiola Ricci Diestel','MORENA'),
  ('San Fernando','Ediberto Gutiérrez Aguilar','PVEM'),
  ('San Juan Cancuc','Juan López Mendoza','PRI'),
  ('San Lucas','Guadalupe Guzmán Villarreal','PVEM'),
  ('Siltepec','Leydi Yesenia Salas Mérida','MORENA'),
  ('Simojovel','Inocencio Agenor Domínguez Hernández','MORENA'),
  ('Sitalá','Guadalupe Deara López','MORENA'),
  ('Socoltenango','Juan Carlos Morales Hernández','PT'),
  ('Solosuchiapa','Fernando Aparicio Gómez','RSP'),
  ('Soyaló','Nadelin Francisco Pérez Pérez','PVEM'),
  ('Suchiapa','Jorge Lorenzo Lara Cordero','MORENA'),
  ('Suchiate','Elmer de Jesús Vázquez Gallardo','RSP'),
  ('Sunuapa','Fredi Ramírez Díaz','PRD'),
  ('Tapachula','Aaron Yamil Melgar Bravo','MORENA'),
  ('Tapalapa','Guadalupe Gómez García','MORENA'),
  ('Tapilula','Rosemberg Díaz Utrilla','PVEM'),
  ('Tecpatán','César Edgar Marín Gómez','MORENA'),
  ('Tenejapa','Roberto Giron Luna','MORENA'),
  ('Teopisca','Luis Alberto Valdez Díaz','PVEM'),
  ('Tila','Neiser Hernández López','PVEM'),
  ('Tonalá','Manuel de Jesús Narcia Coutiño','PVEM'),
  ('Totolapa','Mario Argelio Fonseca López','MORENA'),
  ('La Trinitaria','Denis Gabriel Solís Alvarado','MORENA'),
  ('Tumbalá','Griselda de Jesús Méndez','PVEM'),
  ('Tuxtla Chico','Julio Enrique Gamboa Altuzar','PRI'),
  ('Tuxtla Gutiérrez','Ángel Carlos Torres Culebro','MORENA'),
  ('Tuzantán','Grissel Vázquez Zambrano','PT'),
  ('Tzimol','Víctor Alfonso Gordillo Morales','RSP'),
  ('Unión Juárez','Fabián Barrios de León','MC'),
  ('Venustiano Carranza','Francisco Augusto Borraz Ayar','PT'),
  ('Villa Comaltitlán','Gerardo Gómez Pérez','PVEM'),
  ('Villa Corzo','José Ignacio Nagaya Vicente','PVEM'),
  ('Villaflores','Valeria Rosales Sarmiento','MORENA'),
  ('Yajalón','Juan Manuel Utrilla Constantino','PVEM'),
  ('Zinacantán','José Martínez Pérez','PRI'),
  ('Aldama','Catalina Pérez Ruiz','PRI'),
  ('Benemérito de las Américas','Juan Gómez Morales','Partido Chiapas Unido'),
  ('Maravilla Tenejapa','Obdulio Gutiérrez Gutiérrez','MORENA'),
  ('Marqués de Comillas','Eleazar Pérez Gordillo','PT'),
  ('Montecristo de Guerrero','María Aurora Santeliz Sánchez','RSP'),
  ('San Andrés Duraznal','Humberto Hernández Gómez','Mover a Chiapas'),
  ('Santiago el Pinar','Silviano Mateo Gómez Gómez','PT'),
  ('Capitán Luis Ángel Vidal','Emiselda González Martínez','PVEM'),
  ('Rincón Chamula San Pedro','María de la Luz Hernández Pérez','MORENA'),
  ('El Parral','Elvira del Carmen Castañeda Maza','MORENA'),
  ('Emiliano Zapata','Jesús Enrique Reyes Najera','MORENA'),
  ('Mezcalapa','José Tilo Alcudia Hernández','MORENA'),
  ('Honduras de la Sierra','Arain Jeu Roblero Hernández','Mover a Chiapas'),
  ('Oxchuc','Autoridad por usos y costumbres', null);

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '07', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN'))
   = upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN'))
 and m.cve_ent = '07'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

-- Verificación: municipios de Chiapas sin presidente (revisa nombres nuevos: p.ej.
-- "Capitán Luis Ángel Vidal", "Rincón Chamula San Pedro", artículos El/La/Las).
select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '07'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo);
