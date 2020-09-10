# Mineria y Analisis de Datos
# Tarea 1

# Equipo 6: Luz Aurora Hernandez, Alfredo Lefranc y Jose Reyes


# Guion de comandos para realizar el ejercicio 2.1 en bash



cd Documents/Luz/ITAM/MAD/temp
docker run -it -v "/Documents/Luz/ITAM/MAD/temp/:/data" datascienceworkshops/data-science-at-the-command-line /bin/bash
git clone https://github.com/LuzVerde23/intro-to-data-science-2020.git

mkdir tic
cd tic
# Descarga zip

curl -s https://archive.ics.uci.edu/ml/machine-learning-databases/tic-mld/tic.tar.gz > tic.tar.gz
# Lo descomprime
tar -xvzf tic.tar.gz
# x extract, v indicar qué hace, z que está zipeado, f qué archivo quiero que descompacte

# Conteo de lineas y columnas del archivo de entrenamiento y de prueba
cat ticdata2000.txt | wc -l
# 5822 lineas
head -n 1 ticdata2000.txt | od -c
# las columnas estan separadas por \t (tabs). para contar las columnas basta contar las palabras (no hay observaciones separadas por espacios).
head -n 1 ticdata2000.txt | wc -w
# 86 columnas
cat cat ticeval2000.txt | wc -l
# 4000 lineas
head -n 1 ticeval2000.txt | wc -w
# 85 columnas. no trae la variable del resultado CARAVAN (No. 86)


# Descripción del archivo

cat TicDataDescr.txt | more

#Se supone que usemos esta expresión regular
egrep "^[0-9]+\s[A-Z][A-Z]+" TicDataDescr.txt
egrep "^[0-9]+\s[A-Z][A-Z]+" TicDataDescr.txt | wc -l

#Analizamos el diccionario de datos

od -xc TicDataDescr.txt | more

# Es un archivo generado por windows y en codificación Latin1
# Guardamos una copia de respaldo del archivo
cp TicDataDescr.txt TicDataDescr_orig.txt
# Y codificamos
dos2unix TicDataDescr.txt

od -xc ticdata2000.txt | more
cp ticdata2000.txt ticdata2000_orig.txt
dos2unix ticdata2000.txt

# Sigue teniendo un problema por ser binario, lo siguiente para que lo tome como texto
egrep --binary-files=text "^[0-9]+\s[A-Z][A-Z]+" TicDataDescr.txt

# Para quitarle el numero del inicio y la descripción 
egrep --binary-files=text "^[0-9]+\s[A-Z][A-Z]+" TicDataDescr.txt | cut -d' ' -f2 

#Contamos las líneas
egrep --binary-files=text "^[0-9]+\s[A-Z][A-Z]+" TicDataDescr.txt | cut -d' ' -f2 | wc -l

# Guardamos los nombres de las columnas
egrep --binary-files=text "^[0-9]+\s[A-Z][A-Z]+" TicDataDescr.txt | cut -d' ' -f2 > nombre_col.txt

# Lo tabulamos
cat nombre_col.txt | paste -sd '\t' > nombre_col_entrena.txt

# Le ponemos los nombres a las columnas
cat nombre_col_entrena.txt ticdata2000.txt | tr '\t' '|' > ticdata2000_h.txt

# Extraemos las líneas 208 a 248 del archivo descriptivo, conservando las 3 columnas y asignándolas 
# a un archivo catálogo1
sed -n '208,248p;249q'  TicDataDescr.txt | cut -f1-3 --output-delimiter='|' > catalogo1.txt

# Nos quedamos solo con dos columnas y nombramos el primer y segundo campos
cut -d '|' -f 2-3  catalogo1.txt |  header -a 'MOSTYPE|MOSTYPECAT'  > catalogo1b.txt
cat catalogo1b.txt

# Guardamos los nombres de las columnas del archivo de datos
head -n 1 ticdata2000_h.txt > aux1.txt

