-- 09_cdmx_alcaldes.sql — 16 alcaldes/alcaldesas de la CDMX (2024-2027).
-- En CDMX no hay presidentes municipales sino alcaldías; se cargan como
-- role='municipal_president' (el INE BGD las trae como "municipio").
-- Fuente: Wikipedia "Anexo:Alcaldes de la Ciudad de México (2024-2027)". Verificar.

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Álvaro Obregón','Javier López Casarín','PVEM'),
  ('Azcapotzalco','Nancy Marlene Núñez Reséndiz','MORENA'),
  ('Benito Juárez','Luis Mendoza Acevedo','PAN'),
  ('Coyoacán','Giovani Gutiérrez Aguilar','PAN'),
  ('Cuajimalpa de Morelos','Carlos Orvañanos Rea','PAN'),
  ('Cuauhtémoc','Alessandra Rojo de la Vega','PRI'),
  ('Gustavo A. Madero','Janecarlo Lozano Reynoso','MORENA'),
  ('Iztacalco','Lourdes Paz Reyes','MORENA'),
  ('Iztapalapa','Aleida Alavez Ruiz','MORENA'),
  ('La Magdalena Contreras','Fernando Mercado Guaida','MORENA'),
  ('Miguel Hidalgo','Mauricio Tabe Echartea','PAN'),
  ('Milpa Alta','Octavio Rivero Villaseñor','MORENA'),
  ('Tláhuac','Berenice Hernández Calderón','MORENA'),
  ('Tlalpan','Gabriela Osorio Hernández','MORENA'),
  ('Venustiano Carranza','Evelyn Parra Álvarez','MORENA'),
  ('Xochimilco','Circe Camacho Bastida','PT');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '09', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '09'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

-- Verificación: alcaldías sin titular (debe salir vacío)
select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '09'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo);
