* Un participante no puede jugar contra sí mismo.

$$(\forall i)(\neg x_{ii})$$

* Todos los participantes deben jugar dos veces con cada uno de los otros participantes, una como "visitantes" y la otra como "locales".

$$(\forall i, j)(\exists k, l)(i \neq j)(x_{ijkl})$$

* Dos juegos no pueden ocurrir al mismo tiempo.

$$(\forall i, j, u, v, k, l)(i \neq u)(j \neq v)(x_{ijkl} \implies \neg x_{uvkl})$$ 

o

$$(\forall i, j, k, l)(x_{ijkl} \implies \neg ((\exist u, v)(i \neq u)(j \neq v)(x_{uvkl})))$$

 Agregar \land \neg x_{uvk(l+1)} ?

* Un participante puede jugar a lo sumo una vez por día.

$$(\forall i, j, k, l, m)(i \neq j)(k \neq m)(x_{ijkl} \implies \neg x_{ijml})$$

* Un participante no puede jugar de "visitante" en dos días consecutivos, ni de "local" dos días seguidos.
* Todos los juegos deben empezar en horas "en punto" (por ejemplo, las 13:00:00 es una hora válida pero las 13:30:00 no).
* Todos los juegos deben ocurrir entre una fecha inicial y una fecha final especificadas. Pueden ocurrir juegos en dichas fechas.
* Todos los juegos deben ocurrir entre un rango de horas especificado, el cuál será fijo para todos los días del torneo.
* A efectos prácticos, todos los juegos tienen una duración de dos horas.