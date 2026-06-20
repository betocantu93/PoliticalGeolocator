-- 24_san_luis_potosi_locales.sql — 15 diputados locales de MR (LXIV Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXIV Legislatura del Congreso del Estado de San Luis Potosí". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','24',1,'Tomás Zavala González','PT'),
  ('local_deputy','24',2,'Dulcelina Sánchez de Lira','PVEM'),
  ('local_deputy','24',3,'César Arturo Lara Rocha','PVEM'),
  ('local_deputy','24',4,'Jacquelinn Jaúregui Mendoza','PT'),
  ('local_deputy','24',5,'Rubén Guajardo Barrera','PAN'),
  ('local_deputy','24',6,'Martha Patricia Aradillas Aradillas','PVEM'),
  ('local_deputy','24',7,'Cuauhtli Fernando Badillo Moreno','MORENA'),
  ('local_deputy','24',8,'María Aránzazu Puente Bustindui','PAN'),
  ('local_deputy','24',9,'Luis Fernando Gamez Macías','PVEM'),
  ('local_deputy','24',10,'Diana Ruelas Gaitán','PT'),
  ('local_deputy','24',11,'María Leticia Vázquez Hernández','PT'),
  ('local_deputy','24',12,'José Roberto García Castillo','MORENA'),
  ('local_deputy','24',13,'Nancy Jeanine García Martínez','MORENA'),
  ('local_deputy','24',14,'Roxanna Hernández Ramírez','PVEM'),
  ('local_deputy','24',15,'Brisseire Sánchez López','PVEM')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
