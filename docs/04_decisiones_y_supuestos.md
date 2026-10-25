# 🧭 Decision log y supuestos

Registro de cada decisión técnica o de negocio. Formato corto: qué, por qué, alternativa descartada.

| # | Fecha | Decisión | Por qué | Alternativa descartada |
|---|---|---|---|---|
| 1 | | Motor: SQL Server (SSMS) en vez de MySQL (video) | Practicar T-SQL, stack más común en empresas en Colombia | MySQL Workbench |
| 2 | 2026-10-24 | Tipos FLOAT para todas las métricas y PK en `user_id` | Replica el comportamiento numérico del modelo original y evita la división entera de T-SQL; el dump no tenía PK, pero los 1.000 IDs son únicos | DECIMAL(p,s): más exacto para dinero, pero cambia levemente los resultados frente al video |
| 3 | 2026-10-24 | Carga con INSERT en lotes de 250 filas | Límite de 1.000 filas por `VALUES` en SQL Server; el script es re-ejecutable | BULK INSERT desde CSV (exige ruta local del servidor) |
| 4 | 2026-10-24 | Misma estructura de scripts que el autor (01 → 06) | Comparar mi solución contra el caso original paso a paso | Pipeline propio de CTEs |
| 3 | | | | |

## Supuestos del modelo

1. ✍️
2. ✍️
3. ✍️

## Traducción MySQL → T-SQL (lo que tuve que cambiar)

| MySQL (video) | T-SQL (mi versión) | Nota |
|---|---|---|
| `SET @P = 400.0;` | ✍️ | |
| `POW(x, y)` | ✍️ | |
| `LEAST(a, b)` | ✍️ | Disponible solo en SQL Server 2022+ |
