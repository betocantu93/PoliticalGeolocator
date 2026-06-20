-- 14_jalisco_locales.sql — 20 diputados locales de MR (LXIV Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXIV Legislatura del Congreso del Estado de Jalisco". Verificar.
-- Partidos locales de Jalisco conservados: Futuro, Hagamos.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','14',1,'Sergio Miguel Martín Castellanos','PT'),
  ('local_deputy','14',2,'Julio César Hurtado Luna','PAN'),
  ('local_deputy','14',3,'Marco Tulio Moya Díaz','PAN'),
  ('local_deputy','14',4,'Tonantzin Elusay Cárdenas Méndez','Futuro'),
  ('local_deputy','14',5,'Yussara Elizabeth Canales González','PVEM'),
  ('local_deputy','14',6,'Laura Gabriela Cárdenas Rodríguez','MC'),
  ('local_deputy','14',7,'Marta Estela Arizmendi Fombona','MORENA'),
  ('local_deputy','14',8,'Priscilla Franco Barba','MC'),
  ('local_deputy','14',9,'Itzul Barrera Rodríguez','MORENA'),
  ('local_deputy','14',10,'Mónica Paola Magaña Mendoza','MC'),
  ('local_deputy','14',11,'Tonatiuh Bravo Padilla','Hagamos'),
  ('local_deputy','14',12,'Adriana Gabriela Medina Ortiz','MC'),
  ('local_deputy','14',13,'Leonardo Almaguer Castañeda','PT'),
  ('local_deputy','14',14,'Mariana Casillas Guerrero','Futuro'),
  ('local_deputy','14',15,'José Aurelio Fonseca Olivares','PRI'),
  ('local_deputy','14',16,'Alberto Alfaro García','MORENA'),
  ('local_deputy','14',17,'José Guadalupe Buenrostro Martínez','PVEM'),
  ('local_deputy','14',18,'Edgar Enrique Velázquez González','Hagamos'),
  ('local_deputy','14',19,'Alejandro Barragán Sánchez','MORENA'),
  ('local_deputy','14',20,'Valeria Guadalupe Ávila Gutiérrez','Hagamos')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
