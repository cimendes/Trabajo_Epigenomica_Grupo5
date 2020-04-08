#!/bin/bash

###################################### DESCRIPCIÓN ######################################
#
# Obtención de la cantidad de segmentos que presentan cada una de las anotaciones obtenidas a través de la herramienta annotatR
# 
###################################### REQUISITOS #######################################  
#
# Este script está pensado para ser ejecutado desde la carpeta Practica_Master_ChromHMM, que contendrá en su interior las carpetas:
#	- Apartado_2_ANOTACION, contiene los Scripts 7 y 8 y:
#		1. ARCHIVOS_ANOTACIONES: esta carpeta contiene el archivo "Anotaciones_interseccion_todos_chr_E9.csv", con todos los segmentos filtrados en los pasos anteriores a los cuales se les han añadido anotaciones con la librería "annotatR" (realizado en el Script 7).
#		2. ARCHIVOS_PARA_GRAFICA: carpeta vacía que va a contener un fichero con dos columnas 
#			--> Primera columna, nombre de la anotación
#			--> Segunda columna, cantidad de segmentos con dicha anotación 
#

###################################### EJECUCIÓN ######################################
# 
# Ubicándose en la carpeta "Practica_Master_ChromHMM" (Ejemplo: ~/Documentos/Master_Lucia/Segundo_cuatri/Transcriptomica/Epigenomica/Trabajo/Filtrado/Practica_Master_ChromHMM)
# ./Apartado_2_ANOTACIONES/9.1.Obtencion_frecuencias_segmentos.sh


# 1. Obtención de todas las etiquetas con las que se han anotado los segmentos
tail -n +2 ./Apartado_2_ANOTACION/ARCHIVOS_ANOTACIONES/Anotaciones_interseccion_todos_chr_E9.csv | cut -d "," -f 15 | sort | uniq > ./Apartado_2_ANOTACION/ARCHIVOS_PARA_GRAFICA/Etiquetas_anotaciones.txt

# 2. Establecimiento de un bucle "while" para llevar a cabo el contaje de segmentos que presentan cada una de las anotaciones de interés
input="/home/lucia/Documentos/Master_Lucia/Segundo_cuatri/Transcriptomica/Epigenomica/Trabajo/Filtrado/Practica_Master_ChromHMM/Apartado_2_ANOTACION/ARCHIVOS_PARA_GRAFICA/Etiquetas_anotaciones.txt"

while IFS= read -r line
do
  tail -n +2 ./Apartado_2_ANOTACION/ARCHIVOS_ANOTACIONES/Anotaciones_interseccion_todos_chr_E9.csv | sort -t "," -k 1,1 -k 2,2 -k 3,3 | grep "$line" | cut -d "," -f 1,2,3 | uniq | wc -l >> ./Apartado_2_ANOTACION/ARCHIVOS_PARA_GRAFICA/Valores_anotaciones.txt

done < "$input"

# 3. Unión de los resultados de los apartados 1 y 2
paste -d "," ./Apartado_2_ANOTACION/ARCHIVOS_PARA_GRAFICA/Etiquetas_anotaciones.txt ./Apartado_2_ANOTACION/ARCHIVOS_PARA_GRAFICA/Valores_anotaciones.txt > ./Apartado_2_ANOTACION/ARCHIVOS_PARA_GRAFICA/Etiquetas_Valores_anotaciones.csv

# 4. Eliminación de ficheros temporales
./Apartado_2_ANOTACION/ARCHIVOS_PARA_GRAFICA/Valores_anotaciones.txt
./Apartado_2_ANOTACION/ARCHIVOS_PARA_GRAFICA/Etiquetas_anotaciones.txt
