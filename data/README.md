# 📦 Datos

| Archivo | Descripción |
|---|---|
| `raw/dump_cine_mysql.sql` | Dump original (MySQL 8) de la base `cine`, tabla `entradas`: 1.000 usuarios, 8 columnas. Fuente: [Data Science 4 Business](https://www.youtube.com/watch?v=2uVLRvBoW34). |

## Carga en SQL Server

El dump es de MySQL, así que no se ejecuta directamente en SSMS. Se tradujo a T-SQL en `sql/00_setup/`:

1. `00_create_database.sql`: crea la base `cine` y la tabla `dbo.entradas` (con PK en `user_id`).
2. `01_load_entradas.sql`: inserta los 1.000 registros en 4 lotes de 250 (SQL Server admite máximo 1.000 filas por `VALUES`).
3. `02_validacion_carga.sql`: compara conteos y sumas contra los totales calculados sobre el dump. Todo debe salir `OK`.

## Totales de control

| Control | Valor |
|---|---|
| Filas / `user_id` únicos | 1.000 / 1.000 |
| Suma `gasto_entradas_anual` | 252.000 |
| Suma `gasto_bar_anual` | 128.306,8254 |
| Nulos | 0 |
