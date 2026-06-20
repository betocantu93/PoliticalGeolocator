-- 06_colima_locales.sql — 16 diputados locales de MR (LXI Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXI Legislatura del Congreso del Estado de Colima". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','06',1,'José Manuel Romero Coello','PVEM'),
  ('local_deputy','06',2,'Priscila García Delgado','PT'),
  ('local_deputy','06',3,'Glenda Yazmin Ochoa','MORENA'),
  ('local_deputy','06',4,'Álvaro Lozano González','MORENA'),
  ('local_deputy','06',5,'Karen Judith Jurado Escamilla','MORENA'),
  ('local_deputy','06',6,'Hilda Lizette Moreno Ceballos','PRI'),
  ('local_deputy','06',7,'Sofía Peralta Ferro','PAN'),
  ('local_deputy','06',8,'Evangelina Bustamante Morales','PT'),
  ('local_deputy','06',9,'Diana Xally Yael Zepeda Figueroa','MORENA'),
  ('local_deputy','06',10,'Juan Carlos Rendón García','MORENA'),
  ('local_deputy','06',11,'Andrea Carolina Heredia Torres','PT'),
  ('local_deputy','06',12,'Héctor Gustavo Larios Uribe','MORENA'),
  ('local_deputy','06',13,'Isamar Ramírez Rodríguez','MORENA'),
  ('local_deputy','06',14,'Andrea Naranjo Alcaraz','PVEM'),
  ('local_deputy','06',15,'Yommira Jockimber Carrillo Barreto','MORENA'),
  ('local_deputy','06',16,'Irma Mirella Martínez Silva','MORENA')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
