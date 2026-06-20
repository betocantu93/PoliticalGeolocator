-- 01_aguascalientes_presidentes.sql — 11 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Aguascalientes (2024-2027)". Verificar.
-- Carga por nombre + JOIN contra municipios reales (normaliza acentos/mayúsculas).

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Aguascalientes','Leonardo Montañez Castro','PAN'),
  ('Asientos','José Manuel González Mota','PRD'),
  ('Calvillo','Daniel Romo Urrutia','PAN'),
  ('Cosío','Francisco Javier Domínguez López','Independiente'),
  ('Jesús María','César Fernando Medina Cervantes','PAN'),
  ('Pabellón de Arteaga','Lucero Espinoza Vázquez','PAN'),
  ('Rincón de Romos','Erick Muro Sánchez','MORENA'),
  ('San José de Gracia','Laura Araceli González Reyes','PAN'),
  ('Tepezalá','Leticia Olivares Jiménez','PRI'),
  ('El Llano','Jorge Delgado Ibarra','MORENA'),
  ('San Francisco de los Romo','Margarita Gallegos Soto','PRI');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '01', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN'))
   = upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN'))
 and m.cve_ent = '01'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

-- Verificación: municipios de Ags sin presidente (debe salir vacío)
select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '01'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo);
