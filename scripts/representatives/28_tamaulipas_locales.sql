-- 28_tamaulipas_locales.sql — 22 diputados locales de MR (LXVI Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXVI Legislatura del Congreso del Estado de Tamaulipas". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','28',1,'Gabriela Regalado Fuentes','MORENA'),
  ('local_deputy','28',2,'Ana Laura Huerta Valdovinos','PVEM'),
  ('local_deputy','28',3,'Sergio Arturo Ojeda Castillo','MORENA'),
  ('local_deputy','28',4,'Marco Antonio Gallegos Galván','MORENA'),
  ('local_deputy','28',5,'Guillermina Magaly Deandar Robinson','MORENA'),
  ('local_deputy','28',6,'Eva Araceli Reyes González','MORENA'),
  ('local_deputy','28',7,'Humberto Armando Prieto Herrera','MORENA'),
  ('local_deputy','28',8,'Francisca Castro Armenta','MORENA'),
  ('local_deputy','28',9,'Eliphaleth Gómez Lozano','PT'),
  ('local_deputy','28',10,'Víctor Manuel García Fuentes','MORENA'),
  ('local_deputy','28',11,'Elvia Eguía Castillo','MORENA'),
  ('local_deputy','28',12,'Isidro Jesús Vargas Fernández','MORENA'),
  ('local_deputy','28',13,'Silvia Isabel Chávez Garay','MORENA'),
  ('local_deputy','28',14,'Blanca Aurelia Anzaldua Nájera','MORENA'),
  ('local_deputy','28',15,'Judith Katalyna Méndez Cepeda','MORENA'),
  ('local_deputy','28',16,'Francisco Hernández Niño','MORENA'),
  ('local_deputy','28',17,'Alberto Moctezuma Castillo','MORENA'),
  ('local_deputy','28',18,'Marcelo Abundiz Ramírez','MORENA'),
  ('local_deputy','28',19,'Cynthia Lizabeth Jaime Castillo','MORENA'),
  ('local_deputy','28',20,'Claudio Alberto de Leija Hinojosa','MORENA'),
  ('local_deputy','28',21,'Úrsula Patricia Salazar Mojica','MORENA'),
  ('local_deputy','28',22,'José Abdo Schekaiban Ongay','PAN')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
