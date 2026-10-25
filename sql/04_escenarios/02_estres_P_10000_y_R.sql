/* ============================================================================
   Script   : 02_estres_P_10000_y_R.sql
   Objetivo : Llevar el modelo a los extremos y detectar sus límites.
   ============================================================================ */

USE cine;
GO

-- RETO 1: Corre el modelo final con P = 10000.
--   Antes de ejecutar, escribe tu predicción en docs/05_resultados.md:
--     ¿cuántos usuarios en cada tramo? ¿ΔFact positivo o negativo?
--   Después compara y explica la diferencia.


-- RETO 2: Matriz de sensibilidad P × R
--   R ∈ {0.5, 1.0, 2.0}  ×  P ∈ {tu rango}
--   ¿El P óptimo cambia cuando el mercado es más conservador?


-- RETO 3 (Ingeniería Financiera): el pase se cobra por adelantado.
--   Con una tasa mensual i, ¿cuánto vale hoy el flujo de entradas que llegaría
--   repartido durante 12 meses? ¿Cambia la conclusión?
