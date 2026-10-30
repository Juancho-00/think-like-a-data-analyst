/* ============================================================================
   Script   : 01_perfilamiento_entradas.sql
   Objetivo : Conocer los datos ANTES de modelar.
   Regla    : nunca simules un precio sin conocer la distribución del gasto.
   ============================================================================ */

USE cine;
GO

-- TODO 1: Conteo de filas, usuarios únicos y nulos por columna.

SELECT

   COUNT(*) AS [Conteo de filas],
   COUNT(DISTINCT user_id) AS [usuarios únicos],
   SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS [Nulos user_id],
   SUM(CASE WHEN visitas_mensuales IS NULL THEN 1 ELSE 0 END) AS [Nulos visitas_mensuales],
   SUM(CASE WHEN gasto_entradas_anual IS NULL THEN 1 ELSE 0 END) AS [Nulos gasto_entradas_anual],
   SUM(CASE WHEN gasto_bar_anual IS NULL THEN 1 ELSE 0 END) AS [Nulos gasto_bar_anual],
   SUM(CASE WHEN gasto_total_anual IS NULL THEN 1 ELSE 0 END) AS [Nulos gasto_total_anual],
   SUM(CASE WHEN gasto_bar_por_visita IS NULL THEN 1 ELSE 0 END) AS [Nulos gasto_bar_por_visita],
   SUM(CASE WHEN visitas_mensuales_m0 IS NULL THEN 1 ELSE 0 END) AS [Nulos visitas_mensuales_m0],
   SUM(CASE WHEN visitas_mensuales_m6 IS NULL THEN 1 ELSE 0 END) AS [Nulos visitas_mensuales_m6]

FROM dbo.entradas;
GO


-- TODO 2: Mínimo, máximo, promedio y desviación estándar de gasto_entradas_anual.

SELECT

   MIN(gasto_entradas_anual) AS [Gasto entrada anual mínima],
   MAX(gasto_entradas_anual) AS [Gasto entrada anual máxima],
   AVG(gasto_entradas_anual) AS [Gasto entrada promedio anual],
   STDEVP(gasto_entradas_anual) AS [Desviación gasto entrada anual]

FROM dbo.entradas;
GO


-- TODO 3: Percentiles P25, P50, P75, P90 de gasto_entradas_anual.
--         Pista T-SQL: investiga PERCENTILE_CONT ... WITHIN GROUP ... OVER ().

SELECT DISTINCT

   PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY gasto_entradas_anual) OVER() AS [Percentil 25 gasto_entradas_anual],
   PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY gasto_entradas_anual) OVER() AS [Mediana gasto_entradas_anual],
   PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY gasto_entradas_anual) OVER() AS [Percentil 75 gasto_entradas_anual],
   PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY gasto_entradas_anual) OVER() AS [Percentil 90 gasto_entradas_anual]

FROM dbo.entradas;
GO

-- TODO 4: Validaciones de consistencia:
--         a) ¿gasto_total_anual = gasto_entradas_anual + gasto_bar_anual?
--         b) ¿gasto_bar_por_visita ≈ gasto_bar_anual / (visitas_mensuales * 12)?
--         c) ¿Qué representan visitas_mensuales_m0 y visitas_mensuales_m6?
--            Compara sus promedios con visitas_mensuales.

SELECT

   -- Punto A
   SUM(gasto_total_anual) AS [Gasto total anual],
   SUM(gasto_entradas_anual) + SUM(gasto_bar_anual) AS [Consistencia GTA],

   -- Punto B
   SUM(gasto_bar_por_visita) AS [Consumo por visita],
   SUM(gasto_bar_anual) / (SUM(visitas_mensuales) * 12) AS [Consistencia consumo por visita]

FROM dbo.entradas;
GO

SELECT

   -- Punto C
   AVG(visitas_mensuales_m0) AS [Promedio de visitas mensuales mes_0], AVG(visitas_mensuales_m6) AS [Promedio de visitas mensuales mes_6],
   AVG(visitas_mensuales) AS [Promedio de visitas mensuales]

FROM dbo.entradas;
GO

-- TODO 5: Con los percentiles, propone un rango de precios P candidato
--         y anótalo en docs/05_resultados.md.

   -- 5.1 Distribución completa del gasto en entradas (variable discreta: solo 8 valores)
WITH distribucion AS (

   SELECT
         gasto_entradas_anual,
         COUNT(*) AS n_usuarios
   FROM dbo.entradas
   GROUP BY gasto_entradas_anual
)

SELECT

    gasto_entradas_anual                                   AS [Gasto entradas anual],
    gasto_entradas_anual / 96                              AS [Visitas mensuales equivalentes],
    n_usuarios                                             AS [Usuarios],

    CAST(100.0 * n_usuarios / SUM(n_usuarios) OVER () AS DECIMAL(5,1)) AS [% usuarios],

    CAST(100.0 * SUM(n_usuarios) OVER (ORDER BY gasto_entradas_anual ROWS UNBOUNDED PRECEDING) / SUM(n_usuarios) OVER () AS DECIMAL(5,1))        AS [% acumulado]

FROM distribucion;

GO

   -- 5.2 Tamaño de los tramos para cada P candidato
   --     (regla del modelo: Tramo 1 si gasto_entradas_anual < P)
SELECT
    p.P                                                                    AS [P candidato],
    SUM(CASE WHEN e.gasto_entradas_anual <  p.P THEN 1 ELSE 0 END)         AS [Usuarios Tramo 1],
    SUM(CASE WHEN e.gasto_entradas_anual >= p.P THEN 1 ELSE 0 END)         AS [Usuarios Tramo 2],
    CAST(100.0 * SUM(CASE WHEN e.gasto_entradas_anual >= p.P THEN 1 ELSE 0 END)
         / COUNT(*) AS DECIMAL(5,1))                                       AS [% en riesgo de canibalización]
FROM (VALUES (192.0), (288.0), (300.0), (384.0), (400.0),
             (480.0), (500.0), (576.0), (672.0), (768.0)) AS p (P)
CROSS JOIN dbo.entradas AS e
GROUP BY p.P
ORDER BY p.P;
GO
