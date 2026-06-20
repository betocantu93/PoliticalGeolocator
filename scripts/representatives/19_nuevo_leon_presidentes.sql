-- 19_nuevo_leon_presidentes.sql — 51 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Nuevo León (2024-2027)". Verificar.
-- Titulares vigentes: San Pedro Garza García (Mauricio Farah), Juárez (Mónica Oyervides),
-- Santa Catarina (Jesús Ángel Nava, ahora MORENA).

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Abasolo','Reynaldo Javier Cantú Montes','MC'),
  ('Agualeguas','Aldo Castellanos Amaya','PAN'),
  ('Los Aldamas','Janett Leal Leal','PAN'),
  ('Allende','Eduardo Leal Buenfil','PAN'),
  ('Anáhuac','Juan Manuel Mortón González','PRI'),
  ('Apodaca','César Garza Arredondo','PRI'),
  ('Aramberri','Martín Castillo Covarrubias','MC'),
  ('Bustamante','Mario Alfonso Resendez Garza','PAN'),
  ('Cadereyta Jiménez','Carlos Rafael Rodríguez Gómez','MC'),
  ('El Carmen','Gerardo Alfonso de la Maza Villarreal','MC'),
  ('Cerralvo','Baltazar Martínez Montemayor','MC'),
  ('Ciénega de Flores','Miguel Ángel Quiroga Treviño','PVEM'),
  ('China','Alejo Rodríguez Cantú','PVEM'),
  ('Doctor Arroyo','Juan José Vargas Rosales','PRI'),
  ('Doctor Coss','José Guadalupe Ríos Ríos','MC'),
  ('Doctor González','Alejandro González Treviño','PRI'),
  ('Galeana','Alejandra Ramírez Díaz','PRI'),
  ('García','Manuel Guerra Cavazos','MORENA'),
  ('San Pedro Garza García','Mauricio Farah Giacoman','PAN'),
  ('General Bravo','Patricia Frinee Cantú Garza','PAN'),
  ('General Escobedo','Andrés Concepción Mijes Llovera','MORENA'),
  ('General Terán','David Jonathan Sánchez Quintanilla','MC'),
  ('General Treviño','Maribel Hinojosa García','PAN'),
  ('General Zaragoza','Judith Amaranta Ibarra Rodríguez','MC'),
  ('General Zuazua','Elva Deyanira Martínez González','MORENA'),
  ('Guadalupe','Héctor García García','MC'),
  ('Los Herreras','Héctor Raúl González Garza','MC'),
  ('Hidalgo','Adriana Margarita Garza Gutiérrez','PT'),
  ('Higueras','Rafael René González Martínez','PAN'),
  ('Hualahuises','Jesús Homero Aguilar Hernández','PRI'),
  ('Iturbide','Arnoldo Carreón Rodríguez','MC'),
  ('Juárez','Mónica Marisela Oyervides Acosta','MC'),
  ('Lampazos de Naranjo','Adriana Deyanira Martínez Zúñiga','PAN'),
  ('Linares','Gerardo Guzmán González','MORENA'),
  ('Marín','Juan Carlos Rosales Herrera','PVEM'),
  ('Melchor Ocampo','Omar Ramos García','PT'),
  ('Mier y Noriega','Fidencio Gerardo Zavala González','PVEM'),
  ('Mina','Edgar Candelario Molina Elizondo','MC'),
  ('Montemorelos','Miguel Ángel Salazar Rangel','PRI'),
  ('Monterrey','Adrián de la Garza Santos','PRI'),
  ('Parás','Ana Iza Oliveira Treviño','PAN'),
  ('Pesquería','Francisco Esquivel Garza','MC'),
  ('Los Ramones','Delia Lizeth Leal Ríos','PAN'),
  ('Rayones','Rolando Montoya del Bosque','PAN'),
  ('Sabinas Hidalgo','Daniel Omar González Garza','PAN'),
  ('Salinas Victoria','Raúl Cantú de la Garza','MC'),
  ('San Nicolás de los Garza','Daniel Carrillo Martínez','PAN'),
  ('Santa Catarina','Jesús Ángel Nava Rivera','MORENA'),
  ('Santiago','David de la Peña Marroquín','PRI'),
  ('Vallecillo','Erasmo Serna Vázquez','PT'),
  ('Villaldama','Luis Eduardo Sepúlveda de León','MC');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '19', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '19'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '19'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo)
order by m.nom_mun;
