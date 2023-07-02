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

### 2.0. Instrucciones de uso

Para clonar el repositorio:

```bash
git clone --recursive https://github.com/fungikami/sat-babel.git
```

Luego, en la carpeta raíz del repositorio:

```bash
make
```

Para ejecutar el programa, navegar a la carpeta `sat-babel` y ejecutar:

```bash
bin/sat-babel <input-file> <output-file>
```

### 2.1. Representación del problema

$x_{ijkl}$: Variable que representa si el jugador $i$ juega local contra el jugador $j$ el día $k$ a la hora $l$.

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

* Un participante puede jugar a lo sumo una vez por día.

$$(\forall i, j, k, l | i \neq j : x_{ijkl} \implies \neg (\exists n, m | n \notin \{i, j\} :x_{inkm} \lor x_{njkm} \lor x_{jnkm} \lor x_{nikm}))$$

<!--

xijkl => -(xinkm v 

Para un ijkl fijo:

(
    -xijkl v -inkm ^
    -xijkl v -njkm ^
    -xijkl v -jnkm ^
    -xijkl v -nikm ^
) ^
...
-->
---

$$(\forall i, j, k, l | i \neq j : x_{ijkl} \implies $$

$$(\neg (\exists n, m | n \notin \{i, j\} :x_{inkm} \lor x_{njkm} \lor x_{jnkm} \lor x_{nikm})) \land (\neg (\exists m | m \neq l : x_{ijkm}) ) )$$

---

Pa toda participante, participa en una hora o no participa en ninguna.
$$(\forall i, j, k, l, m, o | i \neq j \land i \neq k \land m \neq o : (\neg(x_{ijlm}) \lor \neg(x_{iklo})) \land (\neg(x_{jilm}) \lor \neg(x_{kilo}))) \land $$

Y pa todo participante, participa como local o como visitante, pero no como ambos.
$$(\forall i, j, k, l, m, o | i \neq j \land i \neq k \land j \neq k \land m \neq o : (\neg(x_{ijlm}) \lor \neg(x_{ijlo})) ) $$

* Un participante no puede jugar de "visitante" en dos días consecutivos, ni de "local" dos días seguidos.

$$(\forall i, j, k, l | i \neq j \land k < d - 1 : x_{ijkl} \implies \neg (\exists n, m | n \notin \{i, j\} :x_{in(k+1)m} \lor x_{nj(k+1)m}))$$

---

$$(\forall i, j, k, l, m, o | i \neq j \land i \neq k \land j \neq k : (\neg(x_{ijlm}) \lor \neg(x_{ik(l+1)o})) \land (\neg(x_{jilm}) \lor \neg(x_{ki(l+1)o}))) $$



* Todos los juegos deben empezar en horas "en punto" (por ejemplo, las 13:00:00 es una hora válida pero las 13:30:00 no).

* Todos los juegos deben ocurrir entre una fecha inicial y una fecha final especificadas. Pueden ocurrir juegos en dichas fechas.

* Todos los juegos deben ocurrir entre un rango de horas especificado, el cuál será fijo para todos los días del torneo.

La forma en que se modela el problema garantiza que todos los juegos empiezan en horas "en punto", ocurren entre una fecha inicial y una fecha final especificadas, y en un rango de horas especificado.

* A efectos prácticos, todos los juegos tienen una duración de dos horas.

Una restricción arriba garantiza que no hayan juegos que se traslapen en ninguna de las dos horas.

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
