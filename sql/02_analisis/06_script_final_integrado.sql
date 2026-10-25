/* ============================================================================
   Proyecto : Pricing del Pase VIP Anual de Cine
   Script   : 06_script_final_integrado.sql
   Objetivo : Integrar los scripts 01–05 en un solo modelo parametrizado que
              devuelva el impacto por tramo y el TOTAL.
   Motor    : SQL Server (T-SQL)  |  Autor: Juan Pablo Quintero
   ----------------------------------------------------------------------------
   Pipeline : usuarios_segmentados → resumen_tramos → impacto_entradas
              → impacto_bar → impacto_total → detalle UNION ALL TOTAL
   ============================================================================ */

USE cine;
GO

-- ============================================================================
-- PARÁMETROS DE SIMULACIÓN
-- ============================================================================
-- TODO: Declara @P (precio del pase VIP) y @R (factor de sensibilidad del incentivo).


-- ============================================================================
-- CÁLCULO POR TRAMOS
-- ============================================================================
WITH usuarios_segmentados AS (
    -- TODO: Todas las columnas + CASE WHEN para Tramo 1 / Tramo 2 (script 01).
    SELECT NULL AS placeholder
),

resumen_tramos AS (
    -- TODO: Una fila por tramo con: n_usuarios, gasto_entradas_anual_medio,
    --       visitas_mensuales_media, gasto_bar_por_visita_medio,
    --       incentivo (script 02) y tasa_adopcion (script 03).
    SELECT NULL AS placeholder
),

impacto_entradas AS (
    -- TODO: Impacto en entradas por tramo (script 04), usando las columnas de resumen_tramos.
    SELECT NULL AS placeholder
),

impacto_bar AS (
    -- TODO: Impacto en bar por tramo (script 05), usando las columnas de resumen_tramos.
    SELECT NULL AS placeholder
),

-- ============================================================================
-- RESULTADO FINAL: IMPACTO ECONÓMICO TOTAL
-- ============================================================================
impacto_total AS (
    -- TODO: Une impacto_entradas e impacto_bar por tramo y calcula impacto_total.
    --       Ojo T-SQL: JOIN ... USING (col) no existe; usa ON.
    SELECT NULL AS placeholder
)

-- TODO: Detalle por tramo (redondeado a 2 decimales) + columna `orden` para ordenar.
SELECT NULL AS tramo
FROM impacto_total

UNION ALL

-- TODO: Fila 'TOTAL' con las sumas (mismas columnas, mismo orden).
SELECT 'TOTAL'
FROM impacto_total;
-- TODO: ORDER BY orden;

/* ✅ Criterios de aceptación
   - Corre de principio a fin sin errores en SSMS (F5).
   - TOTAL = Tramo 1 + Tramo 2.
   - Cambiar @P en un solo lugar recalcula todo.
   - Con @P = 400 y @R = 1 coincide con los valores de control del video (toggle 🔒 en Notion).
*/
