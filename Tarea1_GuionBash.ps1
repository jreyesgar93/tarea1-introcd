# Mineria y Analisis de Datos
# Tarea 1

# Equipo 6: Luz Aurora Hernandez, Alfredo Lefranc y Jose Reyes


# Guion de comandos para realizar el ejercicio 2.1 en bash

# Primero iniciamos sesion en docker
docker login -user <nombre de usuario>

# de no contar con el contenedor data science at the command line, lo descargamos
docker pull datascienceworkshops/data-science-at-the-command-line

# ejecutamos el contenedor
docker run -it -v "C:/Users/fredy/Docker:/data" datascienceworkshops/data-science-at-the-command-line /bin/bash

# descargamos el archivo tic.tar.gz
curl -s https://archive.ics.uci.edu/ml/machine-learning-databases/tic-mld/tic.tar.gz > tic.tar.gz

# lo descomprimimos
tar -xvzf tic.tar.gz

cd \tic
ls

# Conteo de lineas y columnas del archivo de entrenamiento y de prueba
cat ticdata2000.txt | wc -l
# 5822 lineas
head -n 1 ticdata2000.txt | od -c
# las columnas estan separadas por \t (tabs). para contar las columnas basta contar las palabras (no hay observaciones separadas por espacios).
head -n 1 ticdata2000.txt | wc -w
# 86 columnas
cat cat ticeval2000.txt | wc -l
# 4000 lineas
head -n 1 ticdata2000.txt | wc -w
# 85 columnas. no trae la variable del resultado CARAVAN (No. 86)


# agregar encabezados a las columnas a los archivos de datos
egrep --binary-files=text "^[0-9]+\s[A-Z][A-Z]+" TicDataDescr.txt | cut -d" " -f2 | paste -sd "\t" -> varnames.txt
cat varnames.txt ticdata2000.txt | tr '\t' '|' > ticdata2000_h.txt


# Agregar columna con valores del catalogo para las variables categoricas
# Lista de variables categoricas:
1 MOSTYPE. 208-248
4 MGEMLEEF. 252-262
5 MOSHOOFD. 268-286
6 MGODRK. lineas 292-310
44 PWAPART. lineas 316-334
# hay que cambiar caracteres de ultimas etiquetas
sed -n '208,248p;249q' TicDataDescr.txt | cut -f2-3 --output-delimiter='|' | header -a 'MOSTYPE|MOSTYPECAT' > catalogoL0.txt





# Parte de R
# Primero copiar el srcipt de R a la carpeta tic

# Verificamos que el script tenga permisos de ejecucion
ls -al

# si no tiene los permisos, los agregamos
chmod +x <NombreDelRScript>

# nos aseguramos que la codificacion sea correcta
od -xc <NombreDelRScript>

# si no es correcta, la cambiamos
dos2unix <NombreDelRScript>

# Ejecutamos el archivo. para que corra, los archivos input deben estar en la misma carpeta
./<NombreDelRScript>

# en caso de que la ejecucion marque errores, es util editar el srcipt directo en bash
vi <NombreDelRScript>



