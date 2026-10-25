/* ============================================================================
   Script   : 01_perfilamiento_entradas.sql
   Objetivo : Conocer los datos ANTES de modelar.
   Regla    : nunca simules un precio sin conocer la distribución del gasto.
   ============================================================================ */

USE cine;
GO

-- TODO 1: Conteo de filas, usuarios únicos y nulos por columna.


-- TODO 2: Mínimo, máximo, promedio y desviación estándar de gasto_entradas_anual.


-- TODO 3: Percentiles P25, P50, P75, P90 de gasto_entradas_anual.
--         Pista T-SQL: investiga PERCENTILE_CONT ... WITHIN GROUP ... OVER ().


-- TODO 4: Validaciones de consistencia:
--         a) ¿gasto_total_anual = gasto_entradas_anual + gasto_bar_anual?
--         b) ¿gasto_bar_por_visita ≈ gasto_bar_anual / (visitas_mensuales * 12)?
--         c) ¿Qué representan visitas_mensuales_m0 y visitas_mensuales_m6?
--            Compara sus promedios con visitas_mensuales.


-- TODO 5: Con los percentiles, propone un rango de precios P candidato
--         y anótalo en docs/05_resultados.md.
