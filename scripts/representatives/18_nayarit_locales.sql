-- 18_nayarit_locales.sql — 18 diputados locales de MR (XXXIV Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:XXXIV Legislatura del Congreso del Estado de Nayarit". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','18',1,'Salvador Castañeda Rangel','MORENA'),
  ('local_deputy','18',2,'Ricardo Parra Tiznado','MORENA'),
  ('local_deputy','18',3,'María Belén Muñoz Barajas','MORENA'),
  ('local_deputy','18',4,'Marisol Contreras Pérez','MORENA'),
  ('local_deputy','18',5,'Juana Nataly Tizcareño Lara','Fuerza por México'),
  ('local_deputy','18',6,'Jessica Abilene Torres Fregoso','MORENA'),
  ('local_deputy','18',7,'Georgina Guadalupe López Arias','PVEM'),
  ('local_deputy','18',8,'Hilda Zulema Montoya García','Fuerza por México'),
  ('local_deputy','18',9,'María Magdalena García Robles','MORENA'),
  ('local_deputy','18',10,'Luis Enrique Miramontes Vázquez','MORENA'),
  ('local_deputy','18',11,'Jaime Cervantes Valdez','PT'),
  ('local_deputy','18',12,'Adahan Casas Rivas','MORENA'),
  ('local_deputy','18',13,'Marisol Sánchez Navarro','PT'),
  ('local_deputy','18',14,'Luis Daniel Pérez Lerma','MORENA'),
  ('local_deputy','18',15,'Rodolfo Gómez Tadeo','MORENA'),
  ('local_deputy','18',16,'Madrid Gwendolyne Vargas Paredes','MORENA'),
  ('local_deputy','18',17,'José Gómez Pérez','PVEM'),
  ('local_deputy','18',18,'Carmina Yadira Regalado Mardueño','MORENA')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
