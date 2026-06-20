-- 19_nuevo_leon_locales.sql — 26 diputados locales de MR (LXXVII Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXXVII Legislatura del Congreso del Estado de Nuevo León". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','19',1,'Ivonne Liliana Álvarez García','PRI'),
  ('local_deputy','19',2,'Rafael Eduardo Ramos de la Garza','PRI'),
  ('local_deputy','19',3,'Myrna Isela Grimaldo Iracheta','PAN'),
  ('local_deputy','19',4,'Ana Melisa Peña Villagómez','MC'),
  ('local_deputy','19',5,'Gabriela Govea López','PRI'),
  ('local_deputy','19',6,'Perla de los Ángeles Villarreal Valdez','PRD'),
  ('local_deputy','19',7,'José Filiberto Flores Elizondo','PRI'),
  ('local_deputy','19',8,'Lorena de la Garza Venecia','PRI'),
  ('local_deputy','19',9,'Mauro Guerra Villarreal','PAN'),
  ('local_deputy','19',10,'Carlos Alberto de la Fuente Flores','PAN'),
  ('local_deputy','19',11,'Baltazar Gilberto Martínez Ríos','MC'),
  ('local_deputy','19',12,'Mario Alejandro Soto Esquer','MORENA'),
  ('local_deputy','19',13,'Jesús Alberto Elizondo Salazar','MORENA'),
  ('local_deputy','19',14,'José Luis Garza Garza','MC'),
  ('local_deputy','19',15,'Itzel Soledad Castillo Almanza','PAN'),
  ('local_deputy','19',16,'Elsa Escobedo Vázquez','PRI'),
  ('local_deputy','19',17,'Anylú Bendición Hernández Sepúlveda','MORENA'),
  ('local_deputy','19',18,'Claudia Gabriela Caballero Chávez','PAN'),
  ('local_deputy','19',19,'Miguel Ángel García Lechuga','PAN'),
  ('local_deputy','19',20,'Greta Pamela Barra Hernández','MORENA'),
  ('local_deputy','19',21,'Armando Víctor Gutiérrez Canales','MC'),
  ('local_deputy','19',22,'Mario Alberto Salinas Treviño','MC'),
  ('local_deputy','19',23,'Rocío Maybe Montalvo Adame','Independiente'),
  ('local_deputy','19',24,'Javier Caballero Gaona','PRI'),
  ('local_deputy','19',25,'Brenda Velázquez Valdez','MORENA'),
  ('local_deputy','19',26,'Aile Tamez de la Paz','PAN')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
