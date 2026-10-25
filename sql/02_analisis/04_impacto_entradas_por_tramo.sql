/* ============================================================================
   Script   : 04_impacto_entradas_por_tramo.sql
   Objetivo : Calcular ΔG = variación de ingresos por ENTRADAS en cada tramo.
              ΔFact = ΔG[G<P] − ΔG[G>P] + ΔC[G<P] + ΔC[G>P]
                      └──── entradas ───┘ └──── concesiones ───┘
   ============================================================================ */

USE cine;
GO

-- TODO 1: Declara @P y @R.


-- TODO 2: CTE usuarios_segmentados.


-- TODO 3: impacto_entradas por tramo:
--         Tramo 1 (G < P): ¿cuántos adoptan? × ¿cuánto MÁS paga cada uno que hoy?  → signo +
--         Tramo 2 (G ≥ P): ¿cuántos adoptan? × ¿cuánto MENOS paga cada uno que hoy? → signo −
--         Piensa: ¿usas el promedio del tramo o calculas fila a fila y luego sumas?
--         ¿Dan lo mismo? (spoiler: no siempre). Documenta tu elección.


-- ✅ Criterio de aceptación: Tramo 1 ≥ 0 y Tramo 2 ≤ 0.
