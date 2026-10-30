# 🧭 Decision log y supuestos

Registro de cada decisión técnica o de negocio. Formato corto: qué, por qué, alternativa descartada.

| # | Fecha | Decisión | Por qué | Alternativa descartada |
|---|---|---|---|---|
| 1 | 2026-10-24 | Motor: SQL Server (SSMS) en vez de MySQL (video) | Practicar T-SQL, stack más común en empresas en Colombia | MySQL Workbench |
| 2 | 2026-10-24 | Tipos FLOAT para todas las métricas y PK en `user_id` | Replica el comportamiento numérico del modelo original y evita la división entera de T-SQL; el dump no tenía PK, pero los 1.000 IDs son únicos | DECIMAL(p,s): más exacto para dinero, pero cambia levemente los resultados frente al video |
| 3 | 2026-10-24 | Carga con INSERT en lotes de 250 filas | Límite de 1.000 filas por `VALUES` en SQL Server; el script es re-ejecutable | BULK INSERT desde CSV (exige ruta local del servidor) |
| 4 | 2026-10-24 | Misma estructura de scripts que el autor (01 → 06) | Comparar mi solución contra el caso original paso a paso | Pipeline propio de CTEs |
| 5 | 2026-10-29 | Desviación estándar poblacional (`STDEVP`) | La tabla contiene a todos los clientes fidelizados, no una muestra | `STDEV` (muestral): 157,25 vs 157,17, diferencia irrelevante |
| 6 | 2026-10-29 | Validaciones de consistencia fila a fila con tolerancia 0,01 | Comparar sumas puede esconder errores que se compensan entre filas, y el dump redondea a 6 cifras | Comparar agregados (suma vs suma) |
| 7 | 2026-10-29 | Rango candidato de P: 288 € – 576 € (P75 a ≈ P92) | Por debajo de la mediana domina la canibalización; por encima de 768 € el Tramo 2 queda vacío | Elegir P a ojo o con la media (252 €), que está inflada por la cola derecha |
| 8 | 2026-10-29 | KPI = ΔFact (incremento de facturación frente a no lanzar el pase) | El objetivo confirmado es maximizar la facturación, no el volumen de pases | Nº de pases vendidos; ingreso solo por taquilla |
| 9 | 2026-10-29 | La venta del pase se integra en ΔG (P − G por comprador), no como línea aparte | El pase reemplaza la taquilla de quien lo compra; sumarlo aparte duplicaría ingresos | Ingreso del pase + taquilla perdida por separado |
| 10 | 2026-10-29 | R como exponente: tasa = incentivo^R | Mantiene la tasa en [0, 1] para cualquier R ≥ 0; con R = 1 no altera el incentivo | Incentivo × R (puede superar 1) |
| 11 | 2026-10-29 | G = P exacto cae en Tramo 2 | Igual que el caso original; con G discreto ocurre en los cortes (288, 384, 480…) | G ≤ P en Tramo 1 |
| 12 | 2026-10-29 | Cálculo con promedios por tramo (como el caso original) | Comparabilidad con el video; la versión fila a fila queda como mejora a cuantificar | Fila a fila desde el inicio |
| 13 | 2026-10-29 | Un solo `DECLARE @P` por script, al inicio, y CTE con el mismo nombre en todos los scripts (`usuarios_segmentados`) | El precio se cambia en un único lugar y los bloques se reutilizan sin cambios en el script 06 | Declarar el parámetro en cada consulta del script |
| 14 | 2026-10-29 | Alias de columnas en snake_case (`gasto_entradas_anual_medio`) | Se referencian sin corchetes en CTEs posteriores y coinciden con el script 06 | Alias con espacios entre corchetes |
| 15 | 2026-10-29 | Usar `LEAST` nativo para capar el incentivo | El servidor es SQL Server 2022, donde `LEAST` está disponible; mismo código que el caso original | `IIF(x > 1, 1, x)` / `CASE` |
| 16 | 2026-10-29 | Incentivo del tramo = `LEAST(AVG(G)/P, 1)` (usuario promedio) | Con tramos cortados en P es idéntico al promedio individual y replica el caso original | `AVG(LEAST(G/P, 1))`: equivalente con R = 1, pero no con R ≠ 1 (ver resultados del script 02) |

## Supuestos del modelo

1. **Base modelada:** solo clientes con tarjeta de fidelización (1.000 usuarios); no se modelan clientes nuevos.
2. **Estabilidad:** el comportamiento histórico anual (visitas, gasto) se repite el año del lanzamiento.
3. **Adopción:** la probabilidad de comprar el pase crece con G / P y se ajusta con R (R = 1 hasta tener un piloto).
4. **Visitas extra:** Tramo 1 suma 12 visitas al año (+1 al mes); Tramo 2 suma el 10 % de sus visitas anuales.
5. **Bar:** el gasto en bar por visita se mantiene constante aunque aumente la frecuencia.
6. **Sin restricciones operativas:** capacidad de salas ilimitada y sin costos adicionales por visita.
7. **Ingreso, no margen:** el KPI es facturación; no distingue el reparto de taquilla con la distribuidora ni el mayor margen del bar.

## Traducción MySQL → T-SQL (lo que tuve que cambiar)

| MySQL (video) | T-SQL (mi versión) | Nota |
|---|---|---|
| `SET @P = 400.0;` | `DECLARE @P FLOAT = 400.0;` | La variable debe declararse con tipo y vive solo hasta el siguiente `GO` |
| `POW(x, y)` | ✍️ | |
| `LEAST(a, b)` | `LEAST(a, b)` | Igual en SQL Server 2022+ (mi versión). En versiones anteriores: `IIF(a < b, a, b)` |
