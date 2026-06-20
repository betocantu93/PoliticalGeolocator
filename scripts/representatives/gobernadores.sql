-- gobernadores.sql — los 32 gobernadores en funciones (junio 2026).
-- Fuente: Wikipedia "Anexo:Gobernantes de las entidades federativas de México".
--   -> Verificar contra portales estatales antes de producción.
-- Nota: Sinaloa (25) es gobernadora INTERINA (designada por el Congreso, may-2026).

insert into public.representatives (role, cve_ent, name, party) values
  ('governor','01','María Teresa Jiménez Esquivel','PAN'),
  ('governor','02','Marina del Pilar Ávila Olmeda','MORENA'),
  ('governor','03','Víctor Manuel Castro Cosío','MORENA'),
  ('governor','04','Layda Elena Sansores San Román','MORENA'),
  ('governor','05','Manolo Jiménez Salinas','PRI'),
  ('governor','06','Indira Vizcaíno Silva','MORENA'),
  ('governor','07','Óscar Eduardo Ramírez Aguilar','MORENA'),
  ('governor','08','María Eugenia Campos Galván','PAN'),
  ('governor','09','Clara Marina Brugada Molina','MORENA'),
  ('governor','10','Esteban Alejandro Villegas Villarreal','PRI'),
  ('governor','11','Libia Dennise García Muñoz Ledo','PAN'),
  ('governor','12','Evelyn Cecia Salgado Pineda','MORENA'),
  ('governor','13','Julio Ramón Menchaca Salazar','MORENA'),
  ('governor','14','Jesús Pablo Lemus Navarro','MC'),
  ('governor','15','Delfina Gómez Álvarez','MORENA'),
  ('governor','16','Alfredo Ramírez Bedolla','MORENA'),
  ('governor','17','Margarita González Saravia Calderón','MORENA'),
  ('governor','18','Miguel Ángel Navarro Quintero','MORENA'),
  ('governor','19','Samuel Alejandro García Sepúlveda','MC'),
  ('governor','20','Salomón Jara Cruz','MORENA'),
  ('governor','21','Alejandro Armenta Mier','MORENA'),
  ('governor','22','Mauricio Kuri González','PAN'),
  ('governor','23','María Elena Hermelinda Lezama Espinosa','MORENA'),
  ('governor','24','José Ricardo Gallardo Cardona','PVEM'),
  ('governor','25','Yeraldine Bonilla Valverde','MORENA'),
  ('governor','26','Francisco Alfonso Durazo Montaño','MORENA'),
  ('governor','27','Javier May Rodríguez','MORENA'),
  ('governor','28','Américo Villarreal Anaya','MORENA'),
  ('governor','29','Lorena Cuéllar Cisneros','MORENA'),
  ('governor','30','Norma Rocío Nahle García','MORENA'),
  ('governor','31','Joaquín Jesús Díaz Mena','MORENA'),
  ('governor','32','David Monreal Ávila','MORENA')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
