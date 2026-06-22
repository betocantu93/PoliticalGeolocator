# Avance de captura: diputados locales + presidentes municipales

Por estado. Geografía, gobernadores (32) y diputados federales (300) ya están completos.

Fuentes por estado (patrón):
- Diputados locales → `Anexo:<Legislatura> del Congreso de <Estado>` (Wikipedia) o sitio del congreso.
- Presidentes municipales → `Anexo:Presidentes municipales de <Estado> (<periodo>)` (Wikipedia).

Leyenda: ✅ hecho · 🔄 en proceso · ⬜ pendiente

| cve | Estado | Dip. locales | Pres. municipales |
|-----|--------|--------------|-------------------|
| 01 | Aguascalientes | 🔄 generado | 🔄 generado |
| 02 | Baja California | 🔄 generado | 🔄 generado |
| 03 | Baja California Sur | 🔄 generado | 🔄 generado |
| 04 | Campeche | 🔄 generado | 🔄 generado |
| 05 | Coahuila | 🔄 generado | 🔄 generado |
| 06 | Colima | 🔄 generado | 🔄 generado |
| 07 | Chiapas | 🔄 generado | 🔄 generado (Oxchuc usos y costumbres) |
| 08 | Chihuahua | 🔄 generado | 🔄 generado (rev. Santa Isabel/Gral. Trías) |
| 09 | Ciudad de México | 🔄 generado | 🔄 generado (16 alcaldías) |
| 10 | Durango | 🔄 generado | 🔄 generado |
| 11 | Guanajuato | 🔄 generado | 🔄 generado (rev. Dolores Hidalgo) |
| 12 | Guerrero | 🔄 generado | 🔄 generado (faltan ~2: Ñuu Savi; rev. verificación) |
| 13 | Hidalgo | 🔄 generado | 🔄 generado |
| 14 | Jalisco | 🔄 generado | 🔄 generado (125) |
| 15 | Estado de México | 🔄 generado | 🔄 generado (125) |
| 16 | Michoacán | 🔄 generado | 🔄 generado (Cherán usos y costumbres) |
| 17 | Morelos | 🔄 generado | 🔄 generado (3 usos y costumbres) |
| 18 | Nayarit | 🔄 generado | 🔄 generado |
| 19 | Nuevo León | 🔄 generado | 🔄 generado |
| 20 | Oaxaca | 🔄 generado | ⬜ PENDIENTE (570 mpios; ~417 usos y costumbres) |
| 21 | Puebla | 🔄 generado | 🔄 parcial ~191/217 (falta cola Y-Z) |
| 22 | Querétaro | 🔄 generado | 🔄 generado |
| 23 | Quintana Roo | 🔄 generado | 🔄 generado |
| 24 | San Luis Potosí | 🔄 generado | 🔄 generado |
| 25 | Sinaloa | 🔄 generado | 🔄 generado |
| 26 | Sonora | ✅ | ✅ |
| 27 | Tabasco | 🔄 generado | 🔄 generado |
| 28 | Tamaulipas | 🔄 generado | 🔄 generado |
| 29 | Tlaxcala | 🔄 generado | 🔄 generado |
| 30 | Veracruz | 🔄 generado | 🔄 parcial 191/212 (21 en PENDIENTES) |
| 31 | Yucatán | 🔄 generado (21 distritos) | 🔄 generado (106) |
| 32 | Zacatecas | 🔄 generado | 🔄 generado |

## Convenciones por archivo
- `scripts/representatives/<cve>_<estado>_locales.sql`
- `scripts/representatives/<cve>_<estado>_presidentes.sql` (usa JOIN por nombre, ver Sonora)

## Notas / casos especiales
- **09 CDMX**: no hay presidentes municipales sino 16 alcaldías (jefes/as de alcaldía). El INE BGD las trae como "municipio". Se cargan como `municipal_president`.
- **20 Oaxaca**: 570 municipios, ~417 por usos y costumbres (sin partido → `party = null`). Dejar al final.
