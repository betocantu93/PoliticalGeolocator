-- 03_baja_california_sur_locales.sql — 16 diputados locales de MR (XVII Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:XVII Legislatura del Congreso del Estado de Baja California Sur". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','03',1,'Alondra Torres García','PT'),
  ('local_deputy','03',2,'Dalia Verónica Collins Mendoza','MORENA'),
  ('local_deputy','03',3,'Guadalupe Vázquez Jacinto','MORENA'),
  ('local_deputy','03',4,'Sergio Guluarte Ceseña','MORENA'),
  ('local_deputy','03',5,'Sergio Polanco Salaices','MORENA'),
  ('local_deputy','03',6,'Eduardo Valentín Van Wormer Castro','MORENA'),
  ('local_deputy','03',7,'Guillermina Díaz Rodríguez','MORENA'),
  ('local_deputy','03',8,'María Cristina Contreras Rebollo','MORENA'),
  ('local_deputy','03',9,'Gabriela Montoya Terrazas','PT'),
  ('local_deputy','03',10,'Fernando Hoyos Aguilar','PT'),
  ('local_deputy','03',11,'Martín Escogido Flores','Nueva Alianza'),
  ('local_deputy','03',12,'Omar Torres Orozco','MORENA'),
  ('local_deputy','03',13,'Venustiano Pérez Sánchez','MORENA'),
  ('local_deputy','03',14,'Teresita de Jesús Valentín Vázquez','MORENA'),
  ('local_deputy','03',15,'Karina Olivas Parra','MORENA'),
  ('local_deputy','03',16,'Sergio Ricardo Huerta Leggs','MORENA')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
