-- 05_coahuila_presidentes.sql — 38 presidentes municipales (2025-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Coahuila (2024-2027)". Verificar.
-- UDC = Unidad Democrática de Coahuila (partido local).

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Abasolo','Yolanda García Valdez','PRI'),
  ('Acuña','Emilio Alejandro de Hoyos Montemayor','UDC'),
  ('Allende','Ricardo Alfonso Treviño Guevara','PT'),
  ('Arteaga','Ana Karen Sánchez Flores','PRI'),
  ('Candela','Fernando Juárez Santos','PRI'),
  ('Castaños','Yesica Isabel Sifuentes Zamora','PRI'),
  ('Cuatrociénegas','Víctor Manuel Lejía Vega','PAN'),
  ('Escobedo','Daniela Elizabeth Durán Soto','PRD'),
  ('Francisco I. Madero','Félix Ramírez Hernández','MORENA'),
  ('Frontera','Sara Irma Pérez Cantú','PRI'),
  ('General Cepeda','Mayra Verónica Ramos Rodríguez','PRI'),
  ('Guerrero','Mario Cedillo Infante','PRI'),
  ('Hidalgo','Conrado Navarro Sánchez','MC'),
  ('Jiménez','Claudia Maribel González Espinoza','UDC'),
  ('Juárez','Ana Liliana Quiñones Nájera','PRI'),
  ('Lamadrid','Magdalena Ortiz Pizarro','PRI'),
  ('Matamoros','Miguel Ángel Ramírez López','PRI'),
  ('Monclova','Carlos Fernando Villarreal Pérez','PRI'),
  ('Morelos','Mario Alberto Camarillo Zertuche','PRI'),
  ('Múzquiz','Laura Patricia Jiménez Gutiérrez','PRI'),
  ('Nadadores','María Alejandra Huerta Alemán','PRI'),
  ('Nava','Iván Ochoa Rodríguez','MORENA'),
  ('Ocampo','Adriana Valdez López','PRI'),
  ('Parras','Fernando Orozco Lara','PRI'),
  ('Piedras Negras','Carlos Jacobo Rodríguez González','MORENA'),
  ('Progreso','Federico Quintanilla Arana','PRI'),
  ('Ramos Arizpe','Tomás Fausto Gutiérrez Merino','PRI'),
  ('Sabinas','José Feliciano Díaz Iribarren','PVEM'),
  ('Sacramento','Andrea Wendolin Ovalle Reyna','PRI'),
  ('Saltillo','Javier Díaz González','PRI'),
  ('San Buenaventura','Hugo Iván Lozano Sánchez','PRI'),
  ('San Juan de Sabinas','Óscar Ríos Ramírez','PRI'),
  ('San Pedro','Brenda Cecilia Guereca Hernández','PRI'),
  ('Sierra Mojada','Elías Portillo Vázquez','PRD'),
  ('Torreón','Román Alberto Cepeda González','PRI'),
  ('Viesca','Jorge Alonso Vélez Sandoval','MORENA'),
  ('Villa Unión','Mario Humberto González Vela','PRI'),
  ('Zaragoza','Evelio Vara Rivera','PT');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '05', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN'))
   = upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN'))
 and m.cve_ent = '05'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

-- Verificación: municipios de Coahuila sin presidente (debe salir vacío)
select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '05'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo);
