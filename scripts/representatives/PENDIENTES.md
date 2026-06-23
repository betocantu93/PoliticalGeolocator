# Pendientes / huecos conocidos de captura

Gaps documentados en la carga de representantes. Causa principal: WebFetch trunca las
páginas de Wikipedia muy grandes (tablas de 200+ municipios), así que en los estados
grandes los presidentes municipales quedan parciales. Los diputados locales NO se ven
afectados (caben en un fetch).

## 20 — Oaxaca: 152 de partido cargados; ~418 usos y costumbres PENDIENTES
- 570 municipios = 152 por partidos políticos + ~418 por usos y costumbres (Sistema
  Normativo Indígena).
- Diputados locales (25): ✅
- Presidentes de partido (152): ✅ ver 20_oaxaca_presidentes.sql.
- Presidentes usos y costumbres (~418): ❌ pendientes. `party = null`. No hay padrón
  nacional consolidado de autoridades indígenas; se eligen por asamblea y cambian seguido.
  Es el único hueco estructural del país. Fuente posible: IEEPCO (acuerdos por municipio).

## 21 — Puebla: ✅ COMPLETO (217/217)
Cerrado con la tabla oficial pegada (cola X-Z + Huehuetlán el Grande). Ver el segundo
INSERT en 21_puebla_presidentes.sql.

## 30 — Veracruz: ✅ COMPLETO (212/212)
Cerrado con la tabla oficial pegada (la cola Y-Z + serie 200). Ver el segundo INSERT
en 30_veracruz_presidentes.sql.

## 12 — Guerrero: ✅ COMPLETO (85/85)
Cerrado: Ayutla de los Libres (12012) y Ñuu Savi (12082), ambos por usos y costumbres
(party null). Ver `_fixes_cvegeo.sql`.

## Patrón de mismatch del INE BGD (para cerrar verificaciones)
El INE escribe nombres distinto a Wikipedia. Al cerrar huecos por `cvegeo`, ojo con:
- Abreviaturas: `DR.` (Doctor), `GRAL.` (General). Ej. NL: Dr. Arroyo, Gral. Zuazua.
- Sin artículo: `CARMEN` (no "El Carmen"), a veces sin "Los/Las".
- Sin espacios: `VILLACOMALTITLAN` (Chiapas).
- Nombre oficial largo: "Tlacotepec de Benito Juárez", "Dolores Hidalgo Cuna de la
  Independencia Nacional", "Acambay de Ruíz Castañeda".

## Cómo cerrar un hueco
Correr la verificación del estado (al final de su `*_presidentes.sql`), y para cada fila
faltante, un INSERT directo por `cvegeo`:
```sql
insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
values ('municipal_president','<cve>','<cvegeo>','<Nombre>','<Partido>')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name = excluded.name, party = excluded.party;
```
