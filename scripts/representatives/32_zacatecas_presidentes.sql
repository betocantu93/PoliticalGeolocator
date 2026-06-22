-- 32_zacatecas_presidentes.sql — 58 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Zacatecas (2024-2027)". Verificar.

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Apozol','Gabriela Arellano Quezada','MORENA'),
  ('Apulco','Mauro Yuriel Jaúregui Muñoz','MC'),
  ('Atolinga','Teresita de Jesús Arteaga Pérez','MORENA'),
  ('Benito Juárez','Fortino Cortés Ramírez','PVEM'),
  ('Calera','Miguel Ángel Murillo García','PT'),
  ('Cañitas de Felipe Pescador','Oswaldo Sabag Hamadani','PRD'),
  ('Concepción del Oro','José Luis Martínez López','Nueva Alianza'),
  ('Cuauhtémoc','Francisco Javier Arcos Ruiz','PVEM'),
  ('Chalchihuites','Pedro Miranda Morales','PRI'),
  ('Fresnillo','Javier Torres Rodríguez','PRI'),
  ('Trinidad García de la Cadena','Armida Núñez Guzmán','PRI'),
  ('Genaro Codina','Erick Hernández Saucedo','MORENA'),
  ('General Enrique Estrada','Martha Milagros de Loera Rodríguez','PVEM'),
  ('General Francisco R. Murguía','José Nieves Balderas Sánchez','PRI'),
  ('El Plateado de Joaquín Amaro','Jairo Cuevas Pérez','PVEM'),
  ('General Pánfilo Natera','Fredy González Vázquez','Nueva Alianza'),
  ('Guadalupe','José Saldivar Alcalde','MORENA'),
  ('Huanusco','Julieta Isamar Camacho García','PAN'),
  ('Jalpa','Olegario Viramontes Gómez','PAN'),
  ('Jerez','Rodrigo Ureño Bañuelos','PRD'),
  ('Jiménez del Teul','Daniel Cisneros Esparza','PT'),
  ('Juan Aldama','María Griselda Romero Zúñiga','MORENA'),
  ('Juchipila','José María Castro Félix','PT'),
  ('Loreto','Antonio Tiscareño de Anda','MORENA'),
  ('Luis Moya','José Guadalupe Silva Medina','PVEM'),
  ('Mazapil','Mario Macías Zúñiga','Nueva Alianza'),
  ('Melchor Ocampo','Rodolfo Cisneros Gallegos','Nueva Alianza'),
  ('Mezquital del Oro','Mónica Rodarte Dávila','MORENA'),
  ('Miguel Auza','Arturo Calderón Rueda','MORENA'),
  ('Momax','Salvador Cabral Mota','PAN'),
  ('Monte Escobedo','Manuel Acosta Galván','PRI'),
  ('Morelos','Sergio Vázquez Lujan','MORENA'),
  ('Moyahua de Estrada','Norma Castañeda Romero','MORENA'),
  ('Nochistlán de Mejía','José Manuel Jiménez Fuentes','MORENA'),
  ('Noria de Ángeles','Gabriela Cuevas Silva','MORENA'),
  ('Ojocaliente','Juan Manuel Zambrano Jiménez','PRD'),
  ('Pánuco','Juan Rodríguez Valdez','PRI'),
  ('Pinos','Armando Contreras Mata','MORENA'),
  ('Río Grande','Mario Cordova Longoria','PRI'),
  ('Sain Alto','Ignacio Gómez Almaraz','PRI'),
  ('El Salvador','Miguel Coronado Gamez','PVEM'),
  ('Sombrerete','J. Santos Ramiro Hinojoza Aguayo','MORENA'),
  ('Susticacán','Fabiola Rodríguez Saldivar','PRI'),
  ('Tabasco','Carlos Fabián Vera Loera','PAN'),
  ('Tepechitlán','Adolfo Cortez Santillán','PES'),
  ('Tepetongo','Filiberto Venegas Nava','MORENA'),
  ('Teul de González Ortega','Francisco Reyes Torres Pérez','PT'),
  ('Tlaltenango de Sánchez Román','Francisco Delgado Miramontes','MORENA'),
  ('Valparaíso','María Guadalupe Ortiz Robles','MORENA'),
  ('Vetagrande','Juan Antonio Herrera Morua','Fuerza por México'),
  ('Villa de Cos','Pier Michel Ríos Ruiz','PRI'),
  ('Villa García','José Ernesto Mora Hurtado','MC'),
  ('Villa González Ortega','María Magdalena Alvarado García','MORENA'),
  ('Villa Hidalgo','Eleazar Garza Escamilla','MORENA'),
  ('Villanueva','Rogelio González Álvarez','MORENA'),
  ('Zacatecas','Miguel Ángel Varela Pinedo','PAN'),
  ('Trancoso','Antonio Rocha Romo','PT'),
  ('Santa María de la Paz','Yoalli Magallanes Velázquez','MC');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '32', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '32'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '32'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo)
order by m.nom_mun;
