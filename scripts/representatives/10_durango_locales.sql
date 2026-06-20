-- 10_durango_locales.sql — 15 diputados locales de MR (LXX Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXX Legislatura del Congreso del Estado de Durango". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','10',1,'Alejandro Mójica Narváez','PAN'),
  ('local_deputy','10',2,'Sughey Adriana Torres Rodríguez','PRI'),
  ('local_deputy','10',3,'Noél Fernández Maturino','PRI'),
  ('local_deputy','10',4,'Celia Daniela Soto Hernández','PRI'),
  ('local_deputy','10',5,'Fernando Rocha Amaro','PAN'),
  ('local_deputy','10',6,'Gabriela Vázquez Chacón','PAN'),
  ('local_deputy','10',7,'Héctor Herrera Núñez','PVEM'),
  ('local_deputy','10',8,'Sandra Lilia Amaya Rosales','PVEM'),
  ('local_deputy','10',9,'Georgina Solorio García','MORENA'),
  ('local_deputy','10',10,'Alberto Alejandro Mata Valadez','MORENA'),
  ('local_deputy','10',11,'Octavio Ulises Adame de la Fuente','MORENA'),
  ('local_deputy','10',12,'Nadia Montserrat Milán Ramírez','MORENA'),
  ('local_deputy','10',13,'Flora Isela Leal Méndez','MORENA'),
  ('local_deputy','10',14,'José Osbaldo Santillán Gómez','PVEM'),
  ('local_deputy','10',15,'Iván Soto Mendia','PRI')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
