#!/usr/bin/env python3
"""build_diputados_federales.py — genera el INSERT de los 300 diputados federales de MR
a partir del xlsx oficial de la Cámara de Diputados.

Uso:
    python3 scripts/representatives/build_diputados_federales.py ~/Downloads/Diputados.xlsx

Escribe scripts/representatives/diputados_federales.sql. No requiere dependencias
(parsea el .xlsx como zip+XML). Toma solo mayoría relativa (columna con distrito
numérico); omite los plurinominales ("Na. Circunscripción").
"""
import sys, os, zipfile, re
import xml.etree.ElementTree as ET

NS = {'a': 'http://schemas.openxmlformats.org/spreadsheetml/2006/main'}
STATE = {
    'Aguascalientes':'01','Baja California':'02','Baja California Sur':'03','Campeche':'04',
    'Coahuila':'05','Colima':'06','Chiapas':'07','Chihuahua':'08','Ciudad de México':'09',
    'Durango':'10','Guanajuato':'11','Guerrero':'12','Hidalgo':'13','Jalisco':'14',
    'Estado de México':'15','Michoacán':'16','Morelos':'17','Nayarit':'18','Nuevo León':'19',
    'Oaxaca':'20','Puebla':'21','Querétaro':'22','Quintana Roo':'23','San Luis Potosí':'24',
    'Sinaloa':'25','Sonora':'26','Tabasco':'27','Tamaulipas':'28','Tlaxcala':'29',
    'Veracruz':'30','Yucatán':'31','Zacatecas':'32',
}

def cell_text(t):
    return ''.join(x.text or '' for x in t.iter('{%s}t' % NS['a']))

def main(xlsx):
    z = zipfile.ZipFile(xlsx)
    shared = [cell_text(si) for si in ET.fromstring(z.read('xl/sharedStrings.xml')).findall('a:si', NS)]
    sheet = ET.fromstring(z.read('xl/worksheets/sheet1.xml'))
    rows = []
    for row in sheet.findall('.//a:row', NS):
        cells = {}
        for c in row.findall('a:c', NS):
            col = re.match(r'[A-Z]+', c.get('r')).group()
            v = c.find('a:v', NS)
            if v is None:
                val = ''
            elif c.get('t') == 's':
                val = shared[int(v.text)]
            else:
                val = v.text
            cells[col] = val
        rows.append(cells)

    data = rows[1:]  # columnas: A Nombre, B Grupo, C Estado, D Cabecera, E Ditto./Circ.
    recs = []
    for r in data:
        e = (r.get('E', '') or '').strip()
        if not e.isdigit():            # solo MR (distrito numérico)
            continue
        estado = r.get('C', '')
        if estado not in STATE:
            print(f"  WARN estado no mapeado: {estado!r} ({r.get('A')})", file=sys.stderr)
            continue
        name = ' '.join(r['A'].split()).replace("'", "''")
        recs.append((STATE[estado], int(e), name, r['B'].strip()))
    recs.sort(key=lambda x: (x[0], x[1]))

    # sanity: distritos duplicados por estado
    seen = {}
    for c, d, _, _ in recs:
        seen[(c, d)] = seen.get((c, d), 0) + 1
    dups = [k for k, v in seen.items() if v > 1]
    if dups:
        print(f"  WARN duplicados (cve_ent,distrito): {dups}", file=sys.stderr)

    out = [
        "-- diputados_federales.sql — diputados federales de mayoría relativa.",
        "-- Generado por build_diputados_federales.py desde el xlsx oficial de la Cámara.",
        "-- Solo MR (con distrito); plurinominales omitidos.",
        "",
        "insert into public.representatives (role, cve_ent, distrito, name, party) values",
        ",\n".join(f"  ('federal_deputy','{c}',{d},'{n}','{p}')" for c, d, n, p in recs),
        "on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))",
        "do update set name = excluded.name, party = excluded.party;",
        "",
    ]
    dst = os.path.join(os.path.dirname(__file__), 'diputados_federales.sql')
    with open(dst, 'w') as f:
        f.write("\n".join(out))
    print(f"OK: {len(recs)} diputados -> {dst}")

if __name__ == '__main__':
    if len(sys.argv) != 2:
        sys.exit("Uso: python3 build_diputados_federales.py <ruta/Diputados.xlsx>")
    main(sys.argv[1])
