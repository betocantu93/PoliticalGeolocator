#!/usr/bin/env python3
"""build_state_reps.py — convierte una tabla PEGADA (de Wikipedia/IEE) en el SQL de
representantes de un estado. Sin dependencias (solo stdlib).

Por qué existe: la captura estatal (diputados locales / presidentes municipales) se
hacía a mano. Esto la vuelve "pega tabla -> corre script -> corre SQL". Pensado para
re-ejecutarse cada tirada electoral (2027, 2030...).

USO:
  # Presidentes municipales (formato: Municipio <tab> Presidente <tab> Partido)
  python3 build_state_reps.py --cve 30 --role municipal_president tabla.txt > 30_estado_presidentes.sql

  # Diputados locales (formato: Distrito <tab> Nombre <tab> Partido)
  python3 build_state_reps.py --cve 30 --role local_deputy tabla.txt > 30_estado_locales.sql

ENTRADA: pega la tabla tal cual la copias del navegador (separada por tabs). El script:
  - toma columna 0 = municipio/distrito, columna 1 = nombre, última columna = partido;
  - junta líneas de continuación (cambios de partido "... (desde 2025)") y usa el VIGENTE;
  - quita notas al pie [1], anotaciones (2024-2025), y normaliza el partido a su código;
  - usos y costumbres / vacante / concejo -> party = NULL (pero conserva el nombre).

SALIDA:
  - municipal_president: SQL con JOIN por nombre (normaliza acentos y espacios) +
    queries de verificación (cuántos machearon y cuáles no, para cerrarlos por cvegeo).
  - local_deputy: INSERT directo por distrito.
"""
import sys, re, argparse

# Mapa de partido -> código canónico. Substring match; ordena de más específico a genérico.
PARTY_MAP = [
    ('movimiento regeneración nacional', 'MORENA'), ('morena', 'MORENA'),
    ('partido del trabajo', 'PT'),
    ('partido verde', 'PVEM'),
    ('partido revolucionario institucional', 'PRI'),
    ('partido acción nacional', 'PAN'),
    ('partido de la revolución democrática', 'PRD'),
    ('movimiento ciudadano', 'MC'),
    ('nueva alianza', 'Nueva Alianza'),
    ('fuerza por méxico', 'Fuerza por México'),
    ('pacto social de integración', 'PSI'),
    ('encuentro solidario', 'PES'),
    ('partido encuentro social', 'PES'),
    ('redes sociales progresistas', 'RSP'),
    ('unidad popular', 'Unidad Popular'),
    ('partido mujer', 'Partido Mujer'),
    ('partido sinaloense', 'Partido Sinaloense'),
    ('partido chiapas unido', 'Partido Chiapas Unido'),
    ('mover a chiapas', 'Mover a Chiapas'),
    ('más michoacán', 'Más Michoacán'),
    ('conciencia popular', 'PCP'),
    ('candidato independiente', 'Independiente'), ('independiente', 'Independiente'),
    # códigos ya cortos (por si la tabla ya viene normalizada)
    ('pvem', 'PVEM'), ('pri', 'PRI'), ('pan', 'PAN'), ('prd', 'PRD'),
    ('pt', 'PT'), ('mc', 'MC'),
]
NULL_PARTY_KEYS = ('vacante', 'concejo', 'usos y costumbres', 'sistema normativo', 'provisional')


def clean(text):
    text = re.sub(r'\[\d+\]', '', text)          # quita notas al pie [3]
    return ' '.join(text.split()).strip()


def norm_party(raw, name=''):
    """Devuelve el código de partido, o None si es usos y costumbres/vacante.
    Revisa también el nombre (p.ej. nombre='Vacante' -> party null aunque traiga partido)."""
    if any(k in name.lower() for k in NULL_PARTY_KEYS):
        return None
    raw = re.sub(r'\[\d+\]', '', raw)
    raw = re.sub(r'\(.*?\)', '', raw)             # quita (2024-2025), (desde 2025)
    p = ' '.join(raw.split()).strip()
    low = p.lower()
    if not p or any(k in low for k in NULL_PARTY_KEYS):
        return None
    for key, code in PARTY_MAP:
        if key in low:
            return code
    return p  # desconocido: se conserva tal cual (revísalo a mano)


