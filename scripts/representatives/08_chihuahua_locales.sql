-- 08_chihuahua_locales.sql — 22 diputados locales de MR (LXVIII Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXVIII Legislatura del Congreso del Estado de Chihuahua". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','08',1,'Yesenia Guadalupe Reyes Calzadias','PAN'),
  ('local_deputy','08',2,'Leticia Ortega Máynez','MORENA'),
  ('local_deputy','08',3,'Óscar Daniel Avitia Arellanes','MORENA'),
  ('local_deputy','08',4,'Rosana Díaz Reyes','MORENA'),
  ('local_deputy','08',5,'Edna Xóchitl Contreras Herrera','PAN'),
  ('local_deputy','08',6,'Irlanda Dominique Márquez Nolasco','PT'),
  ('local_deputy','08',7,'Elizabeth Guzmán Argüeta','MORENA'),
  ('local_deputy','08',8,'Edin Cuauhtémoc Estrada Sotelo','MORENA'),
  ('local_deputy','08',9,'Magdalena Rentería Pérez','MORENA'),
  ('local_deputy','08',10,'María Antonieta Pérez Reyes','MORENA'),
  ('local_deputy','08',11,'Ismael Pérez Pavia','PAN'),
  ('local_deputy','08',12,'Nancy Janeth Frías Frías','PAN'),
  ('local_deputy','08',13,'Luis Fernando Chacón Erives','PRI'),
  ('local_deputy','08',14,'Saúl Mireles Corral','PAN'),
  ('local_deputy','08',15,'Joceline Vega Vargas','PAN'),
  ('local_deputy','08',16,'Carla Yamileth Rivas Martínez','PAN'),
  ('local_deputy','08',17,'Carlos Alfredo Olson San Vicente','PAN'),
  ('local_deputy','08',18,'José Alfredo Chávez Madrid','PAN'),
  ('local_deputy','08',19,'Roberto Marcelino Carreón Huitrón','PAN'),
  ('local_deputy','08',20,'Arturo Zubia Fernández','PAN'),
  ('local_deputy','08',21,'Guillermo Patricio Ramírez Gutiérrez','PRI'),
  ('local_deputy','08',22,'Roberto Arturo Medina Aguirre','PRI')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
