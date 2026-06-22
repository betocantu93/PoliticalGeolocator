-- 29_tlaxcala_locales.sql — 15 diputados locales de MR (LXV Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXV Legislatura del Congreso del Estado de Tlaxcala". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','29',1,'Ever Alejandro Campech Avelar','MORENA'),
  ('local_deputy','29',2,'Gabriela Hernández Islas','MORENA'),
  ('local_deputy','29',3,'Jaciel González Herrera','MORENA'),
  ('local_deputy','29',4,'Lorena Ruíz García','MORENA'),
  ('local_deputy','29',5,'María Aurora Villeda Temoltzin','RSP'),
  ('local_deputy','29',6,'Vicente Morales Pérez','MORENA'),
  ('local_deputy','29',7,'Madai Pérez Carrillo','MORENA'),
  ('local_deputy','29',8,'David Martínez del Razo','MORENA'),
  ('local_deputy','29',9,'Maribel León Cruz','PVEM'),
  ('local_deputy','29',10,'Miguel Ángel Caballero Yonca','MORENA'),
  ('local_deputy','29',11,'Anel Martínez Pérez','MORENA'),
  ('local_deputy','29',12,'Bladimir Zainos Flores','Nueva Alianza'),
  ('local_deputy','29',13,'Emilio de la Peña Aponte','MORENA'),
  ('local_deputy','29',14,'Brenda Cecilia Villantes Rodríguez','MORENA'),
  ('local_deputy','29',15,'María Ana Bertha Mastranzo Corona','MORENA')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
