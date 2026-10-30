/* ============================================================================
   Script   : 02_incentivo_medio_por_tramo.sql
   Objetivo : Calcular el indicador de incentivo de compra (entre 0 y 1).
              Incentivo = min( gasto_entradas_anual / P , 1 )
   Autor    : Juan Pablo Quintero
   ----------------------------------------------------------------------------
   Motor    : SQL Server 2022 → LEAST disponible de forma nativa.
   Se comparan dos formas de calcular el incentivo de un tramo:
     A) LEAST(AVG(G) / P, 1)  → incentivo del usuario promedio (caso original)
     B) AVG(LEAST(G / P, 1))  → promedio de los incentivos individuales
   ============================================================================ */

USE cine;
GO

-- ============================================================================
-- PARÁMETRO DE SIMULACIÓN
-- ============================================================================
DECLARE @P FLOAT = 400.0; -- Precio simulado del pase VIP

-- ============================================================================
-- SEGMENTACIÓN (misma CTE del script 01)
-- ============================================================================
WITH usuarios_segmentados AS (

   SELECT *,

   CASE
      WHEN gasto_entradas_anual < @P THEN 'Tramo 1'
      ELSE 'Tramo 2'
   END AS tramo

   FROM dbo.entradas
)

-- ============================================================================
-- INCENTIVO POR TRAMO: forma A (usuario promedio) vs forma B (promedio individual)
-- ============================================================================
SELECT

   tramo,
   ROUND(LEAST(AVG(gasto_entradas_anual) / @P, 1), 3) AS incentivo_medio,             -- A
   ROUND(AVG(LEAST(gasto_entradas_anual / @P, 1)), 3) AS incentivo_promedio_individual -- B

FROM usuarios_segmentados
GROUP BY tramo
ORDER BY tramo ASC;
GO

/* ✅ Validación (P = 400)
   | Tramo   | incentivo_medio (A) | incentivo_promedio_individual (B) |
   |---------|---------------------|-----------------------------------|
   | Tramo 1 | 0.497               | 0.497                             |
   | Tramo 2 | 1.000               | 1.000                             |

   ¿Por qué A = B aquí? El corte de los tramos (G < P) coincide con el punto
   donde actúa el tope:
   - Tramo 1: todos tienen G < P → G/P < 1 → LEAST nunca recorta. Sin tope,
     el promedio de G/P es igual al promedio de G dividido por P (operación lineal).
   - Tramo 2: todos tienen G ≥ P → los dos cálculos dan exactamente 1.
   Sin segmentar (toda la base), A = 0,630 y B = 0,574: ahí el tope sí
   recorta de forma desigual y B < A.
*/
