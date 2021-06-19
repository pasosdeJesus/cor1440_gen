Fórmulas para medir indicadores en cor1440b4

[vtamara@pasosdeJesus.org](mailto:vtamara@pasosdeJesus.org) 2021-06-10

# 1. Introducción

Por el uso popular de hojas de cálculo entre coordinadores(as) de proyectos,
en Cor1440 hemos diseñado una forma de especificar las funciones de medición 
de indicadores basada en el concepto de hoja de cálculo y en la sintaxis de 
formulas de Excel.

# 2. Analogías de conceptos y ejemplos

Cada base de datos puede verse como un hipercubo o cubo OLAP (ver
[Cubo OLAP en Wikipedia](https://es.wikipedia.org/wiki/Cubo_OLAP)), que es 
como una hoja de cálculo con celdas que a su vez pueden ser hojas de cálculo. 
Cada hoja de cálculo del hipercubo corresponde a una serie de registros
de una tabla en la base de datos.

Imagine que para la medición de un indicador de resultado, el hipercubo 
comienza en una hoja de cálculo con las actividades que contribuyen en 
la medición (las llamaremos `Actividades_contribuyentes`). E imagine que 
la primera fila tiene los nombres de los campos, y que después de esta cada 
fila tiene un registro de una actividad.

Podría comenzar con algo como:

| id | fecha | ubicación | nombre | Asistentes | pob |
| --- | --- | --- | --- | --- | --- |
| 2 | 2021-06-20 | {id: 5,nombre: Ovejas/Sucre} | Taller de capacitación | \[{id: 1, persona: Rosa Pérez…}, {id: 3, persona: Ignacio Gómez...},{id: 8, persona: Juan Tamariz…}\] | 3 |
| 4 | 2021-07-10 | {id: 10,nombre: Acacias/Meta} | Taller de capacitación | \[{id: 15, persona: Camilo Suárez…}{id: 18, persona: Rosa Pérez…}\] | 2 |

En general en cada hoja/tabla, en cada celda de los registros puede tener:

* Un número entero o flotante (separando parte entera de parte decimal con 
  coma, según el _locale_ de Colombia).
* Una fecha.
* Una cadena (o texto).
* Un registro de otra tabla. Por ejemplo ubicación (que consta de 
  departamento y municipio).
* Un vector (es decir una secuencia de números, o una secuencia de fechas o 
  una secuencia de cadenas o una secuencia de registros que corresponde a 
  otra hoja de cálculo). Por ejemplo el campo Asistentes de una actividad es 
  un vector de registros o una hoja de cálculo.

Suponemos que los indicadores se miden de manera numérica, por lo que la 
función que da el resultado de un indicador da un número --piense en la 
función SUMA de Excel. Esa y otras funciones en general agruparán datos y en 
general no harán referencia a una única fila o registro, sino que operarán 
sobre varias filas.

Por ejemplo dada la hoja de cálculo de ejemplo, si se evalúa la función 
`cuenta(Actividades_contribuyentes)` daría 2 que es la cantidad de registros 
en la misma.

Al evaluar la función `mapeaproy(Actividades_contribuyentes, poblacion)` se 
obtendría un vector de enteros, con los 2 enteros de la columna “población”:

|   |
|---|
| 3 |
| 2 |

Por eso al evaluar `suma(mapeaproy(Actividades_contribuyentes, poblacion))` se 
obtendría 5 (lo que antes contaba el tipo de indicador `Cuenta Población`).

Al evaluar la función `mapeaproy(Actividades_contribuyentes, Asistentes)` se 
obtiene un vector con 2 hojas de cálculo (cada una sería un listado de 
asistencia):

| Asistentes |
| --- |
| [{id: 1, persona: {id:20, nombres: Rosa,apellidos: Pérez …}, perfil: Directivo},{id: 3, persona: {id:30, nombres: Ignacio, apellidos: Gómez …}, perfil: Miembro}, {id: 8, persona: {id:50, nombre: Juan, apellidos: Tamariz…}, perfil: Miembro}] |
| [{id: 15, persona: {id:80, nombres: Camilo, apellidos: Suárez …}, perfil: Directivo}, {id: 18, persona: {id:20, nombres: Rosa, apellidos: Pérez …}, perfil: Miembro}] |

Si se usa la función `aplana` en el resultado anterior i.e 
`aplana(mapeaproy(Actividades_contribuyentes, Asistentes))` daría un vector 
con 5 registros de asistencias:

| id | persona | perfil | ... |
| --- | --- | --- | --- |
| 1 | {id:20, nombres: Rosa,apellidos: Pérez …} | Directivo |  |
| 3 | {id:30, nombres: Ignacio, apellidos: Gómez …} | Miembro |  |
| 8 | {id:50, nombre: Juan, apellidos: Tamariz…} | Miembro |  |
| 15 | {id:80, nombres: Camilo, apellidos: Suárez …} | Directivo |  |
| 18 | {id:20, nombres: Rosa, apellidos: Pérez …} | Miembro |  |

Note que por ser asistencias son diferentes los 2 registros de Rosa Pérez.

Si del resultado anterior se extrae la columna `persona`,

`mapeaproy(aplana(mapeaproy(Actividades_contribuyentes, Asistentes)),persona)`

daría un vector con 5 personas (cuenta que antes se obtenía con el tipo de
indicador Cuenta Asistentes):

| id | nombres | apellidos | ... |
| --- | --- | --- | --- |
| 20 | Rosa | Pérez |  |
| 30 | Ignacio | Gómez |  |
| 50 | Juan | Tamariz |  |
| 80 | Camilo | Suárez |  |
| 20 | Rosa | Pérez |  |

Y si a ese resultado se aplica la función únicas,

`únicas(mapeaproy(aplana(mapeaproy(Actividades_contribuyentes, Asistentes)),persona))`

quedaría un vector con 4 personas (cuenta que antes se obtenía con el tipo de
indicador Cuenta Asistentes Únicos):

| id | nombres | apellidos | ... |
| --- | --- | --- | --- |
| 20 | Rosa | Pérez |  |
| 30 | Ignacio | Gómez |  |
| 50 | Juan | Tamariz |  |
| 80 | Camilo | Suárez |  |

Esperamos que los ejemplos presentados faciliten entender la sintaxis para 
estas fórmula y la siguiente tabla de equivalencia de tipos 
de indicadores comunes:

| Tipo de indicador común | Función de medición |
| --- | --- |
| Cuenta de actividades | `cuenta(Actividades_contribuyentes)` |
| Cuenta población | `suma( mapeaproy(Actividades_contribuyentes, poblacion))` |
| Cuenta asistentes | `cuenta( aplana( mapeaproy( Actividades_contribuyentes, Asistentes ) ))` |
| Cuenta asistentes únicos | `cuenta( únicas( mapeaproy( aplana( mapeaproy( Actividades_contribuyentes, Asistentes ) ), persona ) ))` |
| Cuenta organizaciones | `cuenta( aplana( mapeaproy( Actividades_contribuyentes, Organizaciones ) ))` |
| Cuenta organizaciones únicas | `cuenta( únicas( aplana( mapeaproy( Actividades_contribuyentes, Organizaciones ) ) ))` |


# 3. Sintaxis y evaluación de las funciones

Las funciones de medición pueden escribirse con espacios arbitrarios y pueden 
constar de:

* Números (por ejemplo 2 23,2 -4,2)
* Identificadores de datos intermedios o del contexto de evaluación (por 
  ejemplo `Actividades_contribuyentes`, `num_mujeres`)
* Operaciones aritméticas suma (`+`), resta (`-`), multiplicación (`*`) y 
  división (`/`) en la típica notación infija y con la precedencia típica 
  (`*` y `/` tienen más precedencia que `+`  y `-`). Por ejemplo `2+3` o 
  `100*num_mujeres/num_personas`
* Valor del campo de un registro (o proyección) mediante un punto (`.`) 
  infijo, por ejemplo si `a` es un registro de una actividad con `a.población`
* Valor retornado por una función al evaluarla con unos parámetros. Por 
  ejemplo si `v` es un vector de números `suma(v)`.

Las funciones que pueden emplearse (bien en mayúsculas o minúsculas como en 
Excel) y sus signaturas son:

* `cuenta`: vector de tipo τ → numero
* `únicos`: vector de tipo τ → vector de tipo τ
* `suma`: vector de número → número
* `mapeoproy`: (vector de registro ρ) × (nombre campo) → vector β
* `aplana`: vector de vectores de tipo τ → vector de tipo τ

En la evaluación de una función de medición se comenzará con un contexto, 
el cual consta de los siguientes identificadores:

* `fechaini`: Fecha inicial para la medición
* `fechafin`: Fecha final para la medición
* `Actividades_contribuyentes` sólo presente en medición de indicadores de 
  resultado, será un vector con los registros de las actividades que le 
  aportan al indicador i.e las que tengan uno de los tipos de actividad de 
  marco lógico requeridos por la medición.
* `Efectos_contribuyentes`: sólo presente en medición de indicadores de 
  efecto, será un vector con los efectos que le aportan al indicador que se 
  mide.
* Identificadores de datos intermedios que se especifiquen.