# Ordenamos el archivo de datos por la primera columna, especificando que lo haga numéricamente
cat ticdata2000_h.txt | header -d | sort -t '|' -k 1n > aux2.txt

#Le pegamos los nombres de la columna 1 y guardamos
cat aux1.txt aux2.txt > aux_data.txt
cat aux_data.txt | more

# Hacemos lo mismo con el catálogo L0
head -n 1 catalogo1b.txt > aux1b.txt
cat catalogo1b.txt | header -d | sort -t '|' -k 1n > aux2b.txt
cat aux1b.txt aux2b.txt > aux_cat.txt
cat aux_cat.txt | more

# Los unimos

join aux_data.txt aux_cat.txt --header -1 1 -2 1 -t '|' -a 1 > aux_ticdata1.txt
cat aux_ticdata1.txt| more

#Guardamos los nombres de las columnas incluyendo la nueva
head -n 1 aux_ticdata1.txt > aux10.txt

# Hacer lo mismo para las otras variables categóricas
# Catálogo L1
# Extraer las líneas 252 al 262

sed -n '252,262p;263q'  TicDataDescr.txt | cut -f1-3 | egrep "[1-6]+\s[1-9][0]+\-[1-9][0]+\s[a-z]" | 
	cut -d' ' -f1-3 --output-delimiter='|' | sed 's/|years/ years/g' > catalogo2.txt

# nombramos el primer y segundo campos
cut -d '|' -f1-2  catalogo2.txt |  header -a 'MGEMLEEF|MGEMLEEFCAT'  > catalogo2b.txt
cat catalogo2b.txt

# Ordenamos el archivo de datos (que ya contiene la columna del catálogo L0) por la cuarta columna, 
#especificando que lo haga numéricamente
cat aux_ticdata1.txt | header -d | sort -t '|' -k 4n > aux2b.txt

#Le pegamos los nombres de las columnas y guardamos
cat aux10.txt aux2b.txt > aux_datab.txt
cat aux_datab.txt | more

# Hacemos lo mismo con el catálogo L1
head -n 1 catalogo2b.txt > aux1bb.txt
cat catalogo2b.txt | header -d | sort -t '|' -k 1n > aux2bb.txt
cat aux1bb.txt aux2bb.txt > aux_cat1.txt
cat aux_cat1.txt | more

# Los unimos

join aux_datab.txt aux_cat1.txt --header -1 4 -2 1 -t '|' -a 1 > aux_ticdata2.txt
cat aux_ticdata2.txt| more

#Guardamos los nombres de las columnas incluyendo la nueva
head -n 1 aux_ticdata2.txt > aux11.txt

# Catálogo L2
# Extraer las líneas 268 al 286

sed -n '268,286p;287q'  TicDataDescr.txt | cut -f1-3 | egrep "[1-9]*[0]{0,4}+\s[A-Za-z]" | 
	cut -d' ' -f1-2 --output-delimiter='|' | sed 's/|h/ H/gi' | sed 's/|G/ G/gi' | sed 's/e|/e /gi' |
	| sed 's/r|/r /gi' | sed 's/|W/ W/gi' | sed 's/g|/g /gi' | sed 's/d|/d /gi' | sed 's/|U/ U/gi' > catalogoL2.txt

# nombramos el primer y segundo campos
cut -d '|' -f1-2  catalogoL2.txt |  header -a 'MOSHOOFD|MOSHOOFDCAT'  > catalogoL2b.txt
cat catalogoL2b.txt

# Ordenamos el archivo de datos (que ya contiene las columnas de los catálogos L0 y L1) por la quinta columna, 
# especificando que lo haga numéricamente
cat aux_ticdata2.txt | header -d | sort -t '|' -k 5n > auxL2.txt

#Le pegamos los nombres de las columnas y guardamos
cat aux11.txt auxL2.txt > aux_dataL2.txt
cat aux_dataL2.txt | more

# No ordenamos el archivo con el catálogo porque ya está ordenado

# Los unimos

