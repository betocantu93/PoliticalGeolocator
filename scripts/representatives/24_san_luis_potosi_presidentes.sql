-- 24_san_luis_potosi_presidentes.sql — 58 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de San Luis Potosí (2024-2027)". Verificar.
-- Tancanhuitz: ayuntamiento vacante. PCP = Partido Conciencia Popular (local).

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Ahualulco','Federico Monsivais Rojas','PT'),
  ('Alaquines','Laura Moctezuma de la Cruz','PVEM'),
  ('Aquismón','Cuauhtémoc Balderas Yáñez','PVEM'),
  ('Armadillo de los Infante','Baldemar Miguel Hernández','PRI'),
  ('Axtla de Terrazas','Clara María Castro Jonguitud','PRI'),
  ('Cárdenas','Edgar Miguel Hernández Aguilar','PT'),
  ('Catorce','Juan Francisco Javier Sandoval Torres','Nueva Alianza'),
  ('Cedral','Cinthia Verónica Segovia Colunga','PVEM'),
  ('Cerritos','Ruth Liliana Castillo Montelongo','PVEM'),
  ('Cerro de San Pedro','Ángel de Jesús Nava Loredo','PRI'),
  ('Ciudad del Maíz','Rosa Angélica Martínez Linares','Nueva Alianza'),
  ('Ciudad Fernández','Rodolfo Loredo Hernández','PVEM'),
  ('Ciudad Valles','David Armando Medina Salazar','PVEM'),
  ('Coxcatlán','Omar Alberto Soni Bulos','MC'),
  ('Charcas','Marisol Nájera Alba','PVEM'),
  ('Ébano','José Guadalupe Ordáz Cruz','PAN'),
  ('El Naranjo','Rafael Olvera Torres','Independiente'),
  ('Guadalcázar','Gumaro Verdín Puente','PVEM'),
  ('Huehuetlán','Ramón Martínez Avitud','MORENA'),
  ('Lagunillas','Sergio Alberto Izaguirre Ponce','PVEM'),
  ('Matehuala','Raúl Ortega Rodríguez','PAN'),
  ('Matlapa','María de Jesús Rivera Rosales','PVEM'),
  ('Mexquitic de Carmona','Francisco Javier Ortiz Hernández','MC'),
  ('Moctezuma','Mario Díaz Hernández','PT'),
  ('Rayón','Baltazar Tello Pérez','PVEM'),
  ('Rioverde','Arnulfo Urbiola Román','PVEM'),
  ('Salinas','Antonio Venancio Páez Galván','PCP'),
  ('San Antonio','Benito González Hernández','MC'),
  ('San Ciro de Acosta','Luis Carlos Pereyra Govea','PVEM'),
  ('San Luis Potosí','Enrique Francisco Galindo Ceballos','PRI'),
  ('San Martín Chalchicuautla','Luis Fernando Herbert Orta','PVEM'),
  ('San Nicolás Tolentino','Alejandra Deyanira Ortiz Márquez','MORENA'),
  ('Santa Catarina','Juan Carlos Ramos Moreno','MORENA'),
  ('Santa María del Río','Isis Aydé Díaz Hernández','MORENA'),
  ('Santo Domingo','Filiberto Rodríguez Alvarado','PVEM'),
  ('San Vicente Tancuayalab','Gilberto González Zumaya','PAN'),
  ('Soledad de Graciano Sánchez','Juan Manuel Navarro Muñíz','PVEM'),
  ('Tamasopo','Mauricio Andrade Merchan','PRD'),
  ('Tamazunchale','Adelaido Cabañas Hernández','PVEM'),
  ('Tampacán','Santiago Rodríguez Posadas','MORENA'),
  ('Tampamolón Corona','Silvia Medina Burgaña','PVEM'),
  ('Tamuín','Marcelino Bautista Rincón','PVEM'),
  ('Tanlajás','Humberto Lucero Magaña','MORENA'),
  ('Tanquián de Escobedo','Pablo Emmanuel Jonguitud Guerrero','MORENA'),
  ('Tancanhuitz','Ayuntamiento vacante', null),
  ('Tierra Nueva','Yessenia Pilar Sánchez Vega','PRD'),
  ('Vanegas','Gerónimo García Ruiz','MORENA'),
  ('Venado','José Reyes Martínez Rojas','PVEM'),
  ('Villa de Arriaga','Salvador López Amaro','PVEM'),
  ('Villa de Guadalupe','Emiliano Zapata López','PRD'),
  ('Villa de la Paz','Juan Francisco Gómez Escamilla','MC'),
  ('Villa de Ramos','Erick Giovanni Espino de la Rosa','PT'),
  ('Villa de Reyes','Ismael Nicolás Hernández Martínez','PVEM'),
  ('Villa Hidalgo','Crystal Alva Venegas','PT'),
  ('Villa Juárez','Lisa Avigail Izaguirre Rico','PRI'),
  ('Villa de Zaragoza','Amada Zavala','PT'),
  ('Villa de Arista','Bernabé Mares Briones','PRI'),
  ('Xilitla','Óscar Humberto Márquez Plascencia','PVEM');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '24', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '24'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '24'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo)
order by m.nom_mun;
