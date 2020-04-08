#!/bin/bash


###################################### DESCRIPCIÓN ######################################
#
# Conversión de los archivos .bed a .fasta para posteriormente llevar a cabo el motif discovery con la suite MEME (MEME-ChIP).
# 
###################################### REQUISITOS #######################################  
#
# Este script está pensado para ser ejecutado desde una carpeta que contenga en su interior las carpetas:
#	- Apartado_1_INTERSECCION, en cuyo interior debe estar:
#		Interseccion_TODOS_CROMOSOMAS.bed: archivo que contiene los datos de todos los picos encontrados a lo largo de todos los cromosomas.
#
#	- Apartado_5_MOTIF_DISCOVERY, en cuyo interior debe estar este script y:
#		hg19.fa: archivo en formato fasta de la versión 19 del genoma humano.
#		hg9.fai: archivo con el indexado de la versión 19 del genoma humano.
#		Nota: es en el interior de esta carpeta donde se guardará el archivo "Interseccion_TODOS_CROMOSOMAS.fasta".


###################################### EJECUCIÓN ######################################
# 
# Ubicándose en la carpeta indicada, el script se puede ejecutar con el siguiente comando:
# ./Apartado_5_MOTIF_DISCOVERY/5_1_from_bed_to_fasta.sh


bedtools getfasta \
-fi ./Apartado_5_MOTIF_DISCOVERY/'hg19.fa' \
-bed ./Apartado_1_INTERSECCION/'Interseccion_TODOS_CROMOSOMAS.bed' \
-fo ./Apartado_5_MOTIF_DISCOVERY/'Interseccion_TODOS_CROMOSOMAS.fasta'

