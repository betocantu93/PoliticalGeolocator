-- 11_guanajuato_presidentes.sql — 46 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Guanajuato (2024-2027)". Verificar.
-- León: la alcaldesa cambió de PAN a MC en 2026 -> se registra MC (vigente).

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Abasolo','Job Eduardo Gallardo Santellano','MORENA'),
  ('Acámbaro','Claudia Silva Campos','PAN'),
  ('Apaseo el Alto','Guadalupe Montserrat Mendoza Cano','PAN'),
  ('Apaseo el Grande','José Luis Oliveros Usabiaga','PAN'),
  ('Atarjea','José Luis Rivas Loyola','PAN'),
  ('Celaya','Juan Miguel Ramírez Sánchez','MORENA'),
  ('Comonfort','Gilberto Zárate Nieves','MORENA'),
  ('Coroneo','Luis Fernando Velázquez Esquivel','PAN'),
  ('Cortázar','Marco Mauricio Estefanía Torres','MC'),
  ('Cuerámaro','Humberto Hernández Martínez','PT'),
  ('Doctor Mora','Edgar Javier Reséndiz Jacobo','MORENA'),
  ('Dolores Hidalgo Cuna de la Independencia Nacional','Adrián Hernández Alejandri','PAN'),
  ('Guanajuato','Samantha Smith Gutiérrez','PAN'),
  ('Huanímaro','Laura Villalpando Arroyo','PVEM'),
  ('Irapuato','Lorena del Carmen Alfaro García','PAN'),
  ('Jaral del Progreso','Daniel Cimental Barrón','MORENA'),
  ('Jerécuaro','María Isabel Ascevedo Mercado','PRI'),
  ('León','Alejandra Gutiérrez Campos','MC'),
  ('Manuel Doblado','Gustavo Adolfo Alfaro Reyes','PRI'),
  ('Moroleón','Alma Denisse Sánchez Barragán','MC'),
  ('Ocampo','Erick Silvano Montemayor Lara','PRI'),
  ('Pénjamo','Yozajamby Florencia Molina Balver','MORENA'),
  ('Pueblo Nuevo','Leonardo Solórzano Villanueva','PAN'),
  ('Purísima del Rincón','Roberto García Urbano','PAN'),
  ('Romita','Pedro Kiyoshi Tanamachi Reyes','PAN'),
  ('Salamanca','Julio César Ernesto Prieto Gallardo','MORENA'),
  ('Salvatierra','José Daniel Sámano Jiménez','MORENA'),
  ('San Diego de la Unión','Juan Carlos Castillo Cantero','PRI'),
  ('San Felipe','Saraí Lepe Monjaras','PRI'),
  ('San Francisco del Rincón','Alejandro Antonio Marun González','PAN'),
  ('San José Iturbide','Edgar Manuel Montes de la Vega','MORENA'),
  ('San Luis de la Paz','Rubén Urías Ruiz','PAN'),
  ('San Miguel de Allende','Mauricio Trejo Pureco','PRI'),
  ('Santa Catarina','Rogelio Moya Cabrera','PAN'),
  ('Santa Cruz de Juventino Rosas','Fidel Armando Ruíz Ramírez','Independiente'),
  ('Santiago Maravatío','José Guadalupe Paniagua Flores','PAN'),
  ('Silao de la Victoria','Janet Melanie Murillo Chávez','PAN'),
  ('Tarandacuao','Alejandra Alcántar Ruiz','PAN'),
  ('Tarimoro','Saúl Trejo Rojas','MORENA'),
  ('Tierra Blanca','Rómulo García Cabrera','PAN'),
  ('Uriangato','Juan Carlos Martínez Calderón','PVEM'),
  ('Valle de Santiago','Israel Mosqueda Gasca','MORENA'),
  ('Victoria','J. Salomón Espinola Mendieta','MORENA'),
  ('Villagrán','Cinthia Guadalupe Teniente Mendoza','MORENA'),
  ('Xichú','Francisco Orozco Martínez','PRD'),
  ('Yuriria','Victoria Eugenia Ramírez Zavala','PAN');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '11', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '11'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

-- Verificación (revisa Dolores Hidalgo / Silao por nombre largo INEGI)
select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '11'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo);
