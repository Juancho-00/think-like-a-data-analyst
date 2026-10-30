# 🎬 Pricing de un Pase VIP Anual de Cine con SQL

> **Estado:** 🚧 En construcción. Este README se completa al cerrar el proyecto.

¿Cuánto debería costar una tarifa plana anual para ir al cine sin límite? Si el pase es muy barato, canibaliza a los mejores clientes; si es muy caro, nadie lo compra. Este proyecto estima con **SQL Server** el precio que maximiza el incremento total de facturación de una cadena de cines, sumando el efecto sobre **taquilla** y sobre **bar/concesiones**.

## 🚦 Avance

| Etapa | Estado |
|---|---|
| Enfoque de negocio: objetivo, palancas y KPI (ΔFact) | ✅ |
| Diseño analítico: tramos, incentivo, factor R y supuestos | ✅ |
| Setup y carga en SQL Server (1.000 usuarios validados) | ✅ |
| Perfilamiento de datos y rango candidato de P | ✅ |
| Modelo paso a paso (scripts 01 → 05) | 🔄 1 de 5 (segmentación por tramos ✅) |
| Script final integrado (06) | ⏳ |
| Escenarios y prueba de estrés | ⏳ |

## 🔍 Hallazgos del perfilamiento

- **Gasto discreto.** Cada entrada cuesta 8 €, así que el gasto anual en entradas solo toma 8 valores (96 € a 768 €) y los tramos solo cambian en múltiplos de 96 €.
- **Base concentrada en usuarios ocasionales.** La mediana es 192 € y la media 252 €: el 56 % de los usuarios va al cine 1 o 2 veces al mes.
- **Rango candidato del pase: 288 € – 576 €** (del P75 a ≈ P92). Por debajo de la mediana domina la canibalización; por encima de 768 € no queda nadie por canibalizar y el modelo pierde sentido.

- **Segmentación con P = 400 €:** 847 usuarios (84,7 %) gastan menos que el pase y 153 (15,3 %) gastan más. Estos últimos promedian 547 € al año y casi 6 visitas al mes: son el ingreso en riesgo de canibalización.

Detalle en [`docs/05_resultados.md`](docs/05_resultados.md).

## 📌 Resultado principal

| Métrica | Valor |
|---|---|
| Precio óptimo del pase (P\*) | _pendiente_ |
| Incremento de facturación esperado (ΔFact) | _pendiente_ |
| Usuarios que adoptarían el pase | _pendiente_ |
| Rango de precios robusto (R entre 0.5 y 2) | _pendiente_ |

<!-- Inserta aquí la curva ΔFact vs P: ![Curva de precio](docs/img/curva_precio.png) -->

## 🧠 Enfoque

```
ΔFact = ΔG[G<P] − ΔG[G≥P] + ΔC[G<P] + ΔC[G≥P]
        └──── entradas ────┘ └──── concesiones ────┘
```

1. **Segmentar** a los usuarios en dos tramos según su gasto actual en entradas (G) frente al precio simulado (P).
2. **Estimar el incentivo** de compra: `min(G / P, 1)`.
3. **Ajustar a la realidad** con un factor R calibrado en una prueba controlada: `adopción = incentivo ^ R`.
4. **Calcular el neto esperado**: ingreso extra en taquilla − canibalización + consumo adicional en bar.

**Supuestos clave:** la venta del pase reemplaza la taquilla de quien lo compra, por eso se modela como P − G por comprador y no como una línea aparte. El Tramo 1 suma 1 visita extra al mes y el Tramo 2 un 10 % más de visitas. R = 1 hasta calibrarlo con un piloto. Lista completa en [`docs/04_decisiones_y_supuestos.md`](docs/04_decisiones_y_supuestos.md).

Detalle completo en [`docs/02_diseno_analitico.md`](docs/02_diseno_analitico.md).

## 🛠️ Stack

SQL Server · T-SQL (CTEs, CASE, funciones de ventana) · SSMS · VS Code · Git/GitHub

## 📁 Estructura

```
├── data/raw/              # Dump MySQL original del dataset
├── sql/
│   ├── 00_setup/          # Base `cine`, tabla dbo.entradas, carga (1.000 usuarios) y validación
│   ├── 01_exploracion/    # Perfilamiento del dataset
│   ├── 02_analisis/       # Modelo paso a paso (01 → 05) y script final integrado (06)
│   └── 03_escenarios/     # Sensibilidad de P y R, prueba de estrés
├── docs/                  # Contexto, diseño analítico, diccionario, decisiones, resultados
└── results/               # Exportes CSV de las corridas
```

## ▶️ Cómo reproducirlo

1. En SSMS ejecuta `sql/00_setup/00_create_database.sql`, `01_load_entradas.sql` y `02_validacion_carga.sql` (todos los controles deben salir `OK`).
2. Ejecuta los scripts de `sql/02_analisis/` en orden.
3. Cambia `@P` y `@R` en `sql/02_analisis/06_script_final_integrado.sql` para simular escenarios.

## ⚠️ Limitaciones

_Pendiente: se documentan al terminar la prueba de estrés (`sql/03_escenarios/`)._

## 🙌 Créditos

Caso basado en el video [*Pensar como un Analista de Datos*](https://www.youtube.com/watch?v=2uVLRvBoW34) de **Data Science 4 Business**. La implementación en T-SQL, los análisis de sensibilidad y las conclusiones son de elaboración propia.

---

**Juan Pablo Quintero** — Financial Engineer · Data Analyst
[Portafolio](https://juancho-00.github.io) · [LinkedIn](https://www.linkedin.com/in/juan-quintero-354a09289) · [GitHub](https://github.com/Juancho-00)
