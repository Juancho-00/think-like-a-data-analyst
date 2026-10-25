/* ============================================================================
   Proyecto : Pricing del Pase VIP Anual de Cine
   Script   : 02_validacion_carga.sql
   Objetivo : Confirmar que la carga en SQL Server es idéntica al dump original.
              Los valores esperados se calcularon directamente sobre el dump MySQL.
   Uso      : ejecutar después de 01_load_entradas.sql. Todas las filas deben
              salir con estado = 'OK'.
   ============================================================================ */

USE cine;
GO

WITH esperado AS (
    SELECT * FROM (VALUES
        ('filas',                         1000.0000),
        ('user_id distintos',             1000.0000),
        ('suma visitas_mensuales',        2625.0000),
        ('suma gasto_entradas_anual',   252000.0000),
        ('suma gasto_bar_anual',        128306.8254),
        ('suma gasto_total_anual',      380306.8290),
        ('suma gasto_bar_por_visita',     4098.8957),
        ('suma visitas_mensuales_m0',     2625.0000),
        ('suma visitas_mensuales_m6',     2706.0000),
        ('filas con nulos',                  0.0000)
    ) AS e (control, valor_esperado)
),
obtenido AS (
    SELECT 'filas' AS control, CAST(COUNT(*) AS FLOAT) AS valor_real FROM dbo.entradas
    UNION ALL SELECT 'user_id distintos',         COUNT(DISTINCT user_id)    FROM dbo.entradas
    UNION ALL SELECT 'suma visitas_mensuales',    SUM(visitas_mensuales)     FROM dbo.entradas
    UNION ALL SELECT 'suma gasto_entradas_anual', SUM(gasto_entradas_anual)  FROM dbo.entradas
    UNION ALL SELECT 'suma gasto_bar_anual',      SUM(gasto_bar_anual)       FROM dbo.entradas
    UNION ALL SELECT 'suma gasto_total_anual',    SUM(gasto_total_anual)     FROM dbo.entradas
    UNION ALL SELECT 'suma gasto_bar_por_visita', SUM(gasto_bar_por_visita)  FROM dbo.entradas
    UNION ALL SELECT 'suma visitas_mensuales_m0', SUM(visitas_mensuales_m0)  FROM dbo.entradas
    UNION ALL SELECT 'suma visitas_mensuales_m6', SUM(visitas_mensuales_m6)  FROM dbo.entradas
    UNION ALL SELECT 'filas con nulos', COUNT(*) FROM dbo.entradas
              WHERE visitas_mensuales IS NULL OR gasto_entradas_anual IS NULL
                 OR gasto_bar_anual IS NULL OR gasto_total_anual IS NULL
                 OR gasto_bar_por_visita IS NULL OR visitas_mensuales_m0 IS NULL
                 OR visitas_mensuales_m6 IS NULL
)
SELECT
    e.control,
    e.valor_esperado,
    ROUND(r.valor_real, 4) AS valor_real,
    CASE WHEN ABS(r.valor_real - e.valor_esperado) < 0.01 THEN 'OK' ELSE 'REVISAR' END AS estado
FROM esperado e
JOIN obtenido r ON r.control = e.control;
GO
