-- 31_yucatan_presidentes.sql — 106 presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Yucatán (2024-2027)". Verificar.
-- Chichimilá e Izamal: elecciones extraordinarias (titular vigente desde ene-2025).
-- Varios alcaldes cambiaron a MORENA en 2025 -> se registra el partido vigente.

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Abalá','María Lorenza Ayala López','PRI'),
  ('Acanceh','Guadalupe Elizabeth Zapata González','PAN'),
  ('Akil','Iginia Adalberta Zapata Chi','PT'),
  ('Baca','Freddy Miguel Basto Basto','PVEM'),
  ('Bokobá','Yanely Gabriela Ortega Canché','MORENA'),
  ('Buctzotz','Carlos Esteban Argaez Be','MORENA'),
  ('Cacalchén','Manuel de Jesús Orozco Aké','PRI'),
  ('Calotmul','Luis Fernely Polanco Tun','PRI'),
  ('Cansahcab','Wilber Roger Llanes Chan','PT'),
  ('Cantamayec','Orlando Ek Sansores','MORENA'),
  ('Celestún','Germán Jesús Cauich Pinto','MORENA'),
  ('Cenotillo','Ángel Hermenegildo Cardóz Fernández','PAN'),
  ('Conkal','Linda Margarita Pérez Quijano','PAN'),
  ('Cuncunul','Marta Beatriz Poot Nahuat','PAN'),
  ('Cuzamá','Felipe Mario Chin Puc','PAN'),
  ('Chacsinkín','Gilmer Mariel Ku Cab','PRI'),
  ('Chankom','Concepción Tamay Noh','PAN'),
  ('Chapab','Jorge Manuel Salazar Puc','MORENA'),
  ('Chemax','Ricardo Balam Chi','PAN'),
  ('Chicxulub Pueblo','Amilcar Abricel Reyes Marín','PAN'),
  ('Chichimilá','Francisco Medina Martin','PRI'),
  ('Chikindzonot','Benito Chan Chuc','MORENA'),
  ('Chocholá','Erwin Obet Martín Alcocer','PRI'),
  ('Chumayel','Ricardo Abraham Peraza Vázquez','PVEM'),
  ('Dzán','José Antonio Pérez Cabrera','PRI'),
  ('Dzemul','José Wilberto Flota Ake','MC'),
  ('Dzidzantún','Ángel Rodulfo Guerrero Vivas','MORENA'),
  ('Dzilam de Bravo','Gerónimo Medina Trejo','MORENA'),
  ('Dzilam González','Job Joel Poot Kuk','Nueva Alianza'),
  ('Dzitás','Juan Francisco Pérez Koh','PAN'),
  ('Dzoncauich','Sergio Cohuo Zavala','PRI'),
  ('Espita','Mario Isaías Sánchez Esquivel','PVEM'),
  ('Halachó','Melba del Rosario Abraham Hoyos','PAN'),
  ('Hocabá','Víctor José Chan Cen','MORENA'),
  ('Hoctún','Miguel Octavio Arjona Sánchez','MORENA'),
  ('Homún','Joan Gregorio Góngora Suárez','PRI'),
  ('Huhí','Jaime Guadalupe Espíndola Contreras','PRI'),
  ('Hunucmá','Cristina Guadalupe del Rocío Pérez Bojórquez','PAN'),
  ('Ixil','José Vicente Coba Cocom','PT'),
  ('Izamal','Melissa Mañe Puga','MORENA'),
  ('Kanasín','Edwin José Bojórquez Ramírez','PAN'),
  ('Kantunil','William Antonio Dorantes Che','PRI'),
  ('Kaua','Carlos Gualberto Chay Canul','MORENA'),
  ('Kinchil','Irving de la Cruz Piste Canul','PVEM'),
  ('Kopomá','María Guadalupe Tut Hau','MORENA'),
  ('Mama','Daniel Oswaldo González Huchim','PAN'),
  ('Maní','Fredi Evaristo Interian Bojórquez','PAN'),
  ('Maxcanú','Camilo Fernando May Catzin','PVEM'),
  ('Mayapán','José Manuel Tun Chin','PAN'),
  ('Mérida','Cecilia Patrón Laviada','PAN'),
  ('Mocochá','Pablo Alejandro Cutz Domínguez','PRI'),
  ('Motul','Lucio Alberto Estrella Canul','PAN'),
  ('Muna','Carlos Baltazar Ayuso Vera','Nueva Alianza'),
  ('Muxupip','Rubí Yasmín Ake Chávez','MORENA'),
  ('Opichén','Ricardo Ordóñez Chan','PAN'),
  ('Oxkutzcab','Juan José Martín Fragoso','PRI'),
  ('Panabá','José Nicolás Iuit Alcocer','MORENA'),
  ('Peto','Emerio Calderón Góngora','MORENA'),
  ('Progreso','Erik Rihani González','PAN'),
  ('Quintana Roo','María Minelia de Jesús Uicab Cel','PAN'),
  ('Río Lagartos','Yesenia Osiris Loria Marfil','MORENA'),
  ('Sacalum','Luis Carlos Nájera Vázquez','PT'),
  ('Samahil','Samuel Mayen Poot','PVEM'),
  ('Sanahcat','Agustín Ernesto Moo Herrera','MORENA'),
  ('San Felipe','Felipe Antonio Marrufo López','PRI'),
  ('Santa Elena','Galdino Poot Moreno','PAN'),
  ('Seyé','Wendy Marielly Cauich Cauich','PAN'),
  ('Sinanché','Abril Abigail Palma Bacelis','PAN'),
  ('Sotuta','Gerardo Jacobo Cuxin Alfaro','PVEM'),
  ('Sucilá','Gabriela de Jesús Pool Camelo','PAN'),
  ('Sudzal','Raúl Alfredo Valencia Heredia','MORENA'),
  ('Suma','Elías Vivas Matos','Nueva Alianza'),
  ('Tahdziú','Pedro Yah Sabido','Nueva Alianza'),
  ('Tahmek','Julio César Soberanis Argüelles','PVEM'),
  ('Teabo','Aída María de Jesús Fernández Góngora','PAN'),
  ('Tecoh','Bethel Abdel Achach Rodríguez','PAN'),
  ('Tekal de Venegas','Estela Dzul Chuc','MORENA'),
  ('Tekantó','Flory Grisel Cen Balam','MORENA'),
  ('Tekax','Herve Manuel Vallejos Sansores','MORENA'),
  ('Tekit','José Antonio Sosa Hernández','PAN'),
  ('Tekom','Gloria Aracelly Cocom Can','PRI'),
  ('Telchac Pueblo','Carlos Humberto Cabrera Rivero','MORENA'),
  ('Telchac Puerto','Edmundo Alfonzo Núñez Erguera','MORENA'),
  ('Temax','Ángel Antonio Escalante González','PAN'),
  ('Temozón','Gerónimo Aguilar Canché','MORENA'),
  ('Tepakán','Rogel Ismael Gamboa Castillo','MORENA'),
  ('Tetiz','Cristian Daniel Poot Chan','PT'),
  ('Teya','Ramón Alejandro Estrella Pool','MORENA'),
  ('Ticul','Humberto Parra Sosa','MORENA'),
  ('Timucuy','José Rodrigo Muñoz Ceh','PRI'),
  ('Tinum','Evelio Mis Tun','PVEM'),
  ('Tixcacalcupul','Gabriela Puc Mis','MORENA'),
  ('Tixkokob','Miguel Esteban Rodríguez Baqueiro','PAN'),
  ('Tixméhuac','Gaspar Panti Sel','PRI'),
  ('Tixpéhual','Víctor René Lara Cauich','MORENA'),
  ('Tizimín','Carlos Adrián Quiróz Osorio','MORENA'),
  ('Tunkás','Jorge Ricardo Kuh Méndez','MORENA'),
  ('Tzucacab','Erick Fernando Ku Caamal','PVEM'),
  ('Uayma','Wilberto Armin Castillo Eliodoro','MORENA'),
  ('Ucú','Gener Ismael Pech León','MORENA'),
  ('Umán','Kenia Walldina Sauri Maradiaga','MORENA'),
  ('Valladolid','Homero Novelo Burgos','MORENA'),
  ('Xocchel','Rosalba Guadalupe Uc Zapata','MORENA'),
  ('Yaxcabá','Genri Alberto Pacab Herrera','PAN'),
  ('Yaxkukul','Carlos Jesús Uc Pech','MORENA'),
  ('Yobaín','Jesús Alberto Cool Aké','MORENA');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '31', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '31'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '31'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo)
order by m.nom_mun;
