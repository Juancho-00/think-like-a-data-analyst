# 🎯 Contexto de negocio

## El caso

Una cadena de cines quiere lanzar un **pase VIP anual**: el cliente paga una tarifa plana P una vez al año y puede ir al cine todas las veces que quiera.

**Pregunta:** ¿cuál es el precio P que maximiza el incremento total de facturación?

## Objetivo real (paso 1: reformular y clarificar)

"Optimizar el precio" puede servir a objetivos distintos, y cada uno lleva a acciones distintas:

| Posible objetivo | Qué se optimizaría |
|---|---|
| Captar clientes nuevos | Volumen de pases vendidos |
| Frenar la fuga hacia otros cines | Retención / frecuencia |
| **Maximizar la facturación** ✅ | **Ingreso total incremental frente a no lanzar el pase** |

Objetivo confirmado: **maximizar la facturación**.

## Pregunta de negocio en una frase

> ¿A qué precio anual debe venderse el pase VIP para que el ingreso total del cine (taquilla + bar) sea lo más alto posible frente al escenario de no lanzarlo?

## El dilema

| Si P es… | Efecto |
|---|---|
| Muy bajo | Los clientes que hoy gastan mucho pagan menos → **canibalización** del ingreso por entradas |
| Muy alto | Casi nadie lo compra → no se capturan ni el ingreso del pase ni las visitas extra al bar |

## Palancas de ingreso (paso 2)

| Palanca | Efecto del pase | Dirección | Por qué |
|---|---|---|---|
| Entradas: clientes que hoy gastan **menos** que P (Tramo 1) | Quien compra el pase paga P en vez de su gasto actual G | ⬆️ Sube (+ P − G por comprador) | Paga más de lo que gastaba |
| Entradas: clientes que hoy gastan **más** que P (Tramo 2) | Pasan de pagar G a pagar P | ⬇️ Baja (− (G − P) por comprador) | Canibalización: el pase les sale más barato |
| Bar / concesiones (ambos tramos) | Con el pase pagado, vienen más veces y consumen más | ⬆️ Siempre sube | Cada visita extra trae gasto en bar |
| Venta del pase (P × compradores) | Reemplaza la taquilla de quien lo compra | Incluida en las dos filas de entradas | Contarla aparte duplicaría el ingreso |

## Riesgos de canibalización

- **Genera canibalización:** el cliente intensivo (Tramo 2), que hoy gasta más que P y compraría el pase con seguridad.
- **Genera ingreso incremental:** el cliente que gasta algo menos que P (Tramo 1 cercano al corte) y que lo compra para venir más.
- **Otros riesgos:** capacidad de las salas en horas pico; margen (la taquilla se reparte con la distribuidora y el bar tiene más margen); compromiso anual que frena la compra; usuarios que vienen más pero no consumen en el bar.

## KPI objetivo

**ΔFact = incremento total de facturación frente al escenario sin pase**, la suma de lo que se gana en entradas con el Tramo 1, menos lo que se pierde con el Tramo 2, más el consumo extra en bar de ambos tramos. Es un **delta**, no un nivel.

## Supuestos del enfoque

1. Solo se modelan clientes con tarjeta de fidelización (los únicos con historial de visitas y gasto).
2. El comportamiento histórico anual es representativo del año en que se lanza el pase.
3. Quien compra el pase deja de pagar entradas sueltas; no hay ingresos por clientes nuevos fuera de la base.
4. El gasto en bar por visita se mantiene constante aunque aumenten las visitas.
