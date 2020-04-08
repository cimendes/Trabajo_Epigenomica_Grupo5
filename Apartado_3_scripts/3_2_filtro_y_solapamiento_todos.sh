#!/bin/bash

###################################### DESCRIPCIÓN ######################################
#
# Este script procesa los archivos de índices de aquellos segmentos en los que la diferencia entre el estado mayoritario y el siguiente es mayor que 0.32. En consecuencia, se generan archivos "monoc_$a"_crh"$i"_filtrado.txt, que contienen las posiciones, por filas, de los segmentos que satisfacen estas características. Como output final genera un archivo que contiene todos los segmentos de 200 pb de bases de todos los cromosomas y que superan el filtro para ambos monocitos.
#
# A continuación toma ese archivo y calcula el porcentaje de solapamiento con los picos de DNasa del fichero NarrowPeaks dado
#
###################################### REQUISITOS #######################################  
#
# Este script está pensado para ser ejecutado desde la carpeta Practica_Master_ChromHMM.
# En dicha carpeta debe también estar presente 3_compare.py

###################################### EJECUCIÓN ######################################
# 
# Ubicándose en la carpeta "Practica_Master_ChromHMM" (Ejemplo: ~/Documentos/Master_Lucia/Segundo_cuatri/Transcriptomica/Epigenomica/Trabajo/Filtrado/Practica_Master_ChromHMM)
# ./Apartado_3_FILTRADO/4.Generar_archivos_tras_filtro_diferencia_032.sh
#

# Creación de las carpetas necesarias
mkdir ./Apartado_3_FILTRADO
mkdir ./Apartado_3_FILTRADO/todos_los_estados_filtrados


# Bucle para poder procesar todos los ficheros:

for a in 1 2; do

	for i in {1..22} M X; do

		# Generación de índices indicadores de en qué líneas la diferencia entre el estado mayoritario y el siguiente es mayor que 0.32. Se salta la primera línea

		## (primero ordena los valores de cada fila)
		./compare.py <(tail +3 ./RESULTS/Modelo_11_estados/POSTERIOR/Monocyte"$a"_11_Master_11_chr"$i"_posterior.txt) > ./Apartado_3_FILTRADO/todos_los_estados_filtrados/Monocyte"$a"_11_Master_11_chr"$i"_posterior_SORTED.txt

		## (después guarda el número de línea (índice) de las líneas donde la 
		##  diferencia es mayor de 0.32)
		awk 'BEGIN{FS="\t";OFS="\t";diff=0;} {diff=($1-$2); if (diff>0.32) print NR;}' ./Apartado_3_FILTRADO/todos_los_estados_filtrados/Monocyte"$a"_11_Master_11_chr"$i"_posterior_SORTED.txt > ./Apartado_3_FILTRADO/todos_los_estados_filtrados/"$a"_indice_diff_mas_032_chr"$i".txt

		# Se generan las tres columnas de interés (el bed). Las columnas se start y end se generan multiplicando el valor de índice de los ficheros '$i'_line_number_state_9_crh'$j'_filtrado.txt' -2. No es necesario restarle -2 esta vez porque ya retiramos las dos líneas de cabecera en el primer paso (tail +3).
		awk -v i=$i '{ OFS="\t"; start = 0; end = 200}{ print "chr"i, start+=200*($0), end+=200*($0) }' ./Apartado_3_FILTRADO/todos_los_estados_filtrados/"$a"_indice_diff_mas_032_chr"$i".txt > ./Apartado_3_FILTRADO/todos_los_estados_filtrados/Monocyte"$a"_11_Master_11_chr"$i"_MAS_032.bed

	done
done


for i in {1..22} X M
do
	# Intersección entre los archivos de Monocito_1 y Monocito_2 y creación de un único fichero que contenga a todos los cromosomas
	bedtools intersect -a ./Apartado_3_FILTRADO/todos_los_estados_filtrados/Monocyte1_11_Master_11_chr"$i"_MAS_032.bed -b ./Apartado_3_FILTRADO/todos_los_estados_filtrados/Monocyte2_11_Master_11_chr"$i"_MAS_032.bed >> ./Apartado_3_FILTRADO/'INTERSECCION_TODO_MAS_032.bed'

done

###########################################################################################
# Ahora calculamos el porcentaje de solapamiento con DNase-peaks sin distinción de estado #
###########################################################################################

bedtools intersect -a ./INTERSECCION_TODO_MAS_032.bed -b ./segments_DNase.bed -wb  | awk '{FS = "\t"; OFS = "\t"} { print $1, $2, $3 }' > segmentos_comunes_todos_DNase.txt

awk 'BEGIN{FS = "\t"; OFS = "\t"; chr = ""; count=0} {if (chr==$1) {count+=$3-$2} else {print chr,count; chr=$1; count=$3-$2}}  END{print chr,count}' segmentos_comunes_todos_DNase.txt | grep -v chrM > interseccion2

# quitamos ADN mitocondrial
awk 'BEGIN{FS = "\t"; OFS = "\t"; chr = ""; count=0} {if (chr==$1) {count+=$3-$2} else {print chr,count; chr=$1; count=$3-$2}}  END{print chr,count}' ./INTERSECCION_TODO_MAS_032.bed | grep -v chrM > todos

paste interseccion2 todos | awk 'BEGIN{total=0;count=0} NR>1{print $1,$2/$4*100"%"; total+=$2/$4; count++} END{print "total "total/count*100"%"}'

