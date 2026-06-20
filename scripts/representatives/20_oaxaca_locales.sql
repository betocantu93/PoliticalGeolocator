-- 20_oaxaca_locales.sql — 25 diputados locales de MR (LXVI Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXVI Legislatura del Congreso del Estado de Oaxaca". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','20',1,'Vanessa Rubí Ojeda Mejía','MORENA'),
  ('local_deputy','20',2,'Francisco Javer Niño Hernández','MORENA'),
  ('local_deputy','20',3,'Isidro Ortega Silva','MORENA'),
  ('local_deputy','20',4,'Analy Peral Vivar','MORENA'),
  ('local_deputy','20',5,'Tania Caballero Navarro','MORENA'),
  ('local_deputy','20',6,'Dulce Belén Uribe Mendoza','PVEM'),
  ('local_deputy','20',7,'Nicolás Enrique Feria Romero','MORENA'),
  ('local_deputy','20',8,'Mauro Cruz Sánchez','Grupo Parlamentario Plural'),
  ('local_deputy','20',9,'Isaías Carranza Secundino','Fuerza por México'),
  ('local_deputy','20',10,'Raynel Ramírez Mijangos','Fuerza por México'),
  ('local_deputy','20',11,'Juan Martínez García','MORENA'),
  ('local_deputy','20',12,'Sandra Daniela Taurino Jiménez','MORENA'),
  ('local_deputy','20',13,'Haydee Irma Reyes Soto','MORENA'),
  ('local_deputy','20',14,'Elvia Gabriela Pérez López','PVEM'),
  ('local_deputy','20',15,'César David Mateos Benítez','MORENA'),
  ('local_deputy','20',16,'Iván Osael Quiroz Martínez','PVEM'),
  ('local_deputy','20',17,'Mónica Belén López Javier','Fuerza por México'),
  ('local_deputy','20',18,'Dennis García Gutiérrez','MORENA'),
  ('local_deputy','20',19,'María Francisca Antonio Santiago','MORENA'),
  ('local_deputy','20',20,'Juan Marcelino Sánchez Valdivieso','MORENA'),
  ('local_deputy','20',21,'Eva Diego Cruz','PVEM'),
  ('local_deputy','20',22,'Karla Clarissa Bornios Peláez','PVEM'),
  ('local_deputy','20',23,'Monserrat Herrera Ruíz','PVEM'),
  ('local_deputy','20',24,'Isaac López López','Fuerza por México'),
  ('local_deputy','20',25,'María Eulalia Velasco Ramírez','Fuerza por México')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
