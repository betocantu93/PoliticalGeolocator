-- 05_coahuila_locales.sql — 16 diputados locales de MR (LXIII Legislatura, 2024-2026).
-- Fuente: Wikipedia "Anexo:LXIII Legislatura del Congreso del Estado de Coahuila". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','05',1,'Claudia Aldrete García','PAN'),
  ('local_deputy','05',2,'Guillermo Sánchez García','PRD'),
  ('local_deputy','05',3,'Sergio Zenón Velázquez Vázquez','PRI'),
  ('local_deputy','05',4,'María Guadalupe Oyervides Valdés','PRI'),
  ('local_deputy','05',5,'Alfredo Paredes López','PAN'),
  ('local_deputy','05',6,'Edith Hernández Sillas','PAN'),
  ('local_deputy','05',7,'Raúl Onofre Contreras','PRI'),
  ('local_deputy','05',8,'Gerardo Aguado Gómez','PAN'),
  ('local_deputy','05',9,'Blanca Lamas','PAN'),
  ('local_deputy','05',10,'Héctor Hugo Dávila Prado','PRI'),
  ('local_deputy','05',11,'Olivia Martínez Leyva','PRI'),
  ('local_deputy','05',12,'Edna Davalos Elizondo','PRI'),
  ('local_deputy','05',13,'Luz Elena Guadalupe Morales Núñez','PRI'),
  ('local_deputy','05',14,'María Bárbara Cepeda Boehringer','PRI'),
  ('local_deputy','05',15,'Beatriz Eugenia Fraustro Dávila','PRD'),
  ('local_deputy','05',16,'Álvaro Moreira Valdés','PRI')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
