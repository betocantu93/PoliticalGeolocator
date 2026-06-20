-- 09_cdmx_locales.sql — 33 diputados locales de MR (III Legislatura Congreso CDMX, 2024-2027).
-- Fuente: Wikipedia "Anexo:III Legislatura del Congreso de la Ciudad de México". Verificar.
-- Omitido: diputado migrante (distrito "M", no territorial).

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','09',1,'Alberto Martínez Urincho','MORENA'),
  ('local_deputy','09',2,'Diana Barragán Sánchez','PT'),
  ('local_deputy','09',3,'Alejandro Carbajal González','Asociación Parlamentaria Progresista'),
  ('local_deputy','09',4,'Ana Luisa Buendía García','MORENA'),
  ('local_deputy','09',5,'Víctor Hugo Romo','MORENA'),
  ('local_deputy','09',6,'Yuriri Ayala Zúñiga','MORENA'),
  ('local_deputy','09',7,'Judith Vanegas Tapia','MORENA'),
  ('local_deputy','09',8,'Adriana Espinosa de los Monteros','MORENA'),
  ('local_deputy','09',9,'Iliana Ivón Sánchez Chávez','PVEM'),
  ('local_deputy','09',10,'Israel Moreno Rivera','PVEM'),
  ('local_deputy','09',11,'Elvia Estrada Barba','PVEM'),
  ('local_deputy','09',12,'Leonor Gómez Otegui','MORENA'),
  ('local_deputy','09',13,'América Alejandra Rangel Lorenzana','PAN'),
  ('local_deputy','09',14,'Xóchitl Bravo Espinosa','MORENA'),
  ('local_deputy','09',15,'Pablo Trejo Pérez','PRD'),
  ('local_deputy','09',16,'Paula Alejandra Pérez Córdova','MORENA'),
  ('local_deputy','09',17,'Federico Chávez Semerena','PAN'),
  ('local_deputy','09',18,'Lizzette Salgado Viramontes','PAN'),
  ('local_deputy','09',19,'Daniela Gicela Álvarez Camacho','PAN'),
  ('local_deputy','09',20,'Brenda Fabiola Ruiz Aguilar','MORENA'),
  ('local_deputy','09',21,'Manuel Talayero Pariente','PVEM'),
  ('local_deputy','09',22,'Juan Rubio Gualito','PVEM'),
  ('local_deputy','09',23,'Claudia Montes de Oca Olmo','PAN'),
  ('local_deputy','09',24,'Rebeca Peralta León','PVEM'),
  ('local_deputy','09',25,'Erika Lizeth Rosales Medina','Asociación Parlamentaria Progresista'),
  ('local_deputy','09',26,'Gerardo Villanueva Albarrán','Asociación Parlamentaria Progresista'),
  ('local_deputy','09',27,'Víctor Varela López','PVEM'),
  ('local_deputy','09',28,'Martha Ávila Ventura','MORENA'),
  ('local_deputy','09',29,'Miguel Ángel Macedo Escartín','MORENA'),
  ('local_deputy','09',30,'Ricardo Rubio Torres','PAN'),
  ('local_deputy','09',31,'Valeria Cruz Flores','MORENA'),
  ('local_deputy','09',32,'María del Rosario Morales Ramos','Asociación Parlamentaria Progresista'),
  ('local_deputy','09',33,'Emilio Guijosa Hernández','MORENA')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
