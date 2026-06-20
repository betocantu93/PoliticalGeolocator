-- 13_hidalgo_locales.sql — 18 diputados locales de MR (LXVI Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXVI Legislatura del Congreso de Hidalgo". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','13',1,'Alhely Medina Hernández','MORENA'),
  ('local_deputy','13',2,'José María Alejandro Pérez Ramírez','Nueva Alianza'),
  ('local_deputy','13',3,'Julián Nochebuena Hernández','MORENA'),
  ('local_deputy','13',4,'Paloma Barragán Santos','MORENA'),
  ('local_deputy','13',5,'Cynthia Citalli Delgado Mendoza','MORENA'),
  ('local_deputy','13',6,'Alma Rosa Elías Paso','MORENA'),
  ('local_deputy','13',7,'Diana Rangel Zúñiga','MORENA'),
  ('local_deputy','13',8,'Miguel Ángel Moreno Zamora','MORENA'),
  ('local_deputy','13',9,'Yarabi González Martínez','Nueva Alianza'),
  ('local_deputy','13',10,'Lizbeth Iraís Ordaz Islas','MORENA'),
  ('local_deputy','13',11,'Arturo Gómez Canales','MORENA'),
  ('local_deputy','13',12,'Tania Eréndira Meza Escorza','MORENA'),
  ('local_deputy','13',13,'Andrés Velázquez Vázquez','MORENA'),
  ('local_deputy','13',14,'José Luis Rodríguez Higareda','MORENA'),
  ('local_deputy','13',15,'Aldo Meza Hernández','MORENA'),
  ('local_deputy','13',16,'Juan Pablo Escalante Urban','Nueva Alianza'),
  ('local_deputy','13',17,'Hilda Miranda Miranda','MORENA'),
  ('local_deputy','13',18,'Mónica Leanett Reyes Martínez','Nueva Alianza')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
