-- 16_michoacan_presidentes.sql — 113 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Michoacán (2024-2027)". Verificar.
-- Cherán: usos y costumbres (party null). Tepalcatepec: vacante. Uruapan: Grecia Quiroz
-- (independiente, tras homicidio de Carlos Manzo). Partido local: Más Michoacán.

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Acuitzio','Adán Guillén Villaseñor','Más Michoacán'),
  ('Aguililla','Elsa Guadalupe Contreras Sánchez','PVEM'),
  ('Álvaro Obregón','Adán Sánchez López','PRI'),
  ('Angamacutiro','Hermes Arnulfo Pacheco Bribiesca','PVEM'),
  ('Angangueo','María Hilda Domínguez García','PT'),
  ('Apatzingán','Fanny Lyssette Arreola Pichardo','MORENA'),
  ('Áporo','Juan Agustín Torres Sandoval','MC'),
  ('Aquila','José María Valencia Guillén','PVEM'),
  ('Ario','Karla Yohana Mendoza Bermúdez','PVEM'),
  ('Arteaga','Wendoly Alejandra Avellaneda Torres','PT'),
  ('Briseñas','María Lourdes Padilla Espinoza','MC'),
  ('Buenavista','Irma Moreno Mendoza','MORENA'),
  ('Carácuaro','Hever Tentory García','PRD'),
  ('Charapan','Nancy Torres Gerónimo','PRD'),
  ('Charo','Juan Gabriel Molinero Villaseñor','MC'),
  ('Chavinda','Armando Pérez Mendoza','MC'),
  ('Chilchota','Alejandra Ortiz Suárez','MORENA'),
  ('Chinicuila','Justo Humberto Virgen Cerrillos','PVEM'),
  ('Chucándiro','Mario Herrera Sánchez','PRD'),
  ('Churintzio','Francisco Javier Pérez Maldonado','PAN'),
  ('Churumuco','María Judit Chino Camacho','PRI'),
  ('Coahuayana','Andrés Rafael Aguilar Mendoza','PRD'),
  ('Coalcomán de Vázquez Pallares','Anavel Ávila Castrejón','MC'),
  ('Coeneo','Valeria Aguilar Juárez','MORENA'),
  ('Cojumatlán de Régules','Janitzio Mújica Manzo','PRD'),
  ('Contepec','Eduardo Martínez Guzmán','MORENA'),
  ('Copándaro','María Griselda Tena Hernández','MC'),
  ('Cotija','Blanca María Ibarra Ochoa','PAN'),
  ('Cuitzeo','Rosa Elia Milán Pintor','PT'),
  ('Ecuandureo','Jorge Luis Estrada Garibay','PAN'),
  ('Epitacio Huerta','Francisco Maya Morales','PAN'),
  ('Erongarícuaro','Liliana Campos de la Luz','PRI'),
  ('Gabriel Zamora','Vilma Yesenia Maldonado Correa','PT'),
  ('Hidalgo','Jeovana Mariela Alcántara Baca','PRI'),
  ('Huandacareo','Pedro Alexis Velázquez Guzmán','MORENA'),
  ('Huaniqueo','Ramón Carranza García','PRD'),
  ('Huetamo','Pablo Varona Estrada','PRD'),
  ('Huiramba','José Humberto García Domínguez','MORENA'),
  ('Indaparapeo','Janitzio Zavala Vega','PRI'),
  ('Irimbo','Azucena Ruíz Alanís','PRD'),
  ('Ixtlán','César Enoc Tamayo Herrera','PRI'),
  ('Jacona','Isidoro Mosqueda Estrada','MORENA'),
  ('Jiménez','Claudia Griselle Sanhua Pérez','PRD'),
  ('Jiquilpan','Gerardo Olloqui Estrada','PRD'),
  ('José Sixto Verduzco','Enrique Ramos Vargas','MC'),
  ('Juárez','Ismael Arriaga Ortiz','MORENA'),
  ('Jungapeo','Norma Angélica Yáñez Sierra','MORENA'),
  ('La Huacana','Yaritza Rosas Gaona','PT'),
  ('La Piedad','Samuel David Hidalgo Gallardo','PAN'),
  ('Lagunillas','Octavio Chávez Aguirre','PES'),
  ('Lázaro Cárdenas','Manuel Esquivel Bejarano','MORENA'),
  ('Los Reyes','Humberto Jiménez Solís','PRD'),
  ('Madero','Juan Carlos Gamiño Ávalos','PT'),
  ('Maravatío','Mario Pérez Flores','MORENA'),
  ('Marcos Castellanos','Jorge Luis Anguiano Partida','PAN'),
  ('Morelia','Alfonso Martínez Alcázar','PAN'),
  ('Morelos','Julio César Conejo Alejos','MC'),
  ('Múgica','José Alfredo Rentería Patiño','PT'),
  ('Nahuatzen','Sergio Antonio Puntos Molina','PRD'),
  ('Nocupétaro','Gonzalo Nares Gómez','PRI'),
  ('Nuevo Parangaricutiro','Jesús Antonio Espinoza Rochin','PRI'),
  ('Nuevo Urecho','María del Carmen Carrillo Gaytán','MORENA'),
  ('Numarán','José Díaz Camarena','PRI'),
  ('Ocampo','Leticia Arriaga Domínguez','MORENA'),
  ('Pajacuarán','José Antonio González Flores','MORENA'),
  ('Panindícuaro','Manuel López Meléndez','MORENA'),
  ('Parácuaro','Josafat Bautista González','MORENA'),
  ('Paracho','Salvador Martínez Gutiérrez','MORENA'),
  ('Pátzcuaro','Julio Alberto Arreola Vázquez','PVEM'),
  ('Penjamillo','María Martínez Ruíz','MORENA'),
  ('Peribán','Martín Alexander Escalera Bautista','MORENA'),
  ('Purépero','José Enrique Mora Cárdenas','PRD'),
  ('Puruándiro','Víctor Manuel Vázquez Tapia','PRI'),
  ('Queréndaro','Diana Caballero Romero','MORENA'),
  ('Quiroga','Alma Mireya González Sánchez','PAN'),
  ('Sahuayo','Manuel Gálvez Sánchez','PAN'),
  ('Salvador Escalante','María Dayana Pérez Mendoza','MORENA'),
  ('San Lucas','Aralia Saucedo Flores','PRI'),
  ('Santa Ana Maya','Francisco Javier Mendoza Ortiz','PT'),
  ('Senguio','Rodolfo Quintana Trujillo','PRI'),
  ('Susupuato','Diana Laura Mondragón Benítez','MC'),
  ('Tacámbaro','Alejandro Fuerte García','PT'),
  ('Tancítaro','Carlos Navarro Corza','PAN'),
  ('Tangamandapio','Luis Enrique Arroyo Lara','MORENA'),
  ('Tangancícuaro','Arturo Hernández Vázquez','PAN'),
  ('Tanhuato','Daniel Herrera Martín del Campo','MC'),
  ('Taretan','Francisco Venera García','PT'),
  ('Tarímbaro','Eric Nicanor Gaona García','PT'),
  ('Tepalcatepec','Ayuntamiento vacante (2024)', null),
  ('Tingambato','Mario Aguilera Martínez','PRD'),
  ('Tingüindín','Glenda Mendoza Cruz','PVEM'),
  ('Tiquicheo de Nicolás Romero','Mario Reyes Tavera','PRI'),
  ('Tlalpujahua','Jorge Medina Montoya','PVEM'),
  ('Tlazazalca','Carlos Joel Aguilar Enríquez','MORENA'),
  ('Tocumbo','José Luis Alcázar Rodríguez','PAN'),
  ('Tumbiscatío','Apolonio Ureña Martínez','MORENA'),
  ('Turicato','Graciela Hernández Arreola','PT'),
  ('Tuxpan','David López Flores','MORENA'),
  ('Tuzantla','Fernando Ocampo Mercado','PRD'),
  ('Tzintzuntzan','Patricio García Alva','PT'),
  ('Tzitzio','José Nauneli Pérez Áviles','PRI'),
  ('Uruapan','Grecia Quiroz García','Independiente'),
  ('Venustiano Carranza','Yolanda Mayela Macías Hernández','PAN'),
  ('Villamar','Froylán Zambrano López','PRI'),
  ('Vista Hermosa','Dolores Martínez Garibay','MORENA'),
  ('Yurécuaro','Moisés Navarro Arellano','MORENA'),
  ('Zacapu','Mónica Estela Valdez Pulido','MORENA'),
  ('Zamora','Carlos Alberto Soto Delgado','PAN'),
  ('Zináparo','Emiliano Zavala Cázarez','PRI'),
  ('Zinapécuaro','Jordán Reyes García','MORENA'),
  ('Ziracuaretiro','Alberto Orobio Arriaga','PAN'),
  ('Zitácuaro','Juan Antonio Ixtlahuac Orihuela','MORENA'),
  ('Cherán','Concejo Mayor (usos y costumbres)', null);

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '16', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '16'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '16'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo)
order by m.nom_mun;
