# 📊 Resultados

## 1. Perfilamiento de `dbo.entradas`

Script: [`sql/01_exploracion/01_perfilamiento_entradas.sql`](../sql/01_exploracion/01_perfilamiento_entradas.sql)

### Calidad de datos

| Control | Resultado |
|---|---|
| Filas / usuarios únicos | 1.000 / 1.000 (1 fila por usuario) |
| Nulos | 0 en las 8 columnas |
| `gasto_total_anual = entradas + bar` | ✅ Cuadra en las 1.000 filas (diferencias ≤ 0,005 por redondeo del dump) |
| `gasto_bar_por_visita = bar anual / (visitas × 12)` | ✅ Cuadra en las 1.000 filas |
| Precio implícito por entrada | 8 € fijo para todos los usuarios |
| `visitas_mensuales_m0` | Idéntica a `visitas_mensuales` en las 1.000 filas |
| `visitas_mensuales_m6` | 234 usuarios suben, 153 bajan y 613 se mantienen. Suben quienes iban 3–4 veces al mes y bajan quienes iban 5–8. |

### Distribución de `gasto_entradas_anual`

| Estadístico | Valor |
|---|---|
| Mínimo / Máximo | 96 € / 768 € |
| Media | 252 € |
| Desviación estándar (poblacional) | 157,2 € |
| P25 / Mediana / P75 / P90 | 96 € / 192 € / 288 € / 480 € |

La variable es **discreta**: `gasto_entradas_anual = visitas_mensuales × 12 × 8 €`, así que solo toma 8 valores.

| Gasto anual | Visitas/mes | Usuarios | % | % acumulado |
|---|---|---|---|---|
| 96 € | 1 | 319 | 31,9 % | 31,9 % |
| 192 € | 2 | 240 | 24,0 % | 55,9 % |
| 288 € | 3 | 198 | 19,8 % | 75,7 % |
| 384 € | 4 | 90 | 9,0 % | 84,7 % |
| 480 € | 5 | 74 | 7,4 % | 92,1 % |
| 576 € | 6 | 57 | 5,7 % | 97,8 % |
| 672 € | 7 | 16 | 1,6 % | 99,4 % |
| 768 € | 8 | 6 | 0,6 % | 100 % |

### Rango candidato de P

| P candidato | Usuarios Tramo 1 (G < P) | Usuarios Tramo 2 (G ≥ P) |
|---|---|---|
| 192 € | 319 | 681 |
| 288 € | 559 | 441 |
| 300 € | 757 | 243 |
| 384 € | 757 | 243 |
| 400 € | 847 | 153 |
| 480 € | 847 | 153 |
| 500 € | 921 | 79 |
| 576 € | 921 | 79 |

**Rango propuesto: P entre 288 € (P75) y 576 € (≈ P92).** Se barre de 25 € en 25 € y se mira con atención cada corte (288 · 384 · 480 · 576).

- **Límite inferior.** Con P ≤ 192 € (la mediana), más de la mitad de la base gastaría lo mismo o más que el pase → la canibalización domina.
- **Límite superior.** Con P > 768 € (el máximo), el Tramo 2 queda vacío y el resultado deja de tener sentido económico (ver prueba de estrés).
- **Efecto escalón.** Como G es discreto, la segmentación solo cambia cuando P cruza un múltiplo de 96 €. Por ejemplo, P = 300 € y P = 384 € producen los mismos tramos. Hay que tenerlo en cuenta al leer la curva ΔFact vs P.

## 2. Bitácora de corridas

| Corrida | P | R | Usuarios T1 | Usuarios T2 | Adoptantes | ΔG entradas | ΔC bar | ΔFact | Observación |
|---|---|---|---|---|---|---|---|---|---|
| 1 | 400 | 1.0 | | | | | | | |
| 2 | | | | | | | | | |
| 3 | | | | | | | | | |

## 3. Precio óptimo

- **P\*** = ✍️
- **ΔFact esperado** = ✍️
- Rango robusto (P que siguen siendo rentables con R entre 0.5 y 2): ✍️

## 4. Prueba de estrés P = 10 000

- Predicción antes de correr: ✍️
- Resultado real: ✍️
- Explicación: ✍️

## 5. Limitaciones identificadas

1. ✍️
2. ✍️
3. ✍️

## 6. Gráficos

<!-- Exporta la curva ΔFact vs P a docs/img/curva_precio.png y enlázala aquí -->