def parse(lines):
    """Devuelve filas [(key, name, party_raw)], uniendo continuaciones de cambio de partido."""
    rows = []
    for raw in lines:
        if not raw.strip():
            continue
        low0 = raw.strip().lower()
        if low0.startswith(('municipio', 'distrito', 'presidente')):  # encabezados
            continue
        cells = [c for c in raw.split('\t')]
        nonempty = [c.strip() for c in cells if c.strip()]
        is_continuation = raw[:1].isspace() and len(nonempty) <= 1
        if is_continuation and rows:
            # línea de cambio de partido -> el partido VIGENTE es éste
            if nonempty:
                rows[-1][2] = nonempty[0]
            continue
        if len(nonempty) >= 2:
            key = nonempty[0]
            name = nonempty[1]
            party = nonempty[-1] if len(nonempty) >= 3 else ''
            rows.append([key, name, party])
    return rows


def sql_val(s):
    return s.replace("'", "''")


def emit_municipal(cve, rows):
    out = [f"-- presidentes municipales (cve_ent {cve}). Generado por build_state_reps.py.",
           "-- Revisa la verificación al final: los que no macheen por nombre se cierran por cvegeo.",
           "", "begin;", "create temp table tmp_pm (nom text, name text, party text);",
           "insert into tmp_pm (nom, name, party) values"]
    vals = []
    for key, name, praw in rows:
        party = norm_party(praw, name)
        p = 'null' if party is None else f"'{sql_val(party)}'"
        vals.append(f"  ('{sql_val(clean(key))}','{sql_val(clean(name))}',{p})")
    out.append(",\n".join(vals) + ";")
    out += [
        "",
        "insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)",
        f"select 'municipal_president', '{cve}', m.cvegeo, t.name, t.party",
        "from tmp_pm t",
        "join public.municipalities m",
        "  on replace(upper(translate(trim(m.nom_mun), 'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')",
        "   = replace(upper(translate(trim(t.nom),     'áéíóúüÁÉÍÓÚÜñÑ', 'aeiouuAEIOUUnN')),' ','')",
        f" and m.cve_ent = '{cve}'",
        "on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))",
        "do update set name = excluded.name, party = excluded.party;",
        "commit;",
        "",
        "-- Verificación A: nombres de la tabla que NO machearon (cerrar por cvegeo):",
        "select t.nom from tmp_pm t left join public.municipalities m",
        "  on replace(upper(translate(trim(m.nom_mun),'áéíóúüÁÉÍÓÚÜñÑ','aeiouuAEIOUUnN')),' ','')",
        "   = replace(upper(translate(trim(t.nom),    'áéíóúüÁÉÍÓÚÜñÑ','aeiouuAEIOUUnN')),' ','')",
        f" and m.cve_ent='{cve}'",
        "where m.cvegeo is null;",
        "",
        "-- Verificación B: municipios del estado sin presidente (debe quedar 0):",
        "select m.cvegeo, m.nom_mun from public.municipalities m",
        f"where m.cve_ent='{cve}' and not exists (select 1 from public.representatives r",
        "  where r.role='municipal_president' and r.cvegeo_mun=m.cvegeo) order by m.nom_mun;",
    ]
    return "\n".join(out)


def emit_local(cve, rows):
    out = [f"-- diputados locales de MR (cve_ent {cve}). Generado por build_state_reps.py.",
           "", "insert into public.representatives (role, cve_ent, distrito, name, party) values"]
    vals = []
    for key, name, praw in rows:
        m = re.search(r'\d+', key)
        if not m:
            print(f"  WARN distrito no numérico, fila omitida: {key!r}", file=sys.stderr)
            continue
        party = norm_party(praw, name)
        p = 'null' if party is None else f"'{sql_val(party)}'"
        vals.append(f"  ('local_deputy','{cve}',{int(m.group())},'{sql_val(clean(name))}',{p})")
    out.append(",\n".join(vals))
    out += ["on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))",
            "do update set name = excluded.name, party = excluded.party;"]
    return "\n".join(out)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--cve', required=True, help="clave de entidad, 2 dígitos (p.ej. 30)")
    ap.add_argument('--role', required=True, choices=['municipal_president', 'local_deputy'])
    ap.add_argument('file', nargs='?', help="archivo con la tabla pegada (o stdin)")
    args = ap.parse_args()
    cve = args.cve.zfill(2)
    text = open(args.file, encoding='utf-8').read() if args.file else sys.stdin.read()
    rows = parse(text.splitlines())
    print((emit_municipal if args.role == 'municipal_president' else emit_local)(cve, rows))
    print(f"-- {len(rows)} filas procesadas.", file=sys.stderr)


if __name__ == '__main__':
    main()
