/* ============================================================================
   Proyecto : Pricing del Pase VIP Anual de Cine
   Script   : 00_create_database.sql
   Objetivo : Crear la base de datos `cine` y la tabla dbo.entradas en SQL Server.
   Origen   : traducción del DDL MySQL de data/raw/dump_cine_mysql.sql
   Uso      : ejecutar completo (F5) en SSMS. Es re-ejecutable (borra y recrea la tabla).
   ----------------------------------------------------------------------------
   Traducción MySQL → T-SQL
     CREATE DATABASE IF NOT EXISTS `cine`  → IF DB_ID('cine') IS NULL CREATE DATABASE cine
     `backticks`                           → sin comillas (o [corchetes])
     float                                 → FLOAT (ver decisión abajo)
     ENGINE=InnoDB / CHARSET / COLLATE     → no aplican en SQL Server
     user_id int DEFAULT NULL (sin PK)     → INT NOT NULL + PRIMARY KEY
   Decisión de tipos
     Se usa FLOAT en todas las métricas para replicar el comportamiento del
     modelo original (promedios y divisiones en coma flotante) y evitar la
     división entera de T-SQL si una columna fuese INT.
   ============================================================================ */

IF DB_ID(N'cine') IS NULL
    CREATE DATABASE cine;
GO

USE cine;
GO

DROP TABLE IF EXISTS dbo.entradas;
GO

CREATE TABLE dbo.entradas (
    user_id               INT   NOT NULL,  -- Identificador único del usuario
    visitas_mensuales     FLOAT NULL,      -- Visitas promedio al mes
    gasto_entradas_anual  FLOAT NULL,      -- Gasto anual en entradas (G)
    gasto_bar_anual       FLOAT NULL,      -- Gasto anual en bar / concesiones
    gasto_total_anual     FLOAT NULL,      -- Entradas + bar
    gasto_bar_por_visita  FLOAT NULL,      -- Gasto en bar por visita
    visitas_mensuales_m0  FLOAT NULL,      -- Visitas del mes 1 (ventana de 6 meses)
    visitas_mensuales_m6  FLOAT NULL,      -- Visitas del mes 6 (ventana de 6 meses)
    CONSTRAINT PK_entradas PRIMARY KEY CLUSTERED (user_id)
);
GO
