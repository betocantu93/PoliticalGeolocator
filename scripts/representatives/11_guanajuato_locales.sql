-- 11_guanajuato_locales.sql — 22 diputados locales de MR (LXVI Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXVI Legislatura del Congreso del Estado de Guanajuato". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','11',1,'Angélica Casillas Martínez','PAN'),
  ('local_deputy','11',2,'Roberto Carlos Terán Ramos','PAN'),
  ('local_deputy','11',3,'Karol Jared González Márquez','PAN'),
  ('local_deputy','11',4,'Ana María Esquivel Arrona','PAN'),
  ('local_deputy','11',5,'Aldo Iván Márquez Becerra','PAN'),
  ('local_deputy','11',6,'María Isabel Ortiz Mantilla','PAN'),
  ('local_deputy','11',7,'Rolando Fortino Alcántar Rojas','PAN'),
  ('local_deputy','11',8,'Juan Carlos Romero Hicks','PAN'),
  ('local_deputy','11',9,'Luis Ricardo Ferro Baeza','MORENA'),
  ('local_deputy','11',10,'José Salvador Tovar Vargas','PAN'),
  ('local_deputy','11',11,'Víctor Manuel Zanella Huerta','PAN'),
  ('local_deputy','11',12,'Carlos Abraham Ramos Sotomayor','MORENA'),
  ('local_deputy','11',13,'Carolina León Medina','PT'),
  ('local_deputy','11',14,'Hades Berenice Aguilar Castillo','MORENA'),
  ('local_deputy','11',15,'Antonio Chaurand Sorzano','MORENA'),
  ('local_deputy','11',16,'Martha Edith Moreno Valencia','MORENA'),
  ('local_deputy','11',17,'Luz Itzel Mendo González','PAN'),
  ('local_deputy','11',18,'Noemí Márquez Márquez','PAN'),
  ('local_deputy','11',19,'Rocío Cervantes Barba','PRI'),
  ('local_deputy','11',20,'María del Pilar Gómez Enríquez','PRD'),
  ('local_deputy','11',21,'Jorge Espadas Galván','PAN'),
  ('local_deputy','11',22,'María Eugenia García Oliveros','MORENA')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
