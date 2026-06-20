-- 13_hidalgo_presidentes.sql — 84 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Hidalgo (2024-2027)". Verificar.
-- Nombres INEGI largos aplicados (Pachuca de Soto, Tula de Allende, etc.).

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Acatlán','Pasiano Francisco Barranco Islas','PVEM'),
  ('Acaxochitlán','Ricardo Perea Gómez','MORENA'),
  ('Actopan','Imelda Cuéllar Cano','MORENA'),
  ('Agua Blanca de Iturbide','Héctor Alejandro Flores Hernández','PRD'),
  ('Ajacuba','Zitlaly Jazmín Zúñiga Peña','MORENA'),
  ('Alfajayucan','Julio Agustín Cruz Tuvar','MORENA'),
  ('Almoloya','María Marina Ramírez Sánchez','MORENA'),
  ('Apan','María Zorayda Robles Barrera','MORENA'),
  ('El Arenal','Jensen Benony Oropeza Pérez','PRI'),
  ('Atitalaquia','Claudia Arisbee Sandoval Ramírez','MORENA'),
  ('Atlapexco','Juan de Dios Nochebuena Hernández','PT'),
  ('Atotonilco el Grande','Elba Leticia Chapa Guerrero','PT'),
  ('Atotonilco de Tula','Yocelin Tovar Mendoza','MORENA'),
  ('Calnali','Corina Jiménez Melo','PT'),
  ('Cardonal','Karla Monserrat Hernández Cerroblanco','MC'),
  ('Cuautepec de Hinojosa','Jorge Hernández Araus','MORENA'),
  ('Chapantongo','Eligio Figueroa Chávez','PVEM'),
  ('Chapulhuacán','Nhur Amira Núñez Ponce','Nueva Alianza'),
  ('Chilcuautla','Gabriela Escamilla López','MORENA'),
  ('Eloxochitlán','Anna Laura Ibarra García','PT'),
  ('Emiliano Zapata','Nelyda Hernández Palomares','MORENA'),
  ('Epazoyucan','Carlos Montaño Rodríguez','MORENA'),
  ('Francisco I. Madero','Maricela Hernández Lugo','MORENA'),
  ('Huasca de Ocampo','Luis Felipe Lugo Salinas','MORENA'),
  ('Huautla','Jorge Alberto Hernández Cortés','PT'),
  ('Huazalingo','Vanessa Mejía Hernández','MORENA'),
  ('Huehuetla','Yaralen Cortés Mendoza','MC'),
  ('Huejutla de Reyes','José Alfredo San Román Duval','MORENA'),
  ('Huichapan','Yeymi Yadira Solís Zavala','MORENA'),
  ('Ixmiquilpan','José Emanuel Hernández Pascual','MORENA'),
  ('Jacala de Ledezma','Kendra Martínez Sánchez','Nueva Alianza'),
  ('Jaltocán','Guillermo Amador Lara','MORENA'),
  ('Juárez Hidalgo','Luis Enrique Tapia Zapata','PRD'),
  ('Lolotla','María Díaz Bustos','PRI'),
  ('Metepec','Juan Antonio Franco Ortiz','PRI'),
  ('San Agustín Metzquititlán','Germán Hernández Pérez','MORENA'),
  ('Metztitlán','Susana Rivera Cano','MORENA'),
  ('Mineral del Chico','Fernando Baltazar Monzalvo','PRD'),
  ('Mineral del Monte','Edmundo Méndez Tejeda','MORENA'),
  ('La Misión','Ibsan Israel Villeda Villeda','PRD'),
  ('Mixquiahuala de Juárez','Miguel Ángel Peña Flores','MORENA'),
  ('Molango de Escamilla','María Isabel Ramírez Mercado','Nueva Alianza'),
  ('Nicolás Flores','Nicolás González Elizalde','PAN'),
  ('Nopala de Villagrán','Diana Moreno Rea','MORENA'),
  ('Omitlán de Juárez','Martha Belem Oliver González','MORENA'),
  ('San Felipe Orizatlán','Carlos César Pérez Escamilla','PT'),
  ('Pacula','José Christian Buendía Andrade','MORENA'),
  ('Pachuca de Soto','Jorge Alberto Reyes Hernández','MORENA'),
  ('Pisaflores','Miguel Bahena Solórzano','PVEM'),
  ('Progreso de Obregón','Lorena Estrada Flores','MORENA'),
  ('Mineral de la Reforma','Eduardo Medecigo Rubio','MORENA'),
  ('San Agustín Tlaxiaca','Mario David Medina Hernández','MC'),
  ('San Bartolo Tutotepec','Ubaldo González Vargas','MORENA'),
  ('San Salvador','Norberto Martínez Cruz','MORENA'),
  ('Santiago de Anaya','Danay Saraí Ángeles Hernández','MORENA'),
  ('Santiago Tulantepec de Lugo Guerrero','María Yanet Fernández Fernández','MORENA'),
  ('Singuilucan','Yazmín Dávila López','MORENA'),
  ('Tasquillo','Alberto Basilio González','MORENA'),
  ('Tecozautla','Marisol Prieto Avendaño','MORENA'),
  ('Tenango de Doria','Martha López Patricio','MORENA'),
  ('Tepeapulco','Félix Ávila Castelán','MORENA'),
  ('Tepehuacán de Guerrero','Francisco Martínez Enríquez','MORENA'),
  ('Tepeji del Río de Ocampo','Tania Valdéz Cuellar','MORENA'),
  ('Tepetitlán','Ana Elsa Castillo Cea','PT'),
  ('Tetepango','Enrique Adrián Estrada Cortés','PVEM'),
  ('Villa de Tezontepec','Miguel Moisés González Bautista','PT'),
  ('Tezontepec de Aldama','Ana María Rivera Contreras','PAN'),
  ('Tianguistengo','Febronio Rodríguez Villegas','Nueva Alianza'),
  ('Tizayuca','Gretchen Alyne Atilano Moreno','MORENA'),
  ('Tlahuelilpan','Norma Leticia Reyes Reyes','MORENA'),
  ('Tlahuiltepa','Diana López Rangel','MORENA'),
  ('Tlanalapa','Abril Martínez Portillo','Nueva Alianza'),
  ('Tlanchinol','Gabino Hernández Vite','PAN'),
  ('Tlaxcoapan','Teresa Olivares Reyna','MORENA'),
  ('Tolcayuca','Armando Zúñiga Gutiérrez','MORENA'),
  ('Tula de Allende','Cristhian Evanivaldo Martínez Resendiz','MORENA'),
  ('Tulancingo de Bravo','Lorena García Cázares','MORENA'),
  ('Xochiatipan','Erika Hernández Ramírez','PAN'),
  ('Xochicoatlán','Erik José Ramírez Montaño','PT'),
  ('Yahualica','Francisca Lara Velázquez','MORENA'),
  ('Zacualtipán de Ángeles','Amado Pérez Hernández','PT'),
  ('Zapotlán de Juárez','Cynthia Arrellano Martínez','MORENA'),
  ('Zempoala','Francisco Sinuhe Ramírez Oviedo','Nueva Alianza'),
  ('Zimapán','Hermilio Trejo Rangel','MORENA');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '13', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '13'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

-- Verificación: municipios de Hidalgo sin presidente
select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '13'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo)
order by m.nom_mun;
