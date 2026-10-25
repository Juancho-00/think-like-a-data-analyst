/* ============================================================================
   Script   : 02_incentivo_medio_por_tramo.sql
   Objetivo : Calcular el indicador de incentivo de compra (entre 0 y 1).
              Incentivo = min( gasto_entradas_anual / P , 1 )
   ============================================================================ */

USE cine;
GO

-- TODO 1: Declara @P.


-- TODO 2: Reutiliza la CTE usuarios_segmentados del script 01.


-- TODO 3: Calcula el incentivo medio por tramo, capado a 1.0.
--         Reto T-SQL: la función que usa el video (LEAST) solo existe en
--         SQL Server 2022+ / Azure SQL. Revisa tu versión con SELECT @@VERSION
--         y, si no la tienes, resuélvelo con otra construcción condicional.


-- ✅ Criterio de aceptación: ningún valor < 0 ni > 1. ¿Cuánto da el incentivo del Tramo 2? ¿Por qué?
