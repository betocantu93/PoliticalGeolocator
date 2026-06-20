-- 21_puebla_locales.sql — 26 diputados locales de MR (LXII Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXII Legislatura del Congreso del Estado de Puebla". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','21',1,'Laura Guadalupe Vargas Vargas','PVEM'),
  ('local_deputy','21',2,'Miguel Márquez Ríos','PVEM'),
  ('local_deputy','21',3,'Kathya Sánchez Rodríguez','PVEM'),
  ('local_deputy','21',4,'Esther Martínez Romano','PT'),
  ('local_deputy','21',5,'Elpidio Díaz Escobar','Fuerza por México'),
  ('local_deputy','21',6,'Floricel González Méndez','MORENA'),
  ('local_deputy','21',7,'Guadalupe Yamak Taja','MORENA'),
  ('local_deputy','21',8,'Angélica Patricia Alvarado Juárez','PT'),
  ('local_deputy','21',9,'Norma Estela Pimentel Méndez','PVEM'),
  ('local_deputy','21',10,'Jaime Natale Uranga','PVEM'),
  ('local_deputy','21',11,'Xel Arianna Hernández García','PT'),
  ('local_deputy','21',12,'José Miguel Trujillo de Ita','MORENA'),
  ('local_deputy','21',13,'Óscar Mauricio Céspedes Peregrina','PT'),
  ('local_deputy','21',14,'Elías Lozada Ortega','Nueva Alianza'),
  ('local_deputy','21',15,'Andrés Iván Villegas Mendoza','MORENA'),
  ('local_deputy','21',16,'Elvia Graciela Palomares Ramírez','MORENA'),
  ('local_deputy','21',17,'María Fernanda de la Barreda Angón','PVEM'),
  ('local_deputy','21',18,'Nayeli Salvatori Bojalil','MORENA'),
  ('local_deputy','21',19,'Roberto Zataráin Leal','MORENA'),
  ('local_deputy','21',20,'José Luis Figueroa Cortés','PT'),
  ('local_deputy','21',21,'Modesta Delgado Juárez','Fuerza por México'),
  ('local_deputy','21',22,'Azucena Rosas Tapia','MORENA'),
  ('local_deputy','21',23,'Pavel Gaspar Ramírez','MORENA'),
  ('local_deputy','21',24,'Leonela Jazmín Martínez Ayala','Nueva Alianza'),
  ('local_deputy','21',25,'Araceli Celestino Rosas','PT'),
  ('local_deputy','21',26,'Rosalío Zanatta Vidaurri','MORENA')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
