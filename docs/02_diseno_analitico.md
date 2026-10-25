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

## Mis notas de diseño

- ✍️ ¿Cómo calibré R con la prueba controlada?
- ✍️ ¿Qué supuesto de visitas extra usé para el bar y por qué?
- ✍️ ¿Promedio del tramo o cálculo fila a fila? ¿Por qué?
