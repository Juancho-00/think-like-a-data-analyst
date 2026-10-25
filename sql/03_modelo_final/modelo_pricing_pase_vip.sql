/* ============================================================================
   Proyecto : Pricing del Pase VIP Anual de Cine
   Script   : modelo_pricing_pase_vip.sql   (script final integrado)
   Objetivo : Estimar el incremento total de facturación (ΔFact) para un
              precio simulado P y un factor de realidad R.
   Motor    : SQL Server (T-SQL)  |  Autor: Juan Pablo Quintero
   ----------------------------------------------------------------------------
   Pipeline : parametros → usuarios_segmentados → modelo_impacto
              → agregación por tramo  UNION ALL  fila TOTAL
   ============================================================================ */

USE cine;
GO

-- ============================================================================
-- PARÁMETROS DE SIMULACIÓN
-- ============================================================================
-- TODO: Define los parámetros aquí (P = precio del pase VIP, R = factor de realidad,
--       y los de visitas extra que hayas decidido en el script 05).


WITH parametros AS (
    -- TODO: Expón las variables como una tabla de 1 fila (útil para el CROSS JOIN
    --       y, más adelante, para barrer varios precios a la vez).
    SELECT
        NULL AS placeholder
),

usuarios_segmentados AS (
    -- TODO: Cruza entradas con parametros (¿qué JOIN no necesita condición?).
    -- TODO: Haz el CASE WHEN para los tramos (Tramo 1 / Tramo 2).
    -- TODO: Calcula el incentivo de compra acotado entre 0 y 1.
    SELECT
        NULL AS placeholder
    FROM dbo.entradas
),

modelo_impacto AS (
    -- TODO: Calcula la tasa de adopción = incentivo ^ R.
    -- TODO: Impacto en entradas (ΔG): + en Tramo 1, − en Tramo 2.
    -- TODO: Calcula el impacto del bar (ΔC): adoptantes × visitas extra × gasto bar/visita.
    -- TODO: Impacto neto = ΔG + ΔC.
    SELECT
        NULL AS placeholder
    FROM usuarios_segmentados
)

-- TODO: Agregación final por tramo
SELECT
    NULL AS tramo
    -- , n_usuarios
    -- , adoptantes_esperados
    -- , impacto_entradas
    -- , impacto_bar
    -- , impacto_total
FROM modelo_impacto
-- GROUP BY ...

UNION ALL

-- TODO: Fila TOTAL (mismas columnas, mismo orden, tipos compatibles)
SELECT
    'TOTAL' AS tramo
    -- , ...
FROM modelo_impacto;

/* ✅ Criterios de aceptación
   - Corre de principio a fin sin errores.
   - La fila TOTAL = suma de las filas por tramo.
   - Cambiar P o R en UN solo lugar recalcula todo.
   - Resultados registrados en docs/05_resultados.md.
*/
