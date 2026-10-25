# 🎬 Pricing de un Pase VIP Anual de Cine con SQL

> **Estado:** 🚧 En construcción. Este README se completa al cerrar el proyecto.

¿Cuánto debería costar una tarifa plana anual para ir al cine sin límite? Si el pase es muy barato, canibaliza a los mejores clientes; si es muy caro, nadie lo compra. Este proyecto estima con **SQL Server** el precio que maximiza el incremento total de facturación de una cadena de cines, sumando el efecto sobre **taquilla** y sobre **bar/concesiones**.

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

Detalle completo en [`docs/02_diseno_analitico.md`](docs/02_diseno_analitico.md).

## 🛠️ Stack

SQL Server · T-SQL (CTEs, CASE, funciones de ventana) · SSMS · VS Code · Git/GitHub

## 📁 Estructura

```
├── data/                  # Instrucciones para obtener el dataset (data/raw/)
├── sql/
│   ├── 00_setup/          # Creación de la base y carga de datos
│   ├── 01_exploracion/    # Perfilamiento del dataset
│   ├── 02_analisis/       # Construcción paso a paso del modelo (01 → 05)
│   ├── 03_modelo_final/   # Script integrado: parámetros → tramos → impacto → totales
│   └── 04_escenarios/     # Sensibilidad de P y R, prueba de estrés
├── docs/                  # Contexto, diseño analítico, diccionario, decisiones, resultados
└── results/               # Exportes CSV de las corridas
```

## ▶️ Cómo reproducirlo

1. Sigue [`data/README.md`](data/README.md) para descargar y cargar los datos.
2. Ejecuta en SSMS los scripts de `sql/` en orden numérico.
3. Cambia `@P` y `@R` en `sql/03_modelo_final/modelo_pricing_pase_vip.sql` para simular escenarios.

## ⚠️ Limitaciones

_Pendiente: se documentan al terminar la prueba de estrés (`sql/04_escenarios/`)._

## 🙌 Créditos

Caso basado en el video [*Pensar como un Analista de Datos*](https://www.youtube.com/watch?v=2uVLRvBoW34) de **Data Science 4 Business**. La implementación en T-SQL, los análisis de sensibilidad y las conclusiones son de elaboración propia.

---

**Juan Pablo Quintero** — Financial Engineer · Data Analyst
[Portafolio](https://juancho-00.github.io) · [LinkedIn](https://www.linkedin.com/in/juan-quintero-354a09289) · [GitHub](https://github.com/Juancho-00)
