-- 31_yucatan_locales.sql — 21 diputados locales de MR (LXIV Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXIV Legislatura del Congreso del Estado de Yucatán". Verificar.
-- Nota: Yucatán pasó a 21 distritos locales de MR.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','31',1,'Daniel Enrique González Quintal','MORENA'),
  ('local_deputy','31',2,'Ángel David Valdez Jiménez','PAN'),
  ('local_deputy','31',3,'María Teresa Boehm Calero','PAN'),
  ('local_deputy','31',4,'Claudia Estefanía Baeza Martínez','MORENA'),
  ('local_deputy','31',5,'Noami Raquel Peniche López','MORENA'),
  ('local_deputy','31',6,'Clara Paola Rosales Montiel','MORENA'),
  ('local_deputy','31',7,'José Julián Bustillos Medina','MORENA'),
  ('local_deputy','31',8,'Bayardo Ojeda Marrufo','MORENA'),
  ('local_deputy','31',9,'Sayda Melina Rodríguez Gómez','PAN'),
  ('local_deputy','31',10,'Samuel de Jesús Gasca Lizama','MORENA'),
  ('local_deputy','31',11,'Alba Cristina Cob Cortés','MORENA'),
  ('local_deputy','31',12,'Mario Alejandro Cuevas Mena','MORENA'),
  ('local_deputy','31',13,'Rafael Germán Quintal Medina','MORENA'),
  ('local_deputy','31',14,'María Esther Magadan Alonzo','MORENA'),
  ('local_deputy','31',15,'Eric Edgardo Quijano González','MORENA'),
  ('local_deputy','31',16,'Maribel del Rosario Chuc Ayala','MORENA'),
  ('local_deputy','31',17,'Wilmer Manuel Monforte Marfil','MORENA'),
  ('local_deputy','31',18,'Melba Rosana Gamboa Ávila','PAN'),
  ('local_deputy','31',19,'Welber Dzul Canul','MORENA'),
  ('local_deputy','31',20,'Ayde Verónica Interian Argüello','MORENA'),
  ('local_deputy','31',21,'Neyda Aracelly Pat Dzul','MORENA')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
