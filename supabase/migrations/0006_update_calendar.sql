-- 0006_update_calendar.sql
-- Tablero de control del mantenimiento: qué cargo se renueva y cuándo.
-- No afecta a resolve_coordinate; es operativa. La query del runbook (OPERATIONS.md)
-- la consulta para saber qué actualizar cada trimestre.

create table if not exists public.update_calendar (
  id            bigint generated always as identity primary key,
  cargo_type    text not null check (cargo_type in
                  ('governor','federal_deputy','local_deputy','municipal_president')),
  cve_ent       text,                 -- null = nacional (diputados federales)
  next_election date,                 -- jornada que renueva el cargo (señal principal)
  term_end      date,                 -- fin de periodo aprox (opcional)
  source_url    text,
  notes         text,
  last_updated  date
);

create index if not exists ix_calendar_next on public.update_calendar (next_election);

-- ---------------------------------------------------------------------------
-- Seed del calendario electoral conocido (verificar fechas exactas en el INE).
-- Gobernadores: año de próxima elección según el ciclo en que fueron electos.
-- ---------------------------------------------------------------------------

-- Diputados federales: cada 3 años, nacional.
insert into public.update_calendar (cargo_type, cve_ent, next_election, source_url, notes)
values ('federal_deputy', null, date '2027-06-06',
        'https://web.diputados.gob.mx/inicio/tusDiputados',
        'Toda la cámara (300 MR) se renueva el 1-sep del año electoral');

-- Gobernadores por ciclo (próxima elección):
--   2027: electos en 2021    | 2028: electos en 2022
--   2029: electos en 2023    | 2030: electos en 2024
insert into public.update_calendar (cargo_type, cve_ent, next_election, notes) values
  -- Próxima elección 2027 (15 estados)
  ('governor','02',date '2027-06-06',null),('governor','03',date '2027-06-06',null),
  ('governor','04',date '2027-06-06',null),('governor','06',date '2027-06-06',null),
  ('governor','08',date '2027-06-06',null),('governor','12',date '2027-06-06',null),
  ('governor','16',date '2027-06-06',null),('governor','18',date '2027-06-06',null),
  ('governor','19',date '2027-06-06',null),('governor','22',date '2027-06-06',null),
  ('governor','24',date '2027-06-06',null),('governor','25',date '2027-06-06','interina en funciones; verificar'),
  ('governor','26',date '2027-06-06',null),('governor','29',date '2027-06-06',null),
  ('governor','32',date '2027-06-06',null),
  -- Próxima elección 2028 (6 estados)
  ('governor','01',date '2028-06-04',null),('governor','10',date '2028-06-04',null),
  ('governor','13',date '2028-06-04',null),('governor','20',date '2028-06-04',null),
  ('governor','23',date '2028-06-04',null),('governor','28',date '2028-06-04',null),
  -- Próxima elección 2029 (2 estados)
  ('governor','05',date '2029-06-03',null),('governor','15',date '2029-06-03',null),
  -- Próxima elección 2030 (9 estados)
  ('governor','07',date '2030-06-02',null),('governor','09',date '2030-06-02',null),
  ('governor','11',date '2030-06-02',null),('governor','14',date '2030-06-02',null),
  ('governor','17',date '2030-06-02',null),('governor','21',date '2030-06-02',null),
  ('governor','27',date '2030-06-02',null),('governor','30',date '2030-06-02',null),
  ('governor','31',date '2030-06-02',null);

-- Locales y municipales: calendario POR ESTADO (muchos coinciden con la federal o
-- con la gubernatura, pero no todos). Se siembra solo lo verificado (Sonora 2027);
-- el resto se completa al investigar cada estado.
insert into public.update_calendar (cargo_type, cve_ent, next_election, source_url, notes) values
  ('local_deputy','26',       date '2027-06-06','https://congresoson.gob.mx/diputados','Sonora LXIV -> renueva 2027'),
  ('municipal_president','26', date '2027-06-06',null,'Sonora -> renueva 2027');
