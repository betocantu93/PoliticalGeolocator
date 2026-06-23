# UPDATE_GUIDE — actualizar tras una tirada electoral

Cómo actualizar la base cuando cambian los cargos (2027, 2028, 2029, 2030…).
Complementa [OPERATIONS.md](OPERATIONS.md) (carga inicial). La regla de oro:
**los archivos del repo son la fuente de verdad** — editas/agregas el archivo del
cargo, lo corres, y commiteas. Nunca solo en la base.

---

## 0. ¿Qué toca actualizar? (calendario)

🟢 SQL Editor — qué se vence en los próximos 90 días:
```sql
select cargo_type, cve_ent, next_election
from public.update_calendar
where next_election <= current_date + interval '90 days'
order by next_election;
```

Calendario macro:
- **Junio 2027**: diputados federales (los 300) + gobernadores de 15 estados + diputados
  locales y presidentes de los estados que se eligieron en 2024 (la mayoría).
- **2028**: gobernadores de 6 estados (electos 2022) + sus locales/municipios.
- **2029**: Coahuila, Edomex. **2030**: los 9 estados electos en 2024 (CDMX, Jalisco…).

> Tras cualquier elección, el `update_calendar` te dice exactamente qué estados/niveles
> cambiaron. Empieza por ahí.

---

## 1. Geografía (solo si el INE redistrita)

Raro. Si el INE publica corte nuevo o redistritación: re-descarga el BGD y re-corre
`scripts/import/load.sh` + `transform.sql` (idempotentes). Si recargaste geometría,
**vuelve a poblar `cve_inegi`** con `scripts/import/populate_cve_inegi.sql`.

## 2. Diputados federales (cada 3 años — el más fácil)

1. Exporta el xlsx de la nueva legislatura: https://web.diputados.gob.mx/inicio/tusDiputados
2. `python3 scripts/representatives/build_diputados_federales.py ~/Downloads/Diputados.xlsx`
3. Corre el `diputados_federales.sql` resultante. Listo (upsert, sobrescribe los 300).

## 3. Gobernadores (cuando cambie un estado)

Edita `scripts/representatives/gobernadores.sql` (cambia el nombre/partido del estado),
re-córrelo. Actualiza `update_calendar.next_election` de ese estado al siguiente ciclo.

---

## 4. Diputados locales + presidentes municipales (por estado) — el grueso

Aquí está el 90% del trabajo. **Usa el generador** `build_state_reps.py` para no
transcribir a mano. Proceso por estado:

### Paso a paso (ejemplo: actualizar Veracruz tras 2027)

**a) Encuentra los anexos nuevos en Wikipedia.** Los números/periodos CAMBIAN:
- Diputados locales: `Anexo:<NUEVA legislatura> del Congreso de <Estado>` (p.ej. LXVII → LXVIII).
- Presidentes: `Anexo:Presidentes municipales de <Estado> (<nuevo periodo>)` (p.ej. 2027-2030).
  Búscalo en la caja "Artículo principal" o en la categoría del estado.

**b) Copia la tabla del navegador a un archivo de texto.** ⚠️ NO uses descargadores
automáticos: las páginas grandes (Veracruz 212, Puebla 217, Oaxaca 570) se truncan.
Abre la página, selecciona la tabla, cópiala y pégala en `tabla.txt`. El formato que
sale del navegador (separado por tabs: `Municipio ⇥ Presidente ⇥ Partido`) es justo el
que el script entiende.

**c) Genera el SQL:**
```bash
# Presidentes
python3 scripts/representatives/build_state_reps.py --cve 30 --role municipal_president tabla.txt \
  > scripts/representatives/30_veracruz_presidentes.sql

# Diputados locales (tabla: Distrito ⇥ Nombre ⇥ Partido)
python3 scripts/representatives/build_state_reps.py --cve 30 --role local_deputy locales.txt \
  > scripts/representatives/30_veracruz_locales.sql
```
El script ya: normaliza partidos, usa el partido VIGENTE en cambios a media gestión,
y pone `party = null` en usos y costumbres / vacantes.

**d) Corre el SQL** (SQL Editor o psql). Trae 2 verificaciones al final.

**e) Cierra los que no machearon por nombre.** La "Verificación A" lista los nombres de
la tabla que el INE escribe distinto. Corre la "Verificación B" para ver el `cvegeo` real,
y agrega un INSERT directo en `_fixes_cvegeo.sql` (o al final del archivo del estado):
```sql
insert into public.representatives (role, cve_ent, cvegeo_mun, name, party)
values ('municipal_president','30','<cvegeo>','<Nombre>','<Partido>')
on conflict (role, cve_ent, coalesce(cvegeo_mun,''), coalesce(distrito,-1))
do update set name=excluded.name, party=excluded.party;
```

**f) Actualiza** `update_calendar.next_election` de ese estado, y commitea.

---

## 5. Catálogo de gotchas (lo que aprendimos a la mala)

| Síntoma | Causa / fix |
|---|---|
| WebFetch / descarga trunca la tabla | Páginas grandes. **Copia-pega del navegador** a un .txt. |
| Municipio no machea por nombre | El INE usa abreviaturas y nombres oficiales: `DR.` (Doctor), `GRAL.` (General), `Heroica Ciudad de…`, sin artículo (`Carmen` no "El Carmen"), sin espacios (`VILLACOMALTITLAN`), o nombre largo ("Dolores Hidalgo Cuna de la Independencia Nacional"). Cierra por `cvegeo`. |
| Alcalde cambió de partido a media gestión | Usa el **vigente**. El script toma la línea "(desde 20XX)". |
| Municipio por usos y costumbres | `party = null`, pero conserva el nombre del concejo/autoridad. |
| **Oaxaca** | 570 = 152 por partido + ~418 por usos y costumbres (Sistema Normativo Indígena, sin padrón nacional — el hueco estructural). Ver PENDIENTES.md. |
| `cvegeo` no es INEGI | Es clave INE BGD. Usa `cve_inegi` para cruzar con INEGI. Re-poblar solo si recargas geometría. |
| Municipios homónimos (dos "San Pedro Mixtepec") | El JOIN por nombre puede asignar a ambos. Revisa Oaxaca con cuidado; cierra por `cvegeo` si hace falta. |

---

## 6. Verificación final (siempre, tras actualizar)

```sql
-- Auditoría: municipios sin presidente, por estado
select m.cve_ent, count(*) as sin_presidente
from public.municipalities m
where not exists (select 1 from public.representatives r
  where r.role='municipal_president' and r.cvegeo_mun=m.cvegeo)
group by m.cve_ent order by m.cve_ent;
```
Esperado en estado sano: solo Oaxaca (~418, usos y costumbres). Cualquier otro estado
con filas = revisa name-mismatches con el proceso del Paso 4e.

También corre `scripts/checks.sql` para el panorama completo.
```
