-- 0001_schema.sql
-- Esquema mínimo para resolver representantes políticos por coordenada.
-- 3 capas geográficas + 1 tabla manual de representantes. Nada más.

create extension if not exists postgis;

-- Clave de entidad normalizada a TEXT zero-padded ('01'..'32') para reconciliar
-- INEGI (texto '09') con INE (entero 9). Se hace con lpad() al importar.

-- ===========================================================================
-- CAPAS GEOGRÁFICAS (point-in-polygon)
-- ===========================================================================

-- Estados — INEGI Marco Geoestadístico (capa de entidades)
create table public.states (
  cve_ent text primary key,                       -- '09'
  nom_ent text not null,
  geom    geometry(MultiPolygon, 4326) not null
);

-- Municipios — INEGI Marco Geoestadístico (capa de municipios)
create table public.municipalities (
  cvegeo  text primary key,                        -- cve_ent||cve_mun (5): '09015'
  cve_ent text not null,
  nom_mun text not null,
  geom    geometry(MultiPolygon, 4326) not null
);

-- Secciones electorales — INE Base Geográfica Electoral.
-- Capa atómica: trae distrito federal y local como atributos, así que NO se
-- necesitan capas de polígonos de distritos por separado.
create table public.electoral_sections (
  cve_ent          text not null,                  -- '09'
  seccion          integer not null,
  distrito_federal integer,
  distrito_local   integer,
  geom             geometry(MultiPolygon, 4326) not null,
  primary key (cve_ent, seccion)
);

-- ===========================================================================
-- REPRESENTANTES (tabla manual única)
-- ===========================================================================
-- Un solo registro vigente por cargo. Llaves según el rol:
--   governor            -> cve_ent
--   municipal_president -> cvegeo_mun (5)
--   federal_deputy      -> cve_ent + distrito (= distrito_federal)
--   local_deputy        -> cve_ent + distrito (= distrito_local)
create table public.representatives (
  id         bigint generated always as identity primary key,
  role       text not null check (role in
                ('governor','municipal_president','federal_deputy','local_deputy')),
  cve_ent    text not null,
  cvegeo_mun text,                                 -- solo municipal_president
  distrito   integer,                              -- solo diputados
  name       text not null,
  party      text,
  -- Coherencia de llaves por rol
  constraint rep_keys_ok check (
    case role
      when 'governor'            then cvegeo_mun is null and distrito is null
      when 'municipal_president' then cvegeo_mun is not null and distrito is null
      else                            distrito is not null   -- diputados
    end
  )
);

-- Un único titular vigente por cargo (cve_ent='' / -1 rellenan llaves no usadas)
create unique index ux_representatives_one_per_post on public.representatives
  (role, cve_ent, coalesce(cvegeo_mun, ''), coalesce(distrito, -1));

-- ===========================================================================
-- ÍNDICES POSTGIS (indispensables: sin esto el point-in-polygon hace seq scan)
-- ===========================================================================
create index gix_states_geom   on public.states             using gist (geom);
create index gix_munis_geom     on public.municipalities     using gist (geom);
create index gix_sections_geom  on public.electoral_sections using gist (geom);

-- Lookup de diputados por distrito
create index ix_rep_lookup on public.representatives (role, cve_ent, distrito);
