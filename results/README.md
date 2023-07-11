#
### CI5437 - Inteligencia Artificial 1
##### Prof. Carlos Infante

# Proyecto 3

<div style='text-align: right;'>
Por <a href='https://www.github.com/chrischriscris'>Chus</a> | <a href='https://www.github.com/fungikami'>K</a>
</div>

## 1. Introducción

Planificar horarios es una tarea que puede ser relativamente común y a la vez compleja en el mundo real, dependiendo de qué tan restringido tenga que ser el horario o cuántos eventos se tengan que planificar y los demás factores involucrados. Por otro lado, es sabido que la planificación de horarios es un problema NP-completo, por lo que no podemos esperar que la con la ayuda de una computadora se pueda resolver en tiempo polinomial, sin embargo, sí podemos esperar que para casos relativamente pequeños o con muchas posibles soluciones un algoritmo pueda encontrar una de ellas en un tiempo razonable menor al que tomaría a un humano.

Luego, el problema de satisfacibilidad booleana (SAT) es otro problema NP-completo (de hecho el primero en ser probado como tal) que consiste en determinar si existe una asignación de valores booleanos a un conjunto de variables que satisfaga una fórmula booleana. Este problema ha sido a lo largo de los años uno de los más estudiados en el área de la computación, por lo que existen muchas técnicas y algoritmos que permiten explorar el espacio de soluciones de forma inteligente y eficiente para intentar encontrar la solución a una instancia en un tiempo razonable.

Con esto en mente, lo que hace de gran interés al problema SAT es que es posible reducir cualquier problema NP-completo a una instancia de SAT en tiempo polinomial, por lo que un solver eficiente de SAT puede ayudar a resolver problemas para los que no fue diseñado originalmente y para los que no se conocen algoritmos específicos eficientes.

Así, lo que se busca en este proyecto es resolver un problema de planificación de horarios utilizando un solver de SAT, traduciendo primero el problema a una instancia de SAT y luego traduciendo la solución dada por el solver a una solución del problema original; de esta forma, se tiene el propósito de ganar un entendimiento más profundo de estos problemas, su utilidad, sus limitaciones y por qué son tan importantes en el área de la computación.

## 2. Detalles de implementación

### 2.1. Representación del problema

El problema se modela como un problema de satisfacibilidad booleana (SAT) con las siguientes variables y restricciones.

$x_{ijkl}$: Variable que representa si el jugador $i$ juega local contra el jugador $j$ el día $k$ a la hora $l$ (hora de inicio).

$$x_{ijkl} \in \{\text{True}, \text{False}\}$$

$$i,j \in [0..n), \; n \geq 2$$

$$k \in [0..d), \; d\geq 2$$

$$l \in [0..h-1), \; h \geq 2$$

Número de variables: $n^2d(h-1)$

#### Restricciones

* Un participante no puede jugar contra sí mismo. $nd(h-1)$ cláusulas.

$$(\forall i, k, l: \neg x_{iikl})$$

* Todos los participantes deben jugar dos veces con cada uno de los otros participantes, una como "visitantes" y la otra como "locales". $n(n-1)$ cláusulas.

$$(\forall i, j| i \neq j: (\exists k, l|:x_{ijkl}))$$

* Dos juegos no pueden ocurrir al mismo tiempo. $n(n-1)d(n(n-1)-1)(2h-3)$ cláusulas.

$$ (\forall i, j, k, l | i \neq j :x_{ijkl} \implies \neg (\exists u, v|(i \neq u \lor j \neq v) \land u \neq v:x_{uvkl})) $$

$$ \land $$

$$ (\forall i, j, k, l | i \neq j \land l < h-2 :x_{ijkl} \implies \neg (\exists u, v|(i \neq u \lor j \neq v) \land u \neq v:x_{uvk(l+1)})) $$

<!--
Para un ijkl fijo:

n(n-1)-1 cláusulas (uv != ij)
(
    -xijkl v -xuvkl ^
    ...
) ^
n(n-1)-1 cláusulas (uv != ij)
(
    -xijkl v -xuvkl+1 ^
    ...
) ^

Son n(n-1)d(h-1) y n(n-1)d(h-2) combinaciones de ijkl, respectivamente, por lo que el total de cláusulas es:

n(n-1)d(h-1)(n(n-1)-1) + n(n-1)d(h-2)(n(n-1)-1)

=

n(n-1)d((h-1)(n(n-1)-1) + (h-2)(n(n-1)-1))

=

n(n-1)d(n(n-1)-1)(h-1+h-2)

=

n(n-1)d(n(n-1)-1)(2h-3)
-->

* Un participante puede jugar a lo sumo una vez por día. $4n^2(n-1)d(h-1)(h-2)$ cláusulas.

$$(\forall i, j, k, l | i \neq j : x_{ijkl} \implies \neg (\exists p, q | q \neq l :x_{ipkq} \lor x_{pjkq} \lor x_{jpkq} \lor x_{pikq}))$$

<!--

xijkl => -((xinkm v xjkm v xjkm v xikm) v ...)

Para un ijkl fijo:

4n(h-2) cláusulas (l != m)
( 
    -xijkl v -inkm ^
    -xijkl v -njkm ^
    -xijkl v -jnkm ^
    -xijkl v -nikm ^
) ^ ...

Son n(n-1)d(h-1) combinaciones de ijkl, por lo que el total de cláusulas es:

4n^2(n-1)d(h-1)(h-2)
-->

* Un participante no puede jugar de local ni de visitante en dos días consecutivos. $2n^2(n-1)(d-1)(h-1)^2$ cláusulas.

$$(\forall i, j, k, l | i \neq j \land k < d - 1 : x_{ijkl} \implies \neg (\exists p, q | :x_{ip(k+1)q} \lor x_{pj(k+1)q}))$$

<!--

xijkl => -((xipk+1q v xpjk+1q) v ...)

Para un ijkl fijo:

2n(h-1) cláusulas
(
    -xijkl v -ipk+1q ^
    -xijkl v -pjk+1q ^
) ^ ...

Son n(n-1)(d-1)(h-1) combinaciones de ijkl, por lo que el total de cláusulas es:

2n^2(n-1)(d-1)(h-1)^2

-->

* Todos los juegos deben empezar en horas "en punto" (por ejemplo, las 13:00:00 es una hora válida pero las 13:30:00 no).

* Todos los juegos deben ocurrir entre una fecha inicial y una fecha final especificadas.

* Todos los juegos deben ocurrir entre el rango de horas fijo especificado.

La forma en que se modela el problema garantiza que todos los juegos empiezan en horas "en punto", ocurren entre una fecha inicial y una fecha final especificadas, y en un rango de horas especificado.

* A efectos prácticos, todos los juegos tienen una duración de dos horas.

Una restricción arriba garantiza que no hayan juegos que se solapen en ninguna de las dos horas.

Así, el total de cláusulas está en el orden de $O(n^3dh^2 + n^4dh)$.

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
