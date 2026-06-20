-- 16_michoacan_locales.sql — 24 diputados locales de MR (LXXVI Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXXVI Legislatura del Congreso del Estado de Michoacán". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','16',1,'Melba Edeyanira Albavera Padilla','MORENA'),
  ('local_deputy','16',2,'Belinda Iturbide Díaz','MORENA'),
  ('local_deputy','16',3,'Jaqueline Áviles Osorio','MORENA'),
  ('local_deputy','16',4,'Alfredo Anaya Orozco','PVEM'),
  ('local_deputy','16',5,'Eréndira Isauro Hernández','MORENA'),
  ('local_deputy','16',6,'David Martínez Gowman','PVEM'),
  ('local_deputy','16',7,'Alejandro Iván Arévalo Vera','MORENA'),
  ('local_deputy','16',8,'Baltazar Gaona García','PT'),
  ('local_deputy','16',9,'José Antonio Salas Valencia','PAN'),
  ('local_deputy','16',10,'Marco Polo Aguirre Chávez','PVEM'),
  ('local_deputy','16',11,'Giulianna Bugarini Torres','MORENA'),
  ('local_deputy','16',12,'Ana Belinda Hurtado Marín','PT'),
  ('local_deputy','16',13,'Emma Rivera Camacho','MORENA'),
  ('local_deputy','16',14,'Conrado Paz Torres','PRD'),
  ('local_deputy','16',15,'Antonio Salvador Mendoza Torres','MORENA'),
  ('local_deputy','16',16,'Juan Carlos Barragán Vélez','MORENA'),
  ('local_deputy','16',17,'Nalleli Julieta Pedraza Huerta','MORENA'),
  ('local_deputy','16',18,'Anabet Franco Carrizales','MORENA'),
  ('local_deputy','16',19,'Vicente Gómez Núñez','MORENA'),
  ('local_deputy','16',20,'Carlos Alejandro Bautista Tafolla','Independiente'),
  ('local_deputy','16',21,'Abraham Espinoza Villa','PVEM'),
  ('local_deputy','16',22,'J. Reyes Galindo Pedraza','PT'),
  ('local_deputy','16',23,'Sandra Olimpia Garibay Esquivel','MORENA'),
  ('local_deputy','16',24,'María Itze Camacho Zapiain','MORENA')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
