-- 0007_municipio_cve_inegi.sql
-- HALLAZGO: el INE BGD numera los municipios distinto a INEGI.
--   Ej. Hermosillo = 26049 (INE BGD) vs 26030 (INEGI). Aplica a TODOS los municipios.
-- El servicio es consistente internamente (todo usa la clave INE), pero para cruzar
-- con datos de INEGI (censo, etc.) hace falta la clave INEGI. Se agrega como columna.
--
-- Poblar con: scripts/import/populate_cve_inegi.sql (match espacial contra INEGI MG).
-- Esta migración solo agrega la columna y la expone en resolve_coordinate.

alter table public.municipalities add column if not exists cve_inegi text;

comment on column public.municipalities.cvegeo is
  'Clave del INE BGD (NO coincide con INEGI). Es la clave canónica interna del servicio.';
comment on column public.municipalities.cve_inegi is
  'Clave INEGI equivalente (5 dígitos), poblada por match espacial contra el Marco Geoestadístico INEGI. Puede ser null hasta poblarse.';

create index if not exists ix_municipalities_cve_inegi on public.municipalities (cve_inegi);

-- Recrea resolve_coordinate para incluir municipio.cve_inegi (supersede la de 0002).
create or replace function public.resolve_coordinate(
  lat double precision,
  lng double precision
)
returns jsonb
language plpgsql
stable
as $$
declare
  pt      geometry(Point, 4326);
  v_state public.states%rowtype;
  v_mun   public.municipalities%rowtype;
  v_sec   public.electoral_sections%rowtype;
  v_gov   jsonb;
  v_pres  jsonb;
  v_fdip  jsonb;
  v_ldip  jsonb;
begin
  if lat is null or lng is null then
    raise exception 'lat y lng son requeridos';
  end if;

  pt := ST_SetSRID(ST_MakePoint(lng, lat), 4326);

  select * into v_state from public.states            s  where ST_Intersects(s.geom,  pt) limit 1;
  select * into v_mun   from public.municipalities    m  where ST_Intersects(m.geom,  pt) limit 1;
  select * into v_sec   from public.electoral_sections es where ST_Intersects(es.geom, pt) limit 1;

  if v_state.cve_ent is not null then
    select to_jsonb(r) into v_gov
    from (select name, party from public.representatives
          where role = 'governor' and cve_ent = v_state.cve_ent) r;
  end if;

  if v_mun.cvegeo is not null then
    select to_jsonb(r) into v_pres
    from (select name, party from public.representatives
          where role = 'municipal_president' and cvegeo_mun = v_mun.cvegeo) r;
  end if;

  if v_sec.cve_ent is not null and v_sec.distrito_federal is not null then
    select to_jsonb(r) into v_fdip
    from (select name, party from public.representatives
          where role = 'federal_deputy'
            and cve_ent = v_sec.cve_ent and distrito = v_sec.distrito_federal) r;
  end if;

  if v_sec.cve_ent is not null and v_sec.distrito_local is not null then
    select to_jsonb(r) into v_ldip
    from (select name, party from public.representatives
          where role = 'local_deputy'
            and cve_ent = v_sec.cve_ent and distrito = v_sec.distrito_local) r;
  end if;

  return jsonb_build_object(
    'estado',           case when v_state.cve_ent is null then null
                          else jsonb_build_object('cve_ent', v_state.cve_ent, 'name', v_state.nom_ent) end,
    'municipio',        case when v_mun.cvegeo is null then null
                          else jsonb_build_object('cvegeo', v_mun.cvegeo, 'cve_inegi', v_mun.cve_inegi, 'name', v_mun.nom_mun) end,
    'seccion',          v_sec.seccion,
    'distrito_federal', v_sec.distrito_federal,
    'distrito_local',   v_sec.distrito_local,
    'gobernador',           coalesce(v_gov,  'null'::jsonb),
    'presidente_municipal', coalesce(v_pres, 'null'::jsonb),
    'diputado_federal',     coalesce(v_fdip, 'null'::jsonb),
    'diputado_local',       coalesce(v_ldip, 'null'::jsonb)
  );
end;
$$;
