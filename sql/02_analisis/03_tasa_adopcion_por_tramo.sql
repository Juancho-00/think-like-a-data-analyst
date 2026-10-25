/* ============================================================================
   Script   : 03_tasa_adopcion_por_tramo.sql
   Objetivo : Convertir el incentivo en una tasa de adopción usando el
              Factor de Realidad R.
              Tasa de adopción = (Incentivo) ^ R
                R < 1 → optimista | R = 1 → neutral | R > 1 → conservador
   ============================================================================ */

USE cine;
GO

-- TODO 1: Declara @P y @R (valor inicial R = 1.0).


-- TODO 2: CTE usuarios_segmentados.


-- TODO 3: Tasa de adopción media por tramo.
--         Pista T-SQL: la función de potencia no se llama igual que en MySQL.


-- ✅ Prueba de escritorio: con gasto = 200 y P = 400 → R=0.5 ≈ 70.7 %, R=1 → 50 %, R=2 → 25 %.
