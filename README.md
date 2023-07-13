# sat-planner

Tu planeador favorito de torneos.

## Comenzando :rocket: (Linux)

Para instalar el programa, es necesario tener instalado `ruby` versión 3.2.2 o superior, no se asegura el correcto funcionamiento en versiones anteriores.

Para clonar el repositorio:

```bash
git clone --recursive https://github.com/fungikami/sat-planner.git
```

Luego, en la carpeta raíz del repositorio:

```bash
source install.sh
```

Si hay algún problema con la instalación, pruebe a clonar nuevamente el repositorio en un directorio distinto. Asegúrese de que la nueva ubicación no tenga espacios en el nombre, debido a que un submódulo de la instalación no funciona correctamente en ubicaciones con espacios en el nombre.

Otro error que puede suceder durante la instalación, es la falta de permisos para instalar las dependencias de `ruby` en la raíz del sistema. Para evitar esto, se recomienda usar un manejador de versiones como `RVM` o `rbenv`, para instalar `ruby` en un directorio local.

## Uso

Una vez instalado el programa, se puede ejecutar desde cualquier directorio mientras se esté en la misma sesión de terminal:

```bash
sat-planner input_file
```

siendo `input_file` el archivo de entrada que describe el problema en formato JSON con la estructura descrita en la sección siguiente. El archivo de salida es un archivo en formato iCalendar que se genera en el directorio actual con el nombre del torneo descrito en el archivo de entrada y la extensión `.ics`.

## Formato de entrada

Se utiliza un archivo JSON para describir el problema. El archivo contiene un solo objeto con los siguientes campos:

```json
{
  "tournament_name": "String. Nombre del torneo",
  "start_date": "String. Fecha de inicio del torneo en formato ISO 8601",
  "end_date": "String. Fecha de finalización del torneo en formato ISO 8601",
  "start_time": "String. Hora a partir de la cual pueden comenzar los juegos cada día, en formato ISO 8601",
  "end_time": "String. Hora a la que deben terminar los juegos cada día, en formato ISO 8601",
  "participants": ["String. Lista de participantes en el torneo"]
}
```

## Informe

El informe se encuentra en la carpeta `results`.

---

Made with :heart: by [Chus](https://www.github.com/chrischriscris) and [K](https://www.github.com/fungikami)
