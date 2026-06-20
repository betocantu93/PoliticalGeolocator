-- 12_guerrero_presidentes.sql — presidentes municipales (2024-2027).
-- Fuente: Wikipedia "Anexo:Presidentes municipales de Guerrero (2024-2027)". Verificar.
-- ⚠️ El origen dio 83 de 85; faltan municipios nuevos (p.ej. Ñuu Savi) -> revisar verificación.
-- Nombres INEGI largos aplicados (Acapulco de Juárez, Chilpancingo de los Bravo, etc.).
-- Casos especiales: Copala (suplente, sin partido), San Nicolás (vacante 2024).

begin;

create temp table tmp_pm (nom text, name text, party text);

insert into tmp_pm (nom, name, party) values
  ('Acapulco de Juárez','Abelina López Rodríguez','MORENA'),
  ('Ahuacuotzingo','Pedro Ojeda Reyes','PRD'),
  ('Ajuchitlán del Progreso','Víctor Mendoza Navarro','PRI'),
  ('Alcozauca de Guerrero','Crispin Agustín Mendoza','Partido del Bienestar'),
  ('Alpoyeca','Grahube de Jesús Rosales','PVEM'),
  ('Apaxtla','Juan Salgado Santana','PT'),
  ('Arcelia','Ángel Bustos Mercado','PRI'),
  ('Atenango del Río','Emmanuel Guevara Cárdenas','PT'),
  ('Atlamajalcingo del Monte','Eulalio Madrid Simón','PT'),
  ('Atlixtac','Guillermo Matías Marrón','PVEM'),
  ('Atoyac de Álvarez','Clara Elizabeth Bello Ríos','MORENA'),
  ('Azoyú','Luis Justo Bautista','PRD'),
  ('Benito Juárez','Juan Carlos Aguilar Sandoval','PT'),
  ('Buenavista de Cuéllar','María Dolores Nava Benítez','PT'),
  ('Coahuayutla de José María Izazaga','Jovani Martínez Menera','MORENA'),
  ('Cocula','Raymond Román Alarcón','PRI'),
  ('Copala','María del Rosario Zúñiga de la Rosa','Independiente'),
  ('Copalillo','Jesús Linares Trinidad','Sustentabilidad Guerrerense'),
  ('Copanatoyac','Constancio Sánchez Campos','MORENA'),
  ('Coyuca de Benítez','Víctor Hugo Catalán Díaz','MORENA'),
  ('Coyuca de Catalán','María Esbeydi Echeverría García','PRD'),
  ('Cuajinicuilapa','Hildeberto Salinas Mariche','PVEM'),
  ('Cualác','Jessica Moreno Nájera','PT'),
  ('Cuautepec','Dagoberto Gutiérrez Domínguez','PT'),
  ('Cuetzala del Progreso','José Luis Aparicio Villanueva','MORENA'),
  ('Cutzamala de Pinzón','Mayte Lucero Arce Jaimes','PRI'),
  ('Chilapa de Álvarez','Mercedes Carballo Chino','PRI'),
  ('Chilpancingo de los Bravo','Gustavo Alarcón Herrera','PRI'),
  ('Florencio Villarreal','Rodolfo Arrasola Martínez','PESOL'),
  ('General Canuto A. Neri','Eleuterio Aranda Salgado','MC'),
  ('General Heliodoro Castillo','Alberto Mejía Barrera','MORENA'),
  ('Huamuxtitlán','Daniel Méndez Flores','MC'),
  ('Huitzuco de los Figueroa','Eder Nájera Nájera','MORENA'),
  ('Iguala de la Independencia','Erik Catalán Rendón','PVEM'),
  ('Igualapa','Alfredo González Nicolás','Partido del Bienestar'),
  ('Ixcateopan de Cuauhtémoc','Juan Carlos Rodríguez Barrera','PAN'),
  ('Zihuatanejo de Azueta','Lizette Tapia Castro','PRI'),
  ('Juan R. Escudero','Gustavo Gatica Navarrete','PVEM'),
  ('Leonardo Bravo','Leonardo Maldonado Zúñiga','MORENA'),
  ('Malinaltepec','Jhon Navarro Mateos','PT'),
  ('Mártir de Cuilapan','Jesús Vázquez García','PRD'),
  ('Metlatónoc','Marvin Rojas Ramírez','Independiente'),
  ('Mochitlán','Gerardo Mosso López','PVEM'),
  ('Olinalá','Manuel Sánchez Rosendo','PRI'),
  ('Ometepec','Rigoberto Chacon Melo','MORENA'),
  ('Pedro Ascencio Alquisiras','Austreberta López Rogel','PRD'),
  ('Petatlán','José Popoca Martínez','MORENA'),
  ('Pilcaya','Fernando Ávila Zagal','PVEM'),
  ('Pungarabato','Brenda Janeth Núñez Peñaloza','PRI'),
  ('Quechultenango','David Astudillo Morales','PRD'),
  ('San Luis Acatlán','Adair Hernández Martínez','PT'),
  ('San Marcos','Misael Lorenzo Castillo','PVEM'),
  ('San Miguel Totolapan','Arturo Julián Gómez','PRI'),
  ('Taxco de Alarcón','Juan Andrés Vega Carranza','MORENA'),
  ('Tecoanapa','Juvenal Poblete Velázquez','PVEM'),
  ('Técpan de Galeana','Alba Iris Soberanis Hernández','PVEM'),
  ('Teloloapan','Narvel Mojica Sotelo','PRD'),
  ('Tepecoacuilco de Trujano','Julio Alberto Galarza Castro','PAN'),
  ('Tetipac','Rita Patiño Muñóz','PVEM'),
  ('Tixtla de Guerrero','Alberto Michi Campos','PRI'),
  ('Tlacoachistlahuaca','Emmanuel Cuevas Rodríguez','PVEM'),
  ('Tlacoapa','Alfredo Cantú Faustino','PVEM'),
  ('Tlalchapa','Tania Mora Eguiluz','MORENA'),
  ('Tlalixtaquilla de Maldonado','Jerónimo Maldonado Vera','MC'),
  ('Tlapa de Comonfort','Gilberto Solano Arreaga','PRD'),
  ('Tlapehuala','José Luis Antunez Goicochea','PRI'),
  ('La Unión de Isidoro Montes de Oca','José Francisco Suazo Espino','PRD'),
  ('Xalpatláhuac','Ramón Lorenzo Cárdenas','MC'),
  ('Xochihuehuetlán','Juan Rivera Fructuoso','MORENA'),
  ('Xochistlahuaca','María Rojas Pineda','MORENA'),
  ('Zapotitlán Tablas','Crescenciano Cruz Candia','PT'),
  ('Zirándaro','Jaime Torres García','PRD'),
  ('Zitlala','Khalia Areli Ramos Decena','PRD'),
  ('Eduardo Neri','Sara Salinas Bravo','PT'),
  ('Acatepec','Ángel Aguilar Romero','MORENA'),
  ('José Joaquín de Herrera','Micaela Manzano Martínez','PVEM'),
  ('Iliatenco','Gerardo Olivera Raymundo','MC'),
  ('Cochoapa el Grande','Javier Gálvez García','PT'),
  ('Marquelia','Javier Tacuba Salas','PT'),
  ('Juchitán','Ana Lenis Reséndiz Javier','PAN'),
  ('Las Vigas','Leopoldina Cruz Ventura','MORENA'),
  ('San Nicolás','Ayuntamiento vacante (2024)', null),
  ('Santa Cruz del Rincón','Said Olguin Mendoza','PT');

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
select 'municipal_president', '12', m.cvegeo, t.name, t.party
from tmp_pm t
join public.municipalities m
  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')
 and m.cve_ent = '12'
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;

commit;

-- Verificación: municipios de Guerrero sin presidente (esperados: los 2 faltantes del
-- origen + cualquier nombre INEGI que no haya macheado). Pásamelos para cerrarlos.
select m.cvegeo, m.nom_mun
from public.municipalities m
where m.cve_ent = '12'
  and not exists (select 1 from public.representatives r
                  where r.role='municipal_president' and r.cvegeo_mun = m.cvegeo)
order by m.nom_mun;
