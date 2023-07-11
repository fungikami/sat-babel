# sat-planner

Tu planeador favorito de torneos de ajedrez.

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

Otro error común es que `ka no quiere explicar cómo se resuelve el problema`.

## Uso

Una vez instalado el programa, se puede ejecutar desde cualquier directorio mientras se esté en la misma sesión de terminal:

```bash
sat-planner input_file
```

siendo `input_file` el archivo de entrada que describe el problema en formato JSON con la estructura descrita en la sección siguiente. El archivo de salida es un archivo en formato iCalendar que se genera en el directorio actual con el nombre del torneo descrito en el archivo de entrada y la extensión `.ics`.

## Informe

El informe se encuentra en la carpeta `results`.

---

Made with :heart: by [Chus](https://www.github.com/chrischriscris) and [K](https://www.github.com/fungikami)
