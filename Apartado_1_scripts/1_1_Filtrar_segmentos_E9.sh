#!/bin/bash

###################################### DESCRIPCIÓN ######################################
#
# Este script procesa los archivos "POSTERIOR" generados por ChromHMM y genera unos nuevos ficheros con el mismo formato pero que contienen solo los estados asignados al estado 9. 
#
###################################### REQUISITOS #######################################
#
# Este script está pensado para ser ejecutado desde una carpeta que contenga en su interior las carpetas:
#	- RESULTS: con los ficheros descargados a través de Moodle para realizar el trabajo. Dentro de RESULTS, se encuentran:
#		1. STATEBYLINE: Carpeta generada tras el análisis de los datos de ChIP-Seq con el programa ChromHMM. Contiene un archivo por cromosoma con tantas líneas como segmentos han sido analizados para ese cromosoma. Aparece indicado el estado de la cromatina que mayor probabilidad tiene para dicho segmento.
#	 	2. POSTERIOR: Carpeta generada tras el análisis de los datos de ChIP-Seq con el programa ChromHMM. Contiene un archivo por cromosoma con tantas líneas como segmentos han sido analizados para ese cromosoma. Aparece indicada la probabilidad asignada a cada uno de los 11 estados analizados para cada segmento. 
#
#	- Apartado_0_FILTRADO:
#		1. ARCHIVOS_GRAFICA_DISTRIBUCION: Carpeta vacía en la que se almacenarán los archivos generados con este script que contendrán solo los segmentos que hayan sido asignados al estado 9. 

###################################### EJECUCIÓN ######################################
# 
# Ubicándose en la carpeta indicada, el script se puede ejecutar con el siguiente comando:
# ./Apartado_0_FILTRADO/1_1_Filtrar_segmentos_E9.sh
#


# Bucle para poder procesar todos los ficheros:

for a in 1 2; do

	for i in {1..22} M X; do

# Generación de un fichero que contiene, para cada monocito y cada cromosoma, los índices de las líneas del archivo "statebyline"
# en las que aparece indicada el estado 9.

		cat ./RESULTS/Modelo_11_estados/STATEBYLINE/Monocyte"$a"_11_Master_11_chr"$i"_statebyline.txt | grep -x "9" -n | cut -d ":" -f 1 > ./Apartado_0_FILTRADO/ARCHIVOS_GRAFICA_DISTRIBUCION/"$a"_line_number_state_9_chr"$i".txt 

# Indexación de los archivos "posterior" con los índices generados en el paso anterior y generación de un nuevo archivo que contiene solo los segmentos a los que se les ha asignado el estado 9.

		sed -nf <(sed 's/.*/&p/' ./Apartado_0_FILTRADO/ARCHIVOS_GRAFICA_DISTRIBUCION/"$a"_line_number_state_9_chr"$i".txt) ./RESULTS/Modelo_11_estados/POSTERIOR/Monocyte"$a"_11_Master_11_chr"$i"_posterior.txt > ./Apartado_0_FILTRADO/ARCHIVOS_GRAFICA_DISTRIBUCION/"$a"_posterior_state_9_chr"$i".txt 

	done 

done
