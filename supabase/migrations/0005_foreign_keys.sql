-- 0005_foreign_keys.sql
-- Integridad referencial. Agregar SOLO cuando los datos referenciados ya existen
-- (p.ej. no agregar fk_rep_state si hay representantes de estados aún no cargados).
--
-- Prerrequisito si vas estado-por-estado:
--   delete from public.representatives where cve_ent not in (select cve_ent from public.states);

-- municipio -> estado
alter table public.municipalities
  add constraint fk_muni_state
  foreign key (cve_ent) references public.states(cve_ent);

-- sección -> estado
alter table public.electoral_sections
  add constraint fk_section_state
  foreign key (cve_ent) references public.states(cve_ent);

-- representante -> estado
alter table public.representatives
  add constraint fk_rep_state
  foreign key (cve_ent) references public.states(cve_ent);

-- presidente municipal -> municipio (cvegeo_mun es null para los demás cargos; FK ignora nulls)
alter table public.representatives
  add constraint fk_rep_muni
  foreign key (cvegeo_mun) references public.municipalities(cvegeo);

-- NOTA: representatives.distrito (diputados) no tiene FK porque por diseño no existe
-- una tabla de distritos (el distrito vive como atributo en electoral_sections).
