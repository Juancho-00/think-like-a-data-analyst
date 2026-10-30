# 📈 Diseño analítico

## Ecuación objetivo

```
ΔFact = ΔG[G<P] − ΔG[G≥P] + ΔC[G<P] + ΔC[G≥P]
        └──── ingresos por entradas ────┘ └── ingresos por concesiones ──┘
```

| Término | Significado |
|---|---|
| G | Gasto actual anual del usuario en entradas |
| P | Precio simulado del pase VIP |
| ΔG[G<P] | Ingreso **extra** por entradas de quienes hoy gastan menos que P y compran el pase |
| ΔG[G≥P] | Ingreso **perdido** por entradas de quienes hoy gastan más que P (canibalización) |
| ΔC[·] | Ingreso incremental en bar por las visitas adicionales de quienes compran el pase |

## Metodología para pensar el problema

1. **Entender el objetivo real:** ¿captar clientes, retener, o maximizar facturación? (Aquí: maximizar facturación).
2. **Identificar las palancas:** entradas (puede subir o bajar según el tramo) y concesiones (siempre sube por mayor frecuencia).
3. **Pasar a diseño analítico:** traducir las palancas a una ecuación cuantificable.
4. **Hacer el cálculo final** con los datos.

## Modelo en 4 pasos (cálculo)

1. **Segmentar** en dos tramos: gasto menor y mayor al precio P.
2. **Estimar el atractivo** del pase para cada usuario → indicador de incentivo.
3. **Ajustar el modelo sobre datos reales** → piloto controlado con pocos usuarios → factor R (en desarrollo R = 1).
4. **Calcular el neto esperado** → ΔFact.

## Fórmulas

**Incentivo de compra** (acotado a [0, 1]):

```
Incentivo = min( gasto_entradas_anual / P , 1 )
```

**Tasa de adopción** (con factor de realidad R):

```
Tasa de adopción = Incentivo ^ R
```

| R | Comportamiento | Resultado |
|---|---|---|
| R < 1 | Optimista: alta adopción con poco incentivo | Más usuarios adoptan |
| R = 1 | Neutral: adopción proporcional al incentivo | Línea recta |
| R > 1 | Conservador: poca adopción si el incentivo no es fuerte | Solo los cercanos a P convierten |

## Segmentación en dos tramos

| | Tramo 1 | Tramo 2 |
|---|---|---|
| Condición | `gasto_entradas_anual < P` | `gasto_entradas_anual ≥ P` |
| ¿Compra el pase? | Probable, según qué tan cerca esté G de P | Seguro (el pase le sale igual o más barato) |
| Ingreso por entradas | Sube: paga P en vez de G (+ P − G) | Baja: paga P en vez de G (− (G − P)) |
| Gasto en bar | Sube: viene más veces | Sube: viene algo más (ya venía mucho) |
| Naturaleza | Ingreso incremental | Canibalización |

Regla de borde: un usuario con G = P exacto cae en el **Tramo 2** (igual que en el caso original). Su incentivo es 1 y su impacto en entradas es 0: paga lo mismo y solo suma en bar.

## Parámetros del modelo

| Parámetro | Valor inicial | Rango | Significado |
|---|---|---|---|
| `P` | 400 € | 288 – 576 € (ver perfilamiento) | Precio simulado del pase |
| `R` | 1,0 | R ≥ 0 (prueba: 0,5 · 1 · 2) | Factor de realidad calibrado con un piloto |
| Visitas extra Tramo 1 | +12 al año (+1 al mes) | Supuesto | Quien venía poco viene una vez más al mes |
| Visitas extra Tramo 2 | +10 % de sus visitas anuales | Supuesto | Quien ya venía mucho tiene menos margen para venir más |

## Ecuaciones por componente

```
Tasa adopción     = min(G / P, 1) ^ R
ΔG Tramo 1        = + usuarios × tasa × (P − G)
ΔG Tramo 2        = − usuarios × tasa × (G − P)
ΔC Tramo 1        = + usuarios × tasa × 12 visitas extra × gasto bar por visita
ΔC Tramo 2        = + usuarios × tasa × (visitas anuales × 10 %) × gasto bar por visita
ΔFact             = ΔG T1 + ΔG T2 + ΔC T1 + ΔC T2
```

## Notas de diseño

- **Por qué un exponente para R y no una multiplicación.** Si el incentivo está entre 0 y 1 y R ≥ 0, entonces incentivo^R también está entre 0 y 1: sigue siendo una tasa. Multiplicar (incentivo × R) podría dar valores mayores que 1. Con R = 1 el incentivo no cambia.
- **Calibración de R.** No sale de la tabla: requiere un piloto con un grupo pequeño y controlado de usuarios a quienes se ofrece el pase a un precio conocido. Se compara la adopción observada con la que predice el modelo y se elige el R que mejor la reproduce. Mientras no exista piloto, R = 1 y se hace análisis de sensibilidad con 0,5 y 2.
- **Por qué capar el incentivo en 1.** Para G ≥ P, el cociente G / P supera 1, pero una tasa de adopción no puede superar el 100 %. En SQL Server: `LEAST` (desde la versión 2022) o, en versiones anteriores, `IIF` / `CASE`.
- **División por cero.** Solo es posible si P = 0. Se protege con `NULLIF(@P, 0)`. `visitas_mensuales` nunca es 0 (mínimo 1).
- **Promedio del tramo vs cálculo fila a fila.** El caso original calcula con los **promedios de cada tramo** y este proyecto lo replica para poder comparar. Ojo: no es equivalente a calcular usuario por usuario y sumar. El promedio de un producto no es igual al producto de los promedios, en particular en `tasa × (P − G)` del Tramo 1. En la fase 4 se cuantifica la diferencia como mejora del modelo.
