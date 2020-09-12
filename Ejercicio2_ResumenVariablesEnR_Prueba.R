#!/usr/bin/env Rscript

# Script de prueba para correr en Bash

# librerias utiles
library(dplyr)

# movernos al directorio de trabajo
# setwd("C:/Users/fredy/Docker/tic")

# en bash el directorio seria
# setwd("/Data/tic")

# Lectura de la base ticdata
ticdata2000 <- read.delim("ticdata2000.txt", 
                          header=FALSE, stringsAsFactors=TRUE)

# View(ticdata2000)

# algunos comandos de exploracion
class(ticdata2000)
str(ticdata2000)
glimpse(ticdata2000)


