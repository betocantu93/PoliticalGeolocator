-- 01_aguascalientes_locales.sql — 18 diputados locales de MR (LXVI Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXVI Legislatura del Congreso del Estado de Aguascalientes". Verificar contra el congreso.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','01',1,'Amisadai Manuel Castorena Romo','PAN'),
  ('local_deputy','01',2,'María Guadalupe Mendoza Medrano','PAN'),
  ('local_deputy','01',3,'Heriberto Gallegos Serna','PRD'),
  ('local_deputy','01',4,'Beatriz Montoya Hernández','PAN'),
  ('local_deputy','01',5,'Humberto Javier Montero de Alba','PAN'),
  ('local_deputy','01',6,'Luis Salvador Alcalá Durán','PAN'),
  ('local_deputy','01',7,'Laura Patricia Ponce Luna','PAN'),
  ('local_deputy','01',8,'Adán Valdivia López','PAN'),
  ('local_deputy','01',9,'Alma Hilda Medina Macías','PRD'),
  ('local_deputy','01',10,'Nancy Jeanette Gutiérrez Ruvalcaba','PAN'),
  ('local_deputy','01',11,'Arlette Ivette Muñoz Cervantes','PAN'),
  ('local_deputy','01',12,'Lucía de León Ursua','PRI'),
  ('local_deputy','01',13,'Jedsabel Sánchez Montes','PRD'),
  ('local_deputy','01',14,'Rodrigo Cervantes Medina','PAN'),
  ('local_deputy','01',15,'Luis Guadalupe León Méndez','PAN'),
  ('local_deputy','01',16,'Emanuelle Sánchez Nájera','PRD'),
  ('local_deputy','01',17,'Salvador Maximiliano Ramírez Hernández','PAN'),
  ('local_deputy','01',18,'Mirna Rubiela Medina Ruvalcaba','PAN')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
