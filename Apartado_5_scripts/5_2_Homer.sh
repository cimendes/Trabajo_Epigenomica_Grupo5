#!/bin/bash


###################################### DESCRIPCIÓN ######################################
#
# Búsqueda de motivos presentes en los segmentos incluidos en un archivo .bed mediante el programa findMotifsGenome.pl de Homer
# 
###################################### REQUISITOS #######################################  
# 
# Se debe tener instalado el programa Homer y además, que esté incluido en el path.
# 
# Este script está pensado para ser ejecutado desde una carpeta que contenga en su interior las carpetas:
#	- Apartado_1_INTERSECCION, en cuyo interior debe estar:
#		Interseccion_TODOS_CROMOSOMAS.bed: archivo que contiene los datos de todos los picos encontrados a lo largo de todos los cromosomas.
#
#	- Apartado_5_MOTIF_DISCOVERY, en cuyo interior debe estar este script y:
#		RESULTADOS_HOMER: carpeta vacía en cuyo interior se almacenarán los resultados de HOMER


###################################### EJECUCIÓN ######################################
# 
# Ubicándose en la carpeta indicada, el script se puede ejecutar con el siguiente comando:
# ./Apartado_5_MOTIF_DISCOVERY/5_2_Homer.sh

findMotifsGenome.pl ./Apartado_1_INTERSECCION/'Interseccion_TODOS_CROMOSOMAS.bed' hg19 ./Apartado_5_MOTIF_DISCOVERY/RESULTADOS_HOMER/ -size 200 -mask

