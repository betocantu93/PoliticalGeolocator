-- 02_baja_california_locales.sql — 17 diputados locales de MR (XXV Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:XXV Legislatura del Congreso del Estado de Baja California". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','02',1,'Michelle Alejandra Tejeda Medina','MORENA'),
  ('local_deputy','02',2,'Jaime Eduardo Cantón Rocha','MORENA'),
  ('local_deputy','02',3,'Alejandra María Ang Hernández','MORENA'),
  ('local_deputy','02',4,'Liliana Michel Sánchez Allende','MORENA'),
  ('local_deputy','02',5,'Juan Manuel Molina García','MORENA'),
  ('local_deputy','02',6,'María Teresa Méndez Vélez','MORENA'),
  ('local_deputy','02',7,'Jorge Ramos Hernández','PVEM'),
  ('local_deputy','02',8,'Norma Angélica Peñaloza Escobedo','MORENA'),
  ('local_deputy','02',9,'Eligio Valencia López','MORENA'),
  ('local_deputy','02',10,'Julia Andrea González Quiroz','MORENA'),
  ('local_deputy','02',11,'Evelyn Sánchez Sánchez','MORENA'),
  ('local_deputy','02',12,'Ramón Vázquez Valadez','MORENA'),
  ('local_deputy','02',13,'Gloria Arcelia Miramontes Plantillas','MORENA'),
  ('local_deputy','02',14,'Araceli Geraldo Nuñez','MORENA'),
  ('local_deputy','02',15,'Danny Fidel Mogollón Pérez','Independiente'),
  ('local_deputy','02',16,'Diego Alejandro Lara Arregui','Fuerza por México'),
  ('local_deputy','02',17,'Dunnia Montserrat Murillo López','MORENA')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
