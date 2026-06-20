-- 25_sinaloa_locales.sql — 24 diputados locales de MR (LXV Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXV Legislatura del Congreso del Estado de Sinaloa". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','25',1,'Briseida Valenzuela Buichia','PVEM'),
  ('local_deputy','25',2,'Juana Minerva Vázquez González','MORENA'),
  ('local_deputy','25',3,'César Ismael Guerrero Alarcón','MORENA'),
  ('local_deputy','25',4,'Genaro García Castro','MORENA'),
  ('local_deputy','25',5,'Antonio Menéndez de Llano Bermúdez','PVEM'),
  ('local_deputy','25',6,'Luz Verónica Aviles Rochin','MORENA'),
  ('local_deputy','25',7,'Juan Carlos Villa Romero','PVEM'),
  ('local_deputy','25',8,'Martha Yolanda Dagnino Camacho','PVEM'),
  ('local_deputy','25',9,'Ambrocio Chávez Chávez','MORENA'),
  ('local_deputy','25',10,'Guadalupe Santana Palma León','MORENA'),
  ('local_deputy','25',11,'Kristiam Alexis Espinoza García','MORENA'),
  ('local_deputy','25',12,'Nancy Yadira Santiago Marcos','MORENA'),
  ('local_deputy','25',13,'Rodolfo Valenzuela Sánchez','PVEM'),
  ('local_deputy','25',14,'Sthefany Rea Reatiga','MORENA'),
  ('local_deputy','25',15,'Arely Berenice Ruíz López','MORENA'),
  ('local_deputy','25',16,'Pedro Alonso Villegas Lobo','MORENA'),
  ('local_deputy','25',17,'Erika Rubí Martínez Rodríguez','MORENA'),
  ('local_deputy','25',18,'Serapio Vargas Ramírez','MORENA'),
  ('local_deputy','25',19,'Yeraldine Bonilla Valverde','PVEM'),
  ('local_deputy','25',20,'Karla Daniela Ulloa Rodríguez','MORENA'),
  ('local_deputy','25',21,'Carlos de Jesús Escobar Sánchez','MORENA'),
  ('local_deputy','25',22,'Rita Fierro Reyes','MORENA'),
  ('local_deputy','25',23,'Juan Carlos Patrón Rosales','MORENA'),
  ('local_deputy','25',24,'Rosario Guadalupe Sarabia Soto','MORENA')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
