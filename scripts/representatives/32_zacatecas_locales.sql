-- 32_zacatecas_locales.sql — 18 diputados locales de MR (LXV Legislatura, 2024-2027).
-- Fuente: Wikipedia "Anexo:LXV Legislatura del Congreso del Estado de Zacatecas". Verificar.

insert into public.representatives (role, cve_ent, distrito, name, party) values
  ('local_deputy','32',1,'Ruth Calderón Babun','MORENA'),
  ('local_deputy','32',2,'Santos Antonio González Huerta','MORENA'),
  ('local_deputy','32',3,'Ma Teresa López García','PAN'),
  ('local_deputy','32',4,'Saúl de Jesús Cordero Becerril','MORENA'),
  ('local_deputy','32',5,'Susana Andrea Barragán Espinosa','MORENA'),
  ('local_deputy','32',6,'Jesús Eduardo Badillo Méndez','PAN'),
  ('local_deputy','32',7,'Martín Álvarez Casio','MORENA'),
  ('local_deputy','32',8,'Eleuterio Ramos Leal','PRD'),
  ('local_deputy','32',9,'Georgia Fernanda Miranda Herrera','PVEM'),
  ('local_deputy','32',10,'José Luis González Orozco','MORENA'),
  ('local_deputy','32',11,'Dayanne Cruz Hernández','PRD'),
  ('local_deputy','32',12,'José David González Hernández','PRI'),
  ('local_deputy','32',13,'Imelda Mauricio Esparza','MORENA'),
  ('local_deputy','32',14,'Oscar Rafael Novella Macías','MORENA'),
  ('local_deputy','32',15,'Maribel Villalpando Haro','MORENA'),
  ('local_deputy','32',16,'Lyndiana Elizabeth Bugarín Cortés','PVEM'),
  ('local_deputy','32',17,'Jaime Manuel Esquivel Hurtado','MORENA'),
  ('local_deputy','32',18,'Jesús Padilla Estrada','MORENA')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
