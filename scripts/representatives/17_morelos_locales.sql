-- 17_morelos_locales.sql — 12 diputados locales de MR (LVI Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LVI Legislatura del Congreso del Estado de Morelos". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','17',1,'Óscar Daniel Martínez Terrazas','PAN'),
  ('local_deputy','17',2,'Andrea Valentina Guadalupe Gordillo Vega','PAN'),
  ('local_deputy','17',3,'Sergio Omar Livera Chavarría','MORENA'),
  ('local_deputy','17',4,'Guillermina Maya Rendón','MORENA'),
  ('local_deputy','17',5,'Jazmín Juana Solano López','MORENA'),
  ('local_deputy','17',6,'Rafael Reyes Reyes','MORENA'),
  ('local_deputy','17',7,'Nayla Carolina Ruíz Rodríguez','MORENA'),
  ('local_deputy','17',8,'Alberto Sánchez Ortega','PT'),
  ('local_deputy','17',9,'Alfredo Domínguez Mandujano','MORENA'),
  ('local_deputy','17',10,'Francisco Erik Sánchez Zavala','PAN'),
  ('local_deputy','17',11,'Alfonso de Jesús Sotelo Martínez','MORENA'),
  ('local_deputy','17',12,'Martha Melissa Montes de Oca Montoya','MORENA')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
