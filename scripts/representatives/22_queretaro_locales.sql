-- 22_queretaro_locales.sql — 15 diputados locales de MR (LXI Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXI Legislatura del Congreso del Estado de Querétaro". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','22',1,'Laura Andrea Tovar Saavedra','MORENA'),
  ('local_deputy','22',2,'Homero Barrera McDonald','MORENA'),
  ('local_deputy','22',3,'Arturo Maximiliano García Pérez','MORENA'),
  ('local_deputy','22',4,'Claudia Díaz Gayou','PT'),
  ('local_deputy','22',5,'Juliana Rosario Hernández Quintanar','PAN'),
  ('local_deputy','22',6,'Mauricio Cárdenas Palacios','PAN'),
  ('local_deputy','22',7,'Ulises Gómez de la Rosa','MORENA'),
  ('local_deputy','22',8,'Luis Antonio Zapata Guerrero','PAN'),
  ('local_deputy','22',9,'María Georgina Guzmán Álvarez','PVEM'),
  ('local_deputy','22',10,'Edgar Inzunza Ballesteros','MORENA'),
  ('local_deputy','22',11,'Guillermo Vega Guerrero','PAN'),
  ('local_deputy','22',12,'Sully Yanira Mauricio Sixtos','MORENA'),
  ('local_deputy','22',13,'Alejandrina Verónica Galicia Castañón','PAN'),
  ('local_deputy','22',14,'Eric Silva Hernández','MORENA'),
  ('local_deputy','22',15,'María Blanca Flor Benítez Estrada','MORENA')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
