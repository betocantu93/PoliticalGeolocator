-- 0002_resolve_coordinate.sql
-- Función única: lat/lng -> toda la información política de la coordenada.
-- Point-in-polygon con ST_Intersects (sin IA). Devuelve un JSONB.

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

  pt := ST_SetSRID(ST_MakePoint(lng, lat), 4326);   -- X=lng, Y=lat

  -- Geografía (un point-in-polygon por capa)
  select * into v_state from public.states            s  where ST_Intersects(s.geom,  pt) limit 1;
  select * into v_mun   from public.municipalities    m  where ST_Intersects(m.geom,  pt) limit 1;
  select * into v_sec   from public.electoral_sections es where ST_Intersects(es.geom, pt) limit 1;

  -- Representantes (join por atributos, no espacial)
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
                          else jsonb_build_object('cve_ent', v_state.cve_ent, 'nombre', v_state.nom_ent) end,
    'municipio',        case when v_mun.cvegeo is null then null
                          else jsonb_build_object('cvegeo', v_mun.cvegeo, 'nombre', v_mun.nom_mun) end,
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

-- Uso:  select public.resolve_coordinate(19.4326, -99.1332);
