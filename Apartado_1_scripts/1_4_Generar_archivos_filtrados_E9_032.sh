#!/bin/bash

###################################### DESCRIPCIÓN ######################################
#
# Este script procesa los archivos de índices de aquellos segmentos cuyo estado mayoritario es el estado_9 y en los que además, la diferencia entre el estado_9 (mayoritario) y el siguiente es mayor a 0.32. En consecuencia, se generan archivos "$a"_line_number_state_9_chr"$i"_filtrado.txt, que contienen las posiciones, por filas, de los segmentos que satisfacen estas características.
#
###################################### REQUISITOS #######################################  
#
# Este script está pensado para ser ejecutado desde una carpeta que contenga en su interior las carpetas:
#	- RESULTS: con los ficheros descargados a través de Moodle para realizar el trabajo. 
#
#	- Apartado_0_FILTRADO:
#		1. ARCHIVOS_GRAFICA_DISTRIBUCION, que contiene:
#			1. "$a"_line_number_state_9_chr"$i".txt --> Archivos con las filas pertenecientes a los segmentos asignados al estado E9 que fueron identificados en el Script 1.
#			2. "$a"_posterior_state_9_chr"$i".txt --> Archivos con las filas de las probabilidades de los segmentos con estado E9 identificados en el Script 1.
#			3. "$a"_indice_diff_mas_032_chr"$i".txt (generados en el Script 3)--> Archivos que contienen, por filas, las posiciones de los archivos "$a"_posterior_state_9_chr"$i".txt en las que la diferencia entre el estado de mayor probabilidad (estado 9) y el siguiente es mayor a 0.32.

###################################### EJECUCIÓN ######################################
# 
# Ubicándose en la carpeta indicada, el script se puede ejecutar con el siguiente comando:
# ./Apartado_0_FILTRADO/1_4_Generar_archivos_filtrados_E9_032.sh
#


# Bucle para poder procesar todos los ficheros:

for a in 1 2; do

	for i in {1..22} M X; do

# Indexación de los archivos "posterior" con los índices generados en el paso anterior y generación de un nuevo archivo que contiene solo los segmentos a los que se les ha asignado el estado 9.

		sed -nf <(sed 's/.*/&p/' ./Apartado_0_FILTRADO/ARCHIVOS_GRAFICA_DISTRIBUCION/"$a"_indice_diff_mas_032_chr"$i".txt) ./Apartado_0_FILTRADO/ARCHIVOS_GRAFICA_DISTRIBUCION/"$a"_line_number_state_9_chr"$i".txt > ./Apartado_0_FILTRADO/ARCHIVOS_GRAFICA_DISTRIBUCION/"$a"_line_number_state_9_chr"$i"_filtrado.txt 

	done 

done

