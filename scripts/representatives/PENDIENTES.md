# Pendientes / huecos conocidos de captura

Gaps documentados en la carga de representantes. Causa principal: WebFetch trunca las
páginas de Wikipedia muy grandes (tablas de 200+ municipios), así que en los estados
grandes los presidentes municipales quedan parciales. Los diputados locales NO se ven
afectados (caben en un fetch).

## 20 — Oaxaca: presidentes municipales (PENDIENTE COMPLETO)
- 570 municipios, ~417 por usos y costumbres (sin partido).
- Diputados locales (25): ✅ cargados.
- Presidentes municipales: ❌ no cargados. Decisión: dejarlos null por ahora (long tail).
- Para resolver: requiere fuente CSV/PDF del IEEPCO con los 570, o varios fetches dedicados.

## 21 — Puebla: 19 presidentes municipales faltantes (cola X-Z)
Cargados ~192/217. Faltan estos (correr verificación para confirmar):

| cvegeo | municipio |
|--------|-----------|
| 21075 | Huehuetlán el Grande |
| 21200 | Xochiapulco |
| 21201 | Xochiltepec |
| 21202 | Xochitlán de Vicente Suárez |
| 21203 | Xochitlán Todos Santos |
| 21204 | Yaonáhuac |
| 21205 | Yehualtepec |
| 21206 | Zacapala |
| 21207 | Zacapoaxtla |
| 21208 | Zacatlán |
| 21209 | Zapotitlán |
| 21210 | Zapotitlán de Méndez |
| 21211 | Zaragoza |
| 21212 | Zautla |
| 21213 | Zihuateutla |
| 21214 | Zinacatepec |
| 21215 | Zongozotla |
| 21216 | Zoquiapan |
| 21217 | Zoquitlán |

## 12 — Guerrero: ~2 presidentes faltantes
- La fuente dio 83/85; faltan municipios nuevos (p.ej. Ñuu Savi). Confirmar con verificación.

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
