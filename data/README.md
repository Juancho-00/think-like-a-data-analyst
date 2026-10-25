# 📦 Datos

El dataset y los scripts originales (MySQL) se descargan desde el enlace en la descripción del video:
[Pensar como un Analista de Datos — Data Science 4 Business](https://www.youtube.com/watch?v=2uVLRvBoW34)

## Pasos

1. Descarga el dump / CSV y guárdalo en `data/raw/`.
2. Ejecuta `sql/00_setup/00_create_database.sql` en SSMS.
3. Ejecuta `sql/00_setup/01_load_entradas.sql`.
4. Verifica el conteo de filas con `sql/01_exploracion/01_perfilamiento_entradas.sql`.

## Notas

- El dump original está escrito para **MySQL**; la carga en SQL Server requiere adaptar el DDL (ver `docs/04_decisiones_y_supuestos.md`).
- Si el archivo pesa más de ~50 MB, no lo subas a GitHub: activa la regla `data/raw/*` en `.gitignore`.
- Los scripts de solución del autor **no** se versionan en este repositorio: el código de `sql/` es de elaboración propia.
