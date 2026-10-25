# 🗃️ Diccionario de datos — `dbo.entradas`

Grano: **1 fila = 1 usuario** de la cadena de cines.
Fuente: dataset del caso *"Pensar como un Analista de Datos"* (Data Science 4 Business), exportado originalmente desde MySQL.

| Columna | Tipo (MySQL origen) | Tipo propuesto (T-SQL) | Descripción | Uso en el modelo |
|---|---|---|---|---|
| `user_id` | INT | `INT NOT NULL` (PK) | Identificador único del usuario (1–1000) | Llave |
| `visitas_mensuales` | FLOAT | `FLOAT` | Visitas promedio al cine por mes (1–8) | Base para estimar visitas extra |
| `gasto_entradas_anual` | FLOAT | `FLOAT` | Gasto anual en entradas (G), 96–768 | Se compara contra P → tramo e incentivo |
| `gasto_bar_anual` | FLOAT | `FLOAT` | Gasto anual en bar / concesiones | Palanca ΔC |
| `gasto_total_anual` | FLOAT | `FLOAT` | Gasto total anual | ✍️ Validar = entradas + bar |
| `gasto_bar_por_visita` | FLOAT | `FLOAT` | Gasto en bar por cada visita | Multiplica las visitas extra |
| `visitas_mensuales_m0` | FLOAT | `FLOAT` | Visitas del primer mes de una ventana de 6 meses | Tendencia de frecuencia por usuario (opcional) |
| `visitas_mensuales_m6` | FLOAT | `FLOAT` | Visitas del mes 6 de esa ventana | Tendencia de frecuencia por usuario (opcional) |

> ✍️ = completar tú después del perfilamiento (`sql/01_exploracion/01_perfilamiento_entradas.sql`).

## Hallazgos del perfilamiento

| Métrica | Valor | Implicación |
|---|---|---|
| Total usuarios | | |
| Mediana `gasto_entradas_anual` | | |
| P90 `gasto_entradas_anual` | | |
| Nulos / anomalías | | |
