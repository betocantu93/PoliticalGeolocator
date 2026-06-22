-- 30_veracruz_locales.sql — 30 diputados locales de MR (LXVII Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXVII Legislatura del Congreso del Estado de Veracruz". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','30',1,'Lucía Begoña Canales Barturen','MORENA'),
  ('local_deputy','30',2,'Roberto Francisco San Román Solana','MORENA'),
  ('local_deputy','30',3,'Daniel Cortina Martínez','MORENA'),
  ('local_deputy','30',4,'Imelda Garrido Alvarado','MORENA'),
  ('local_deputy','30',5,'Janeth Adanely Rodríguez Rodríguez','MORENA'),
  ('local_deputy','30',6,'Miriam García Guzmán','MORENA'),
  ('local_deputy','30',7,'Liud Herrera Félix','MORENA'),
  ('local_deputy','30',8,'Luis Vicente Aguilar Castillo','PT'),
  ('local_deputy','30',9,'Paul Martínez Marie','MORENA'),
  ('local_deputy','30',10,'Antonio Ballesteros Grayeb','MORENA'),
  ('local_deputy','30',11,'Dorheny García Cayetano','MORENA'),
  ('local_deputy','30',12,'Ramón Díaz Ávila','PT'),
  ('local_deputy','30',13,'Tanya Carola Viveros Chazaro','MORENA'),
  ('local_deputy','30',14,'Bertha Rosalía Ahued Malpica','MORENA'),
  ('local_deputy','30',15,'José Ricardo Ruíz Carmona','MORENA'),
  ('local_deputy','30',16,'Índira de Jesús Rosales San Román','PAN'),
  ('local_deputy','30',17,'Angélica Peña Martínez','PVEM'),
  ('local_deputy','30',18,'Guadalupe Vázquez González','MORENA'),
  ('local_deputy','30',19,'Juan Tress Zilli','MORENA'),
  ('local_deputy','30',20,'Igór Fidel Roji López','PVEM'),
  ('local_deputy','30',21,'Tania María Cruz Mejía','PVEM'),
  ('local_deputy','30',22,'Dulce María Hernández Tepole','PT'),
  ('local_deputy','30',23,'Felipe Pineda Barradas','MORENA'),
  ('local_deputy','30',24,'Janix Liliana Castro Muñoz','PT'),
  ('local_deputy','30',25,'Rafael Gustavo Fararoni Magaña','MORENA'),
  ('local_deputy','30',26,'Esteban Bautista Hernández','MORENA'),
  ('local_deputy','30',27,'Urbano Bautista Martínez','PVEM'),
  ('local_deputy','30',28,'Naomi Edith Gómez Santos','MORENA'),
  ('local_deputy','30',29,'Miguel Guillermo Pintos Guillen','MORENA'),
  ('local_deputy','30',30,'Ingrid Jeny Calderón Domínguez','MORENA')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