join aux_dataL2.txt catalogoL2b.txt --header -1 5 -2 1 -t '|' -a 1 > aux_ticdataL2.txt
cat aux_ticdataL2.txt| more

#Guardamos los nombres de las columnas incluyendo la nueva
head -n 1 aux_ticdataL2.txt > aux12.txt

# Catálogo L3
# Extraer las líneas 292 al 310

sed -n '292,310p;311q'  TicDataDescr.txt | cut -f1-2 | egrep "[0-9]" | 
	cut -d' ' -f1-4 --output-delimiter='|' | sed 's/|-|/ - /g' > catalogoL3.txt

# nombramos el primer y segundo campos
cut -d '|' -f1-2  catalogoL3.txt |  header -a 'MGODRK|MGODRKCAT'  > catalogoL3b.txt
cat catalogoL3b.txt

# Ordenamos el archivo de datos (que ya contiene las columnas de los catálogos L0, L1 y L2) por la sexta columna, 
# especificando que lo haga numéricamente
cat aux_ticdataL2.txt | header -d | sort -t '|' -k 6n > auxL3.txt

#Le pegamos los nombres de las columnas y guardamos
cat aux12.txt auxL3.txt > aux_dataL3.txt
cat aux_dataL3.txt | more

# No ordenamos el archivo con el catálogo porque ya está ordenado

# Los unimos

join aux_dataL3.txt catalogoL3b.txt --header -1 6 -2 1 -t '|' -a 1 > aux_ticdataL3.txt
cat aux_ticdataL3.txt| more

#Guardamos los nombres de las columnas incluyendo la nueva
head -n 1 aux_ticdataL3.txt > aux13.txt

# Catálogo L4
# Extraer las líneas 316 al 334

sed -n '316,334p;335q'  TicDataDescr.txt | cut -f1-2 > auxpasoL4.txt
egrep --binary-files=text "[60]" auxpasoL4.txt > auxpasoL4b.txt
cut -d' ' -f1-5 --output-delimiter='|' auxpasoL4b.txt | sed 's/f|/f /g' | sed 's/|-|/-/g' | sed 's/0|/0-/g' | 
	sed 's/|//g' | sed 's/f/|f/g' | sed 's/-|/|/g'> catalogoL4.txt
	
# nombramos el primer y segundo campos
cut -d '|' -f1-2  catalogoL4.txt |  header -a 'PWAPART|PWAPARTCAT'  > catalogoL4b.txt
cat catalogoL4b.txt

# Ordenamos el archivo de datos (que ya contiene las columnas de los catálogos L0, L1, L2, L3) por la columna 44, 
# especificando que lo haga numéricamente
cat aux_ticdataL3.txt | header -d | sort -t '|' -k 44n > auxL4.txt

#Le pegamos los nombres de las columnas y guardamos
cat aux13.txt auxL4.txt > aux_dataL4.txt
cat aux_dataL4.txt | more

# No ordenamos el archivo con el catálogo porque ya está ordenado

# Los unimos

join aux_dataL4.txt catalogoL4b.txt --header -1 44 -2 1 -t '|' -a 1 > aux_ticdataL4.txt
cat aux_ticdataL4.txt| more

# Ahora para el archivo de evaluación

cp ticeval2000.txt ticeval2000_orig.txt
dos2unix ticeval2000.txt

# Le ponemos los nombres a las columnas sin la variable caravana
cut -f1-85 nombre_col_entrena.txt > nombre_col_entrena_e.txt
cat nombre_col_entrena_e.txt ticeval2000.txt | tr '\t' '|' > ticeval2000_h.txt

# Guardamos los nombres de las columnas del archivo de evaluación
head -n 1 ticeval2000_h.txt > aux1e.txt

# Ordenamos el archivo de evaluación por la primera columna, especificando que lo haga numéricamente
cat ticeval2000_h.txt | header -d | sort -t '|' -k 1n > aux2e.txt

