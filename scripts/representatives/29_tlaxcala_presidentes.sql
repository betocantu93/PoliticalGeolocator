-- 29_tlaxcala_presidentes.sql — 60 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Tlaxcala (2024-2027)". Verificar.
-- Xicohtzinco y San Lucas Tecopilco: titulares vigentes (desde 2025).
-- PAC = Partido Alianza Ciudadana (local). FPM = Fuerza por México.

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Amaxac de Guerrero','Mauricio Pozos Castañón','MORENA'),
  ('Apetatitlán de Antonio Carvajal','Ernesto Azain Ávalos Marban','PAC'),
  ('Atlangatepec','Mónica Guadalupe Barranco Bizuet','MC'),
  ('Altzayanca','Luis Alberto Huerta Hernández','PAN'),
  ('Apizaco','Javier Rivera Bonilla','MORENA'),
  ('Calpulalpan','José Manuel Jiménez del Razo','MORENA'),
  ('El Carmen Tequexquitla','María Araceli Martínez Cortez','PAC'),
  ('Cuapiaxtla','Alma Lorena Escobar González','MC'),
  ('Cuaxomulco','Roman Montiel Santiago','Fuerza por México'),
  ('Chiautempan','Blanca Estela Angulo Meneses','MORENA'),
  ('Muñoz de Domingo Arenas','Héctor Prisco Fernández','MORENA'),
  ('Españita','Juan Carlos Galindo López','PVEM'),
  ('Huamantla','Juan Salvador Santos Cedillo','PVEM'),
  ('Hueyotlipan','Sostenes Esteban Bedolla Espinoza','MC'),
  ('Ixtacuixtla de Mariano Matamoros','Alberto Hernández Olivares','MORENA'),
  ('Ixtenco','Miriam Aline Lazo Caballero','MORENA'),
  ('Mazatecochco de José María Morelos','Emilio González Cortés','PVEM'),
  ('Contla de Juan Cuamatzi','Ana Ivonne Roldán Xolocotzi','PT'),
  ('Tepetitla de Lardizábal','Yoni Hernández Alvarado','PT'),
  ('Sanctórum de Lázaro Cárdenas','Iván Alejandro Alemán Juárez','Nueva Alianza'),
  ('Nanacamilpa de Mariano Arista','Aron Vargas Ángel','PAN'),
  ('Acuamanala de Miguel Hidalgo','Rogelio Pichón Luna','MC'),
  ('Natívitas','Óscar Murias Juárez','PAC'),
  ('Panotla','Ildelfonso Carro Roldán','MORENA'),
  ('San Pablo del Monte','Ana Lucía Arce Luna','PVEM'),
  ('Santa Cruz Tlaxcala','Omar Maldonado Tetlamatzi','MORENA'),
  ('Tenancingo','Emmanuel Contreras Corona','MORENA'),
  ('Teolocholco','Valentín Melendez Tecuapacho','PT'),
  ('Tepeyanco','Williams Zainos Flores','Nueva Alianza'),
  ('Terrenate','Filogonio Palafox Dorantes','MC'),
  ('Tetla de la Solidaridad','Giovanni Montiel López','MORENA'),
  ('Tetlatlahuca','Hugo Mendoza Salazar','MORENA'),
  ('Tlaxcala','Alfonso Sánchez García','MORENA'),
  ('Tlaxco','Diana Torrejón Rodríguez','MORENA'),
  ('Tocatlán','Sergio Avendaño Pérez','Fuerza por México'),
  ('Totolac','Benjamín Atonal Conde','MORENA'),
  ('Ziltlaltépec de Trinidad Sánchez Santos','Gudelia Palma Corona','MC'),
  ('Tzompantepec','Marcelino Ramos Montiel','PAC'),
  ('Xaloztoc','Elías Nava Sánchez','PAN'),
  ('Xaltocan','José Luis Hernández Vázquez','PVEM'),
  ('Papalotla de Xicohténcatl','Sergio Lara Muñoz','PRI'),
  ('Xicohtzinco','Juan Ramírez Ávalos','MORENA'),
  ('Yauhquemehcan','David Vega Terrazas','MORENA'),
  ('Zacatelco','José Miguel Acatzi Luna','PAC'),
  ('Benito Juárez','Rubén Becerra Cerón','PT'),
  ('Emiliano Zapata','Edgar Macías Moreno','PRI'),
  ('Lázaro Cárdenas','Elena Macías Díaz','PT'),
  ('La Magdalena Tlaltelulco','Rocío Claudia Melendez Pluma','Fuerza por México'),
  ('San Damián Texóloc','David Sánchez Rincón','MORENA'),
  ('San Francisco Tetlanohcan','Kritsbey Pérez Flores','PVEM'),
  ('San Jerónimo Zacualpan','Sandra Corona Padilla','MORENA'),
  ('San José Teacalco','Griselda Aguilar Macias','MORENA'),
  ('San Juan Huactzinco','Eberth Jhon Robles Ocotzi','MC'),
  ('San Lorenzo Axocomanitla','Gabriela Hernández Montiel','MORENA'),
  ('San Lucas Tecopilco','Guadalupe García Cervantes','MORENA'),
  ('Santa Ana Nopalucan','Pedro Pérez Vásquez','PT'),
  ('Santa Apolonia Teacalco','Arturo Macuilt Díaz','PRD'),
  ('Santa Catarina Ayometla','David Cortés Cuchillo','PRD'),
  ('Santa Cruz Quilehtla','Aureliano Sánchez Sánchez','PT'),
  ('Santa Isabel Xiloxoxtla','Yazmín Jiménez Rugerio','PRI');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '29', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '29'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '29'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo)
order by m.nom_mun;
