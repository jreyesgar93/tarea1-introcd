Tarea 1 de Intro a Ciencia de Datos


Los guiones generados y el archivo con las respuestas se deben de subir al repositorio GitHub de la clase antes de las 11:59 del lunes 14 de septiembre dentro del subdirectorio grupos/<numero de su equipo>/01

1) Web Scrapping

Extraer información del clima de la ciudad de México la página https://www.timeanddate.com/weather/mexico/mexico-city/hourly

La información que se requiere es:

Time
Temp
Weather
Chance

Hint: Sí usas el método mostrado en clase no selecciones el encabezado y utiliza la funcion html_nodes (plural) para extraer los elementos de la página

2) Obtención y preprocesamiento de datos

2.1) Usando el docker del libro Data Science on the Command Line, crear guiones en bash y R que:
baje el archivo tic.tar.gz con los datos del repositorio de aprendizaje de máquina de UIC (https://archive.ics.uci.edu/ml/machine-learning-databases/tic-mld/) y lo descompacte.
dé el conteo de lineas y de columnas tanto para el archivo de entrenamiento como el de prueba.
le agregue los encabezados a las columnas a los archivos de datos.
para las variables categóricas agregue una columna con los del catálogo en todos los archivos de datos.
por ejemplo para el campo #1 MOSTYPE es el subtipo de cliente y el catálogo se encuentra hacia el final del archivo TicDataDescr.txt 
Si el archivo de datos tiene un valor 1 en ese campo, debe sustituirse por High Income, expensive child
obtenga un resumen de cada una de las columnas 
variables continuas  obtener mínimo, máximo, promedio y desviación estándar
variables categóricas frecuencia de cada una de ellas
En el archivo TicDataDescr.txt hay un párrafo en el que indican cual es la variable respuesta. 
haz un guión que obtenga cual es esta variable y crea un nuevo archivo con esta columna.

2.2) ¿Se puede determinar el tipo de codificación de los archivos? Sí/no ¿por qué?

2.3) ¿Se podrían ejecutar un guión que realice todos los pasos anteriores utilizando docker run? si sí, ¿cómo se hace?
