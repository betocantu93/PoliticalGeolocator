-- _fixes_cvegeo.sql — correcciones manuales de presidentes municipales por cvegeo.
-- Estos municipios NO machearon por JOIN de nombre (el INE los escribe con abreviaturas
-- DR./GRAL., sin espacios, o con nombre oficial distinto). Se insertan por clave INE directa.
--
-- ORDEN DE EJECUCIÓN: correr este archivo DESPUÉS de todos los XX_*_presidentes.sql.
-- Es idempotente (on conflict do update); seguro re-correr.

insert into public.representatives (role, cve_ent, cvegeo_mun, name, party) values
  -- Chiapas: INE lo escribe "VILLACOMALTITLAN" (sin espacio)
  ('municipal_president','07','07107','Gerardo Gómez Pérez','PVEM'),

  -- Nuevo León: INE usa abreviaturas (DR./GRAL.) y quita el artículo (Carmen)
  ('municipal_president','19','19010','Gerardo Alfonso de la Maza Villarreal','MC'),     -- El Carmen
  ('municipal_president','19','19014','Juan José Vargas Rosales','PRI'),                 -- Dr. Arroyo
  ('municipal_president','19','19015','José Guadalupe Ríos Ríos','MC'),                  -- Dr. Coss
  ('municipal_president','19','19016','Alejandro González Treviño','PRI'),               -- Dr. González
  ('municipal_president','19','19020','Patricia Frinee Cantú Garza','PAN'),              -- Gral. Bravo
  ('municipal_president','19','19021','Andrés Concepción Mijes Llovera','MORENA'),       -- Gral. Escobedo
  ('municipal_president','19','19022','David Jonathan Sánchez Quintanilla','MC'),        -- Gral. Terán
  ('municipal_president','19','19023','Maribel Hinojosa García','PAN'),                  -- Gral. Treviño
  ('municipal_president','19','19024','Judith Amaranta Ibarra Rodríguez','MC'),          -- Gral. Zaragoza
  ('municipal_president','19','19025','Elva Deyanira Martínez González','MORENA'),       -- Gral. Zuazua

  -- Puebla: nombre oficial INEGI largo
  ('municipal_president','21','21176','Martín de Jesús Camargo de la Peña','PRD'),       -- Tlacotepec de Benito Juárez

  -- Tlaxcala: INE escribe "ATLTZAYANCA" y "ZITLALTEPEC..." distinto
  ('municipal_president','29','29005','Luis Alberto Huerta Hernández','PAN'),            -- Atltzayanca
  ('municipal_president','29','29037','Gudelia Palma Corona','MC'),                      -- Zitlaltepec de Trinidad Sánchez Santos

  -- Veracruz: nombres INE sin sufijo / cola que WebFetch sí alcanzó
  ('municipal_president','30','30122','Jorge Luis del Ángel Delgado','MORENA'),          -- Ozuluama
  ('municipal_president','30','30047','Jorge Alberto Villegas Cázares','MORENA'),        -- Cosamaloapan
  ('municipal_president','30','30008','José Roberto Arenas Martínez','MORENA'),          -- Álamo Temapache
  ('municipal_president','30','30033','Obed Méndez Fernández','PAN'),                    -- Castillo de Teayo
  ('municipal_president','30','30108','Rafael Soto Marín','PRI'),                        -- Las Minas

  -- Stragglers de la auditoría final (name mismatch en estados que creíamos completos):
  ('municipal_president','08','08008','Eduardo Aarón Ruelas Fernández','PRI'),     -- Batopilas (INE: "Batopilas de Manuel Gómez Morín")
  ('municipal_president','08','08022','Reimon Ruíz Socarro','PT'),                 -- Dr. Belisario Domínguez
  ('municipal_president','08','08063','Omar Caleb Lazo Herrera','MORENA'),         -- Temósachi (INE: "Temosachic")
  ('municipal_president','10','10006','Silvia Rangel Orona','PRI'),                -- Villa: INE "Simón Bolívar" (yo tenía "General Simón Bolívar")
  ('municipal_president','23','23008','Angy Estefanía Mercado Asencio','MORENA'),  -- Solidaridad (INE usa la cabecera "Playa del Carmen")
  ('municipal_president','24','24056','Amada Zavala','PT'),                        -- Villa de Zaragoza (INE: "Zaragoza")

  -- Guerrero: los 2 que la fuente no traía, ambos por usos y costumbres (party null):
  ('municipal_president','12','12012','Elizabeth Calixto Leyva', null),           -- Ayutla de los Libres (Concejo Municipal Comunitario)
  ('municipal_president','12','12082','Donaciano Morales Porfirio', null)         -- Ñuu Savi (cabildo por usos y costumbres)
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
