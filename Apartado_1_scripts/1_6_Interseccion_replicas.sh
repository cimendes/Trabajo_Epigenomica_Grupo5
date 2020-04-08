#!/bin/bash


###################################### DESCRIPCIÓN ######################################
#
# Realización de la intersección entre los archivos de Monocitos para cada cromosoma.
# 
###################################### REQUISITOS #######################################  
#
# Este script está pensado para ser ejecutado desde la carpeta Practica_Master_ChromHMM, que contendrá en su interior las carpetas:
#	- Apartado_1_INTERSECCION:
#		1. ARCHIVOS_PRE_BEDTOOLS: carpeta con los archivos generados con el Script 5, necesarios para realizar la intersección.
#		2. ARCHIVOS_BEDTOOLS: carpeta vacía, en la que se van a guardar los ficheros de la intersección de los dos monocitos de cada uno de los cromosomas.

###################################### EJECUCIÓN ######################################
# 
# Ubicándose en la carpeta indicada, el script se puede ejecutar con el siguiente comando:
# ./Apartado_1_INTERSECCION/1_6_Interseccion_replicas.sh


for j in {1..22} X M
do
	# Intersección entre los archivos de Monocito_1 y Monocito_2 y creación de tantos ficheros como cromosomas existen
	bedtools intersect -a ./Apartado_1_INTERSECCION/ARCHIVOS_PRE_BEDTOOLS/'Monocyte1_11_Master_11_chr'$j'_pre_bedtools.bed' -b ./Apartado_1_INTERSECCION/ARCHIVOS_PRE_BEDTOOLS/'Monocyte2_11_Master_11_chr'$j'_pre_bedtools.bed' > ./Apartado_1_INTERSECCION/ARCHIVOS_BEDTOOLS/'Interseccion_chr'$j'.bed'
	
	# Intersección entre los archivos de Monocito_1 y Monocito_2 y creación de un único fichero que contenga a todos los cromosomas
	bedtools intersect -a ./Apartado_1_INTERSECCION/ARCHIVOS_PRE_BEDTOOLS/'Monocyte1_11_Master_11_chr'$j'_pre_bedtools.bed' -b ./Apartado_1_INTERSECCION/ARCHIVOS_PRE_BEDTOOLS/'Monocyte2_11_Master_11_chr'$j'_pre_bedtools.bed' >> ./Apartado_1_INTERSECCION/'Interseccion_TODOS_CROMOSOMAS.bed'

done
