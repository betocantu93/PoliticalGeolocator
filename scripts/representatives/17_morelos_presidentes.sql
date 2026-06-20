-- 17_morelos_presidentes.sql — 36 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Morelos (2024-2027)". Verificar.
-- Cuautla y Tlalnepantla: titulares vigentes. Xoxocotla, Hueyapan, Coatetelco: usos y costumbres.

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Amacuzac','Noé Reynoso Nava','PT'),
  ('Atlatlahucan','Agustín Toledano Amaro','PAN'),
  ('Axochiapan','Marco Antonio Cuate Romero','MC'),
  ('Ayala','Nayeli Guadalupe Mares Mérida','MORENA'),
  ('Coatlán del Río','Luis Armando Jaime Maldonado','Independiente'),
  ('Cuautla','Nancy Guadalupe Echeverría Guerrero','PAN'),
  ('Cuernavaca','José Luis Urióstegui Salgado','PAN'),
  ('Emiliano Zapata','Santos Tavarez García','PVEM'),
  ('Huitzilac','César Dávila Díaz','MC'),
  ('Jantetelco','Ángel Augusto Domínguez Sánchez','PVEM'),
  ('Jiutepec','Eder Eduardo Rodríguez Casillas','PAN'),
  ('Jojutla','Alan Francisco Martínez García','MORENA'),
  ('Jonacatepec de Leandro Valle','Israel Andrade Zavala','PVEM'),
  ('Mazatepec','Gilberto Orihuela Bustos','Nueva Alianza'),
  ('Miacatlán','Francisco León y Vélez Arriaga','MORENA'),
  ('Ocuituco','René Jacobo Ortuño','MORENA'),
  ('Puente de Ixtla','Claudia Mazari Torres','MORENA'),
  ('Temixco','Israel Piña Labra','PAN'),
  ('Temoac','Valentín Lavin Romero','PVEM'),
  ('Tepalcingo','Alfredo Sánchez Vélez','MORENA'),
  ('Tepoztlán','Perseo Quiroz Rendón','Independiente'),
  ('Tetecala','Rosbelia Benítez Bello','MORENA'),
  ('Tetela del Volcán','Esaud Mendoza Solís','MC'),
  ('Tlalnepantla','Gerardo Colín','MORENA'),
  ('Tlaltizapán de Zapata','Nancy Gómez Flores','PVEM'),
  ('Tlaquiltenango','Enrique Alonso Plascencia','RSP'),
  ('Tlayacapan','Pedro Antonio Montenegro Morgado','MC'),
  ('Totolapan','Alejandro Alfaro Nolasco','PT'),
  ('Xochitepec','Roberto Gonzalo Flores Zúñiga','PRI'),
  ('Yautepec','Agustín Cornelio Alonso Mendoza','MORENA'),
  ('Yecapixtla','Heladio Rafael Sánchez Zavala','PAN'),
  ('Zacatepec','José Luis Maya Torres','Movimiento Alternativa Social'),
  ('Zacualpan de Amilpas','Marino Santibañez Alonso','MORENA'),
  ('Xoxocotla','Autoridad por usos y costumbres', null),
  ('Hueyapan','Autoridad por usos y costumbres', null),
  ('Coatetelco','Autoridad por usos y costumbres', null);

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '17', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '17'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '17'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo)
order by m.nom_mun;
