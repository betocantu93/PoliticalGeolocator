-- 27_tabasco_locales.sql — 21 diputados locales de MR (LXV Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXV Legislatura del Congreso del Estado de Tabasco". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','27',1,'Vianey Sánchez Velázquez','MORENA'),
  ('local_deputy','27',2,'Salomé Izquierdo Mena','MORENA'),
  ('local_deputy','27',3,'Alma Lilia Caudillo Ramos','MORENA'),
  ('local_deputy','27',4,'Ángela Ávalos Jiménez','MORENA'),
  ('local_deputy','27',5,'Abby Cristhel Tejeda Vértiz','MORENA'),
  ('local_deputy','27',6,'Marcos Rosendo Medina Filigrana','MORENA'),
  ('local_deputy','27',7,'Claudia Marcela Vélez Lanz','MORENA'),
  ('local_deputy','27',8,'Lilia Guadalupe Coutiño Peña','MORENA'),
  ('local_deputy','27',9,'Jorge Orlando Bracamonte Hernández','MORENA'),
  ('local_deputy','27',10,'Carlos Enrique Íñiguez Rosique','MORENA'),
  ('local_deputy','27',11,'José Medel Córdova Pérez','MORENA'),
  ('local_deputy','27',12,'Isabel Cristina García Jiménez','MORENA'),
  ('local_deputy','27',13,'Diana Eugenia Hernández Gordillo','MORENA'),
  ('local_deputy','27',14,'María de los Ángeles Hernández Reyes','MORENA'),
  ('local_deputy','27',15,'Martha Colorado Jiménez','MORENA'),
  ('local_deputy','27',16,'Verónica Castillo Reyes','MORENA'),
  ('local_deputy','27',17,'María Félix García Álvarez','MORENA'),
  ('local_deputy','27',18,'Francisco Donaldo López Cháirez','MORENA'),
  ('local_deputy','27',19,'Gerardo Antonio Hernández Alejandro','MORENA'),
  ('local_deputy','27',20,'Reynol Chamec Ruíz','MORENA'),
  ('local_deputy','27',21,'Jorge Suárez Moreno','MORENA')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
