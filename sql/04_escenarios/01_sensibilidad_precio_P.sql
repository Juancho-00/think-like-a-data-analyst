/* ============================================================================
   Script   : 01_sensibilidad_precio_P.sql
   Objetivo : Encontrar el P que maximiza ΔFact barriendo varios precios
              en UNA sola ejecución (nivel avanzado).
   ============================================================================ */

USE cine;
GO

-- TODO 1: Convierte la CTE `parametros` en una lista de precios
--         (p. ej. de 50 en 50 dentro del rango que salió del perfilamiento).
--         Pistas: tabla de valores (VALUES), CTE recursiva o GENERATE_SERIES (SQL Server 2022+).


-- TODO 2: Reutiliza la lógica del modelo final, pero agrupando por precio.


-- TODO 3: Ordena por impacto_total y quédate con el P óptimo.
--         Exporta el resultado a results/sensibilidad_P.csv para graficar la curva.
