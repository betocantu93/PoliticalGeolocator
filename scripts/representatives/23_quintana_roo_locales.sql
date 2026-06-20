-- 23_quintana_roo_locales.sql — 15 diputados locales de MR (XVIII Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:XVIII Legislatura del Congreso del Estado de Quintana Roo". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','23',1,'Wilbert Alberto Batun Chulim','MORENA'),
  ('local_deputy','23',2,'Andrea del Rosario González Loria','MORENA'),
  ('local_deputy','23',3,'Rubén Antonio Carrillo Buenfil','PT'),
  ('local_deputy','23',4,'Alexa Murguia Trujillo','PVEM'),
  ('local_deputy','23',5,'Hugo Alday Nieto','PT'),
  ('local_deputy','23',6,'Paola Elizabeth Moreno Cordova','MORENA'),
  ('local_deputy','23',7,'Eric Arcila Arjona','MORENA'),
  ('local_deputy','23',8,'María Jimena Pamela Lasa Aguilar','MORENA'),
  ('local_deputy','23',9,'Euterpe Alicia Gutiérrez Valasis','MORENA'),
  ('local_deputy','23',10,'María José Osorio Rosas','PVEM'),
  ('local_deputy','23',11,'Renán Eduardo Sánchez Tajonar','PVEM'),
  ('local_deputy','23',12,'Silvia Dzul Sánchez','MORENA'),
  ('local_deputy','23',13,'José María Chacón Chablé','MORENA'),
  ('local_deputy','23',14,'Diana Frine Gutiérrez García','PT'),
  ('local_deputy','23',15,'Saulo Aguilar Bernés','MORENA')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
