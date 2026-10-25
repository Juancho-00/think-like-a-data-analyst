/* ============================================================================
   Script   : 01_datos_agregados_por_tramo.sql
   Objetivo : Segmentar a los usuarios en Tramo 1 / Tramo 2 según su gasto
              actual en entradas frente al precio simulado P, y describir
              cada tramo.
   ============================================================================ */

USE cine;
GO

-- TODO 1: Declara el parámetro @P (precio del pase). Valor inicial: 400.
--         Ojo: en T-SQL no existe "SET @P = ..." sin declarar antes la variable.


-- TODO 2: CTE usuarios_segmentados: todas las columnas + columna `tramo`
--         con un CASE WHEN que compare gasto_entradas_anual contra @P.
--         Decide (y documenta) en qué tramo cae un usuario con gasto = P exacto.


-- TODO 3: SELECT final agrupado por tramo con:
--         n_usuarios, gasto_entradas_anual medio, visitas_mensuales media,
--         gasto_bar_por_visita medio (redondeados a 2 decimales).


-- ✅ Criterio de aceptación: la suma de n_usuarios de ambos tramos = total de la tabla.
