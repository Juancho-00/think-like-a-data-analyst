/* ============================================================================
   Script   : 05_impacto_bar_por_tramo.sql
   Objetivo : Calcular ΔC = ingreso incremental en BAR/concesiones.
              Idea: quien tiene el pase viene más veces → más consumo en bar.
   ============================================================================ */

USE cine;
GO

-- TODO 1: Declara @P, @R y el/los parámetro(s) de visitas extra que necesites.
--         Decide si el aumento de visitas es igual para ambos tramos o distinto
--         (¿quién tiene más margen para venir más: alguien que casi no va o
--         alguien que ya va mucho?). Escribe el supuesto en el decision log.


-- TODO 2: CTE usuarios_segmentados.


-- TODO 3: impacto_bar por tramo =
--         adoptantes × visitas extra al año × gasto en bar por visita.
--         La tabla NO trae cuántas visitas extra hará quien compre el pase:
--         es un supuesto tuyo. ¿Fijo (p. ej. +1 visita/mes) o proporcional
--         a su frecuencia actual? Justifícalo.


-- ✅ Criterio de aceptación: impacto_bar ≥ 0 en ambos tramos.