#Le pegamos los nombres de la columna 1 y guardamos
cat aux1e.txt aux2e.txt > aux_eval.txt	 
cat aux_eval.txt | more

# Los unimos

join aux_eval.txt aux_cat.txt --header -1 1 -2 1 -t '|' -a 1 > aux_ticevalL0.txt
cat aux_ticevalL0.txt| more

#Guardamos los nombres de las columnas incluyendo la nueva
head -n 1 aux_ticevalL0.txt > auxe10.txt

# Hacer lo mismo para las otras variables categóricas
# Catálogo L1
# Extraer las líneas 252 al 262


# Ordenamos el archivo de evaluación (que ya contiene la columna del catálogo L0) por la cuarta columna, 
#especificando que lo haga numéricamente
cat aux_ticevalL0.txt | header -d | sort -t '|' -k 4n > aux2eval.txt

#Le pegamos los nombres de las columnas y guardamos
cat auxe10.txt aux2eval.txt > aux_evalb.txt
cat aux_evalb.txt | more


# Los unimos

join aux_evalb.txt aux_cat1.txt --header -1 4 -2 1 -t '|' -a 1 > aux_ticevalL1.txt
cat aux_ticevalL1.txt| more

#Guardamos los nombres de las columnas incluyendo la nueva
head -n 1 aux_ticevalL1.txt > auxe11.txt


# Catálogo L2

# Ordenamos el archivo de evaluación (que ya contiene las columnas de los catálogos L0 y L1) por la quinta columna, 
# especificando que lo haga numéricamente
cat aux_ticevalL1.txt | header -d | sort -t '|' -k 5n > auxeL2.txt

#Le pegamos los nombres de las columnas y guardamos
cat auxe11.txt auxeL2.txt > aux_evalL2.txt
cat aux_evalL2.txt | more

# No ordenamos el archivo con el catálogo porque ya está ordenado

# Los unimos

join aux_evalL2.txt catalogoL2b.txt --header -1 5 -2 1 -t '|' -a 1 > aux_ticevalL2.txt
cat aux_ticevalL2.txt| more

#Guardamos los nombres de las columnas incluyendo la nueva
head -n 1 aux_ticevalL2.txt > auxe12.txt

# Catálogo L3

# Ordenamos el archivo de evaluación (que ya contiene las columnas de los catálogos L0, L1 y L2) por la sexta columna, 
# especificando que lo haga numéricamente
cat aux_ticevalL2.txt | header -d | sort -t '|' -k 6n > auxeL3.txt

#Le pegamos los nombres de las columnas y guardamos
cat auxe12.txt auxeL3.txt > aux_evalL3.txt
cat aux_evalL3.txt | more

# No ordenamos el archivo con el catálogo porque ya está ordenado

# Los unimos

join aux_evalL3.txt catalogoL3b.txt --header -1 6 -2 1 -t '|' -a 1 > aux_ticevalL3.txt
cat aux_ticevalL3.txt| more

#Guardamos los nombres de las columnas incluyendo la nueva
head -n 1 aux_ticevalL3.txt > auxe13.txt

# Catálogo L4

# Ordenamos el archivo de evaluación (que ya contiene las columnas de los catálogos L0, L1, L2, L3) por la columna 44, 
# especificando que lo haga numéricamente
cat aux_ticevalL3.txt | header -d | sort -t '|' -k 44n > auxeL4.txt

#Le pegamos los nombres de las columnas y guardamos
cat auxe13.txt auxeL4.txt > aux_evalL4.txt
cat aux_evalL4.txt | more

# No ordenamos el archivo con el catálogo porque ya está ordenado

# Los unimos

join aux_evalL4.txt catalogoL4b.txt --header -1 44 -2 1 -t '|' -a 1 > aux_ticevalL4.txt
cat aux_ticevalL4.txt| more

# Haz un guión que obtenga cual es esta variable y crea un nuevo archivo con esta columna.

cut -d'|' -f86-86 aux_data.txt > aux_caravan.txt