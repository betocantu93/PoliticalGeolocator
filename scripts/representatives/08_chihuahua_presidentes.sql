-- 08_chihuahua_presidentes.sql — 67 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Chihuahua (2024-2027)". Verificar.
-- JOIN normaliza acentos Y espacios. Nota: "Santa Isabel" en INEGI puede llamarse
-- "General Trías" -> revisar la verificación.

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Ahumada','Iván Rodelo Espejo','PT'),
  ('Aldama','Sandra Judith Galindo Sinecio','PRD'),
  ('Allende','Rafael Payán Morales','MORENA'),
  ('Aquiles Serdán','Teresa Erives Baca','PRI'),
  ('Ascensión','Ivonne de la Hoya Venzor','PRD'),
  ('Bachíniva','Adrián Varela Chávez','PAN'),
  ('Balleza','Jesús Augusto Medina Aguirre','PRI'),
  ('Batopilas','Eduardo Aarón Ruelas Fernández','PRI'),
  ('Bocoyna','Macario Baldivar Hermosillo Pompa','PAN'),
  ('Buenaventura','Rogelio Pacheco Flores','PRI'),
  ('Camargo','Jorge Alejandro Aldana Aguilar','PAN'),
  ('Carichí','Iván Alejandro Gutiérrez Villarreal','PRI'),
  ('Casas Grandes','Roberto Lucero Galáz','PRI'),
  ('Coronado','Leo López Muñoz','PAN'),
  ('Coyame del Sotol','Felipe Armando Reyes Mancha','PRD'),
  ('La Cruz','Sergio Luis Olvera Gallegos','MC'),
  ('Cuauhtémoc','Elías Humberto Pérez Mendoza','PAN'),
  ('Cusihuiriachi','Blanca Estela Marioni Camúñez','PRI'),
  ('Chihuahua','Marco Antonio Bonilla Mendoza','PAN'),
  ('Chínipas','Guadalupe Pérez Palma','MORENA'),
  ('Delicias','Jesús Alberto Valenciano García','PAN'),
  ('Doctor Belisario Domínguez','Reimon Ruíz Socarro','PT'),
  ('Galeana','Terry Francis Leany Le Barón','PAN'),
  ('Santa Isabel','Fernando Ortega Balderrama','PAN'),
  ('Gómez Farías','María de los Ángeles Moreno Rascón','PRI'),
  ('Gran Morelos','Óscar Luis Miramontes Pérez','MC'),
  ('Guachochi','José Miguel Yáñez Ronquillo','PRI'),
  ('Guadalupe','Lorenzo Tarango Venegas','Pueblo'),
  ('Guadalupe y Calvo','Ana Laura González Abrego','MORENA'),
  ('Guazapares','Bartolo Moreno Bustillos','MORENA'),
  ('Guerrero','Salvador Fernando Villa Domínguez','PRI'),
  ('Hidalgo del Parral','Salvador Calderón Aguirre','PAN'),
  ('Huejotitán','Rogelio Rodríguez Aróstegui','MORENA'),
  ('Ignacio Zaragoza','Omar Escorza Ortiz','MORENA'),
  ('Janos','Joel Loya Márquez','PAN'),
  ('Jiménez','Francisco Andrés Muñoz Velázquez','MORENA'),
  ('Juárez','Cruz Pérez Cuéllar','MORENA'),
  ('Julimes','José Moncayo Porras','PRI'),
  ('López','Dalila Maldonado Chaparro','PRI'),
  ('Madera','Arnoldo Jaquez Pérez','MORENA'),
  ('Maguarichi','Francisco Manuel Campos Zamarrón','PRI'),
  ('Manuel Benavides','Fernando García Villanueva','MC'),
  ('Matachí','María de Jesús Martínez Rodríguez','MORENA'),
  ('Matamoros','Jesús Enrique Peña Vázquez','PAN'),
  ('Meoqui','Miriam Soto Ornelas','PAN'),
  ('Morelos','José de Loreto Javalera Bojórquez','MORENA'),
  ('Moris','Lotabel Rivera Martínez','MORENA'),
  ('Namiquipa','Adrián Ruíz Lucero','MORENA'),
  ('Nonoava','Arturo Salinas Villalobos','PVEM'),
  ('Nuevo Casas Grandes','Edith Escárcega Escontrias','MORENA'),
  ('Ocampo','Rafael Solís Martínez','MORENA'),
  ('Ojinaga','Lucy Marrufo Acosta','PAN'),
  ('Práxedis G. Guerrero','Rosario Moreno López','PRI'),
  ('Riva Palacio','Salvador Chacón Rivera','PAN'),
  ('Rosales','José Dolores Andujo Gómez','PAN'),
  ('Rosario','Rosa Elvia Meraz Morales','PRI'),
  ('San Francisco de Borja','David Corral Ramírez','MC'),
  ('San Francisco de Conchos','Norma Graciela Pavia Manríquez','PRI'),
  ('San Francisco del Oro','Jorge Salcido Sáenz','PVEM'),
  ('Santa Bárbara','Raúl Alberto Antuna Ulloa','PRI'),
  ('Satevó','Norma Muñoz Anchondo','PAN'),
  ('Saucillo','Rodolfo Gardea Palma','PAN'),
  ('Temósachi','Omar Caleb Lazo Herrera','MORENA'),
  ('El Tule','Juan José García Valdez','MORENA'),
  ('Urique','Heber Arturo Langarica Almanza','MORENA'),
  ('Uruachi','Marcelo Rascón Félix','PRI'),
  ('Valle de Zaragoza','Jesús Norberto Grado Grado','Pueblo');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '08', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '08'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

-- Verificación: municipios de Chihuahua sin presidente (revisar "Santa Isabel"/"General Trías")
select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '08'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo);
