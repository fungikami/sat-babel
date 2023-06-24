#
### CI5437 - Inteligencia Artificial 1
##### Prof. Carlos Infante

# Proyecto 3

<div style='text-align: right;'>
Por <a href='https://www.github.com/chrischriscris'>Chus</a> | <a href='https://www.github.com/fungikami'>K</a>
</div>

## 1. Introducción

SAT es importante

## 2. Detalles de implementación

### 2.1. Representación del problema

<!-- How can I insert inline latex?: $x^2$ -->
$x_{ijkl}$: Variable que representa si el jugador $i$ juega local contra el jugador $j$ el día $k$ a la hora $l$.

$$x_{ijkl} \in \{\text{True}, \text{False}\}$$
$$i,j \in [0..n)$$
$$k \in [0..d)$$
$$l \in [0..h-1)$$

Número de variables: $n^2d(h-1)$

#### Restricciones

<!-- * Un participante no puede jugar contra sí mismo.

$$(\forall i)(\neg x_{ii})$$

* Todos los participantes deben jugar dos veces con cada uno de los otros participantes, una como "visitantes" y la otra como "locales".

$$(\forall i, j)(\exists k, l)(i \neq j)(x_{ijkl})$$

* Dos juegos no pueden ocurrir al mismo tiempo.

$$(\forall i, j, u, v, k, l)(i \neq u)(j \neq v)(x_{ijkl} \implies \neg x_{uvkl})$$ 

o

$$(\forall i, j, k, l)(x_{ijkl} \implies \neg ((\exist u, v)(i \neq u)(j \neq v)(x_{uvkl})))$$

<!-- Agregar \land \neg x_{uvk(l+1)} ? -->

* Un participante puede jugar a lo sumo una vez por día.

$$(\forall i, j, k, l, m)(i \neq j)(k \neq m)(x_{ijkl} \implies \neg x_{ijml})$$

* Un participante no puede jugar de "visitante" en dos días consecutivos, ni de "local" dos días seguidos.
* Todos los juegos deben empezar en horas "en punto" (por ejemplo, las 13:00:00 es una hora válida pero las 13:30:00 no).
* Todos los juegos deben ocurrir entre una fecha inicial y una fecha final especificadas. Pueden ocurrir juegos en dichas fechas.
* Todos los juegos deben ocurrir entre un rango de horas especificado, el cuál será fijo para todos los días del torneo.
* A efectos prácticos, todos los juegos tienen una duración de dos horas. -->


### 2.2. Algoritmos de búsqueda


### 2.3. Evaluación de los algoritmos



## 3. Resultados experimentales

#### 3.1 Entorno de pruebas
Para la ejecución de los algoritmos se utilizó un computador con las siguientes características:

- **Procesador**: Intel i5-1035G1 (8) @ 3.600GHz.
- **Memoria RAM**: 7689MiB.
- **Sistema operativo**: Pop!_OS 22.04 LTS x86_64.



### 3.2 Ejecuciones


## 4. Conclusiones
