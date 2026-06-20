-- 04_campeche_locales.sql — 21 diputados locales de MR (LXV Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXV Legislatura del Congreso del Estado de Campeche". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','04',1,'Paul Alfredo Arce Ontiveros','MC'),
  ('local_deputy','04',2,'Ignacio José Muñóz Hernández','MC'),
  ('local_deputy','04',3,'Hipsi Marisol Estrella Guillermo','MC'),
  ('local_deputy','04',4,'Aldo Román Contreras Uc','MC'),
  ('local_deputy','04',5,'Mónica Fernández Montufar','MC'),
  ('local_deputy','04',6,'Diana Luisa Aguilar Ruelas','MC'),
  ('local_deputy','04',7,'Omar Talango Cervantes','MORENA'),
  ('local_deputy','04',8,'Francisca Zárate López','MORENA'),
  ('local_deputy','04',9,'Jorge Pérez Falconi','MORENA'),
  ('local_deputy','04',10,'Dalila del Carmen Mata Pérez','MORENA'),
  ('local_deputy','04',11,'Ismael López Garcés','MORENA'),
  ('local_deputy','04',12,'Gladys Sofía Rivera López','MORENA'),
  ('local_deputy','04',13,'Abigail Gutiérrez Morales','PT'),
  ('local_deputy','04',14,'Ena América García García','MORENA'),
  ('local_deputy','04',15,'Balbina Alejandra Hidalgo Zavala','MORENA'),
  ('local_deputy','04',16,'Elías Noé Baeza Ake','MORENA'),
  ('local_deputy','04',17,'Mayda Aracely Mas Tun','MORENA'),
  ('local_deputy','04',18,'Miguel Ángel Pool Alpuche','PRI'),
  ('local_deputy','04',19,'Gaspar de Jesús Nah Miss','MORENA'),
  ('local_deputy','04',20,'Daher Antonio Puch Rivera','MORENA'),
  ('local_deputy','04',21,'María del Carmen Ávalos Trujillo','PVEM')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
