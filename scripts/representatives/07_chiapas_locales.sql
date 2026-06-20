-- 07_chiapas_locales.sql — 24 diputados locales de MR (LXIX Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXIX Legislatura del Congreso del Estado de Chiapas". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','07',1,'Marcela Castillo Atristain','MORENA'),
  ('local_deputy','07',2,'María Mandiola Totoricagüena','Partido Chiapas Unido'),
  ('local_deputy','07',3,'Erika Paola Mendoza Saldaña','PVEM'),
  ('local_deputy','07',4,'Juan Manuel Utrilla Constantino','PVEM'),
  ('local_deputy','07',5,'Juan Salvador Camacho Velasco','MORENA'),
  ('local_deputy','07',6,'Luis Ignacio Avendaño Bermúdez','PT'),
  ('local_deputy','07',7,'Bertha Flores Sánchez','PVEM'),
  ('local_deputy','07',8,'José Uriel Estrada Martínez','PVEM'),
  ('local_deputy','07',9,'María Roselia Jiménez Pérez','PT'),
  ('local_deputy','07',10,'Ervin Leonel Pérez Alfaro','MORENA'),
  ('local_deputy','07',11,'Selene Josefina Sánchez Cruz','MORENA'),
  ('local_deputy','07',12,'Alejandra Gómez Mendoza','Mover a Chiapas'),
  ('local_deputy','07',13,'Getsemaní Moreno Martínez','MORENA'),
  ('local_deputy','07',14,'Maritza Molina Molina','PVEM'),
  ('local_deputy','07',15,'Faride Abud García','MORENA'),
  ('local_deputy','07',16,'Javier Jiménez Jiménez','Partido Chiapas Unido'),
  ('local_deputy','07',17,'Ismael Brito Mazariegos','PVEM'),
  ('local_deputy','07',18,'Elvira Catalina Aguiar Álvarez','PT'),
  ('local_deputy','07',19,'Freddy Escobar Sánchez','MORENA'),
  ('local_deputy','07',20,'Ana María Solís Ruiz','PT'),
  ('local_deputy','07',21,'María Isabel Rodríguez Jiménez','PES'),
  ('local_deputy','07',22,'Cuauhtémoc Manuel Hernández Gómez','Mover a Chiapas'),
  ('local_deputy','07',23,'Mario Francisco Guillén Guillén','MORENA'),
  ('local_deputy','07',24,'Flor de María Guirao Aguilar','Redes Sociales Progresistas')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
