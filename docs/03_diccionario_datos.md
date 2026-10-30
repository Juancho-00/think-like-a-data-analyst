# 🗃️ Diccionario de datos — `dbo.entradas`

Grano: **1 fila = 1 usuario** de la cadena de cines.
Fuente: dataset del caso *"Pensar como un Analista de Datos"* (Data Science 4 Business), exportado originalmente desde MySQL.

| Columna | Tipo (MySQL origen) | Tipo propuesto (T-SQL) | Descripción | Uso en el modelo |
|---|---|---|---|---|
| `user_id` | INT | `INT NOT NULL` (PK) | Identificador único del usuario (1–1000) | Llave |
| `visitas_mensuales` | FLOAT | `FLOAT` | Visitas promedio al cine por mes (enteros de 1 a 8) | Base para estimar visitas extra |
| `gasto_entradas_anual` | FLOAT | `FLOAT` | Gasto anual en entradas (G) = visitas × 12 × 8 €. Solo 8 valores: 96–768 | Se compara contra P → tramo e incentivo |
| `gasto_bar_anual` | FLOAT | `FLOAT` | Gasto anual en bar / concesiones | Palanca ΔC |
| `gasto_total_anual` | FLOAT | `FLOAT` | Gasto total anual = entradas + bar (validado, tolerancia 0,01) | Control de calidad |
| `gasto_bar_por_visita` | FLOAT | `FLOAT` | Gasto en bar por visita = bar anual / (visitas × 12) (validado) | Multiplica las visitas extra |
| `visitas_mensuales_m0` | FLOAT | `FLOAT` | Visitas del primer mes de una ventana de 6 meses. Idéntica a `visitas_mensuales` en las 1.000 filas | Tendencia (opcional) |
| `visitas_mensuales_m6` | FLOAT | `FLOAT` | Visitas del mes 6. Suben 234 usuarios, bajan 153 | Tendencia (opcional) |

> Descripciones validadas con `sql/01_exploracion/01_perfilamiento_entradas.sql`.

## Hallazgos del perfilamiento

| Métrica | Valor | Implicación |
|---|---|---|
| Total usuarios | 1.000 (1 fila por usuario) | Grano limpio, sin deduplicar |
| Mediana `gasto_entradas_anual` | 192 € (media 252 €) | Distribución sesgada a la derecha: P bajo canibaliza a la mayoría |
| P90 `gasto_entradas_anual` | 480 € | Pocos usuarios intensivos: el Tramo 2 se vacía rápido al subir P |
| Nulos / anomalías | 0 nulos; montos redondeados a 6 cifras (dif. ≤ 0,005) | Validar con tolerancia, no con igualdad exacta |
| Precio por entrada | 8 € fijo | G es discreto: los tramos solo cambian en múltiplos de 96 € |
