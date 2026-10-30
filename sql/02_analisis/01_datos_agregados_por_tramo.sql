/* ============================================================================
   Script   : 01_datos_agregados_por_tramo.sql
   Objetivo : Segmentar a los usuarios en Tramo 1 / Tramo 2 según su gasto
              actual en entradas frente al precio simulado P, y describir
              cada tramo.
   Autor    : Juan Pablo Quintero
   ----------------------------------------------------------------------------
   Regla de tramos : Tramo 1 si gasto_entradas_anual < P; si no, Tramo 2.
                     Un usuario con gasto = P exacto cae en el Tramo 2
                     (decisión #11 del decision log).
   Resultado (P = 400) : Tramo 1 = 847 usuarios · Tramo 2 = 153 usuarios.
   ============================================================================ */

USE cine;
GO

-- ============================================================================
-- PARÁMETRO DE SIMULACIÓN (único lugar donde se cambia el precio)
-- ============================================================================
DECLARE @P FLOAT = 400.0; -- Precio simulado del pase VIP

-- ============================================================================
-- SEGMENTACIÓN Y RESUMEN POR TRAMO
-- ============================================================================
WITH usuarios_segmentados AS (

   SELECT *,

   CASE
      WHEN gasto_entradas_anual < @P THEN 'Tramo 1'
      ELSE 'Tramo 2'
   END AS tramo

   FROM dbo.entradas
)

-- Prueba de la CTE (descomentar para inspeccionar fila a fila):
-- SELECT TOP 10 * FROM usuarios_segmentados;

SELECT

   tramo,
   COUNT(user_id) AS n_usuarios,
   ROUND(AVG(gasto_entradas_anual), 2) AS gasto_entradas_anual_medio,
   ROUND(AVG(visitas_mensuales), 2) AS visitas_mensuales_media,
   ROUND(AVG(gasto_bar_por_visita), 2) AS gasto_bar_por_visita_medio

FROM usuarios_segmentados
GROUP BY tramo
ORDER BY tramo ASC;
GO

/* ✅ Validación
   | P   | Tramo | n_usuarios | gasto_entradas_medio | visitas_mes_media | bar_por_visita_medio |
   |-----|-------|------------|----------------------|-------------------|----------------------|
   | 400 | 1     | 847        | 198.69               | 2.07              | 4.11                 |
   | 400 | 2     | 153        | 547.14               | 5.70              | 4.02                 |
   | 300 | 1     | 757        | 176.66               | 1.84              | 4.14                 |
   | 300 | 2     | 243        | 486.72               | 5.07              | 3.97                 |
   - 847 + 153 = 1.000 ✔ (todos los usuarios quedan en exactamente un tramo)
   - Coincide con el caso original (847 / 153 con P = 400).
*/
