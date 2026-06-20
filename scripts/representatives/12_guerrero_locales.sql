-- 12_guerrero_locales.sql — 28 diputados locales de MR (LXIV Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXIV Legislatura del Congreso del Estado de Guerrero". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','12',1,'Héctor Suárez Basurto','MORENA'),
  ('local_deputy','12',2,'María Luisa Antonio de la O','MORENA'),
  ('local_deputy','12',3,'Alejandro Carabias Icaza','PVEM'),
  ('local_deputy','12',4,'Marisol Bazan Fernández','MORENA'),
  ('local_deputy','12',5,'Arturo Álvarez Angli','PVEM'),
  ('local_deputy','12',6,'Violeta Martínez Pacheco','MORENA'),
  ('local_deputy','12',7,'Carlos Eduardo Bello Solano','MORENA'),
  ('local_deputy','12',8,'Marco Tulio Sánchez Alarcón','MORENA'),
  ('local_deputy','12',9,'Joaquín Badillo Escamilla','MORENA'),
  ('local_deputy','12',10,'Vladimir Barrera Fuerte','MORENA'),
  ('local_deputy','12',11,'Leticia Rodríguez Armenta','MORENA'),
  ('local_deputy','12',12,'Rafael Martínez Ramírez','MORENA'),
  ('local_deputy','12',13,'Gladys Cortés Genchi','PVEM'),
  ('local_deputy','12',14,'Catalina Apolinar Santiago','MORENA'),
  ('local_deputy','12',15,'Guadalupe García Villalva','MORENA'),
  ('local_deputy','12',16,'Claudia Sierra Pérez','PT'),
  ('local_deputy','12',17,'Víctor Hugo Vega Hernández','PRD'),
  ('local_deputy','12',18,'Bulmaro Torres Berrum','PRI'),
  ('local_deputy','12',19,'Citlali Yaret Tellez Castillo','MORENA'),
  ('local_deputy','12',20,'Robell Uriostegui Patiño','PRI'),
  ('local_deputy','12',21,'Obdulia Naranjo Cabrera','PVEM'),
  ('local_deputy','12',22,'Luissana Ramos Pineda','MORENA'),
  ('local_deputy','12',23,'Ana Lilia Botello Figueroa','MORENA'),
  ('local_deputy','12',24,'Jorge Iván Ortega Jiménez','PRI'),
  ('local_deputy','12',25,'Jesús Parra García','PRD'),
  ('local_deputy','12',26,'Pánfilo Sánchez Almazan','PT'),
  ('local_deputy','12',27,'Aristóteles Tito Arroyo','MORENA'),
  ('local_deputy','12',28,'Edgar Ventura de la Cruz','PT')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
