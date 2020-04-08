#!/bin/bash

###################################### DESCRIPCIÓN ######################################
#
# Calculo del porcentaje de segmentos que solapan con protein-coding genes
# 
###################################### REQUISITOS #######################################  
#
# Este script está pensado para ser ejecutado desde la carpeta Practica_Master_ChromHMM, que contendrá en su interior las carpetas:
#	- Apartado_2_ANOTACION, contiene los Scripts 7 y 8 y:
#		1. ARCHIVOS_ANOTACIONES: esta carpeta contiene el archivo "Anotaciones_interseccion_todos_chr_E9.csv", con todos los segmentos filtrados en los pasos anteriores a los cuales se les han añadido anotaciones con la librería "annotatR" (realizado en el Script 7). En esta carpeta se irán generando el resto de archivos que están previsto a lo largo de este Script.
#

###################################### EJECUCIÓN ######################################
# 
# Ubicándose en la carpeta "Practica_Master_ChromHMM" (Ejemplo: ~/Documentos/Master_Lucia/Segundo_cuatri/Transcriptomica/Epigenomica/Trabajo/Filtrado/Practica_Master_ChromHMM)
# ./Apartado_2_ANOTACIONES/8.Calculo_porcentajes.sh


# 1. Comando necesario para realizar un contaje de los segmentos que contienen la anotación hg19_genes_cds, es decir, de los segmentos solapantes con regiones cds
tail -n +2 ./Apartado_2_ANOTACION/ARCHIVOS_ANOTACIONES/Anotaciones_interseccion_todos_chr_E9.csv | sort -t "," -k 1,1 -k 2,2 -k 3,3 | grep "hg19_genes_cds" | cut -d "," -f 1,2,3 | uniq > ./Apartado_2_ANOTACION/ARCHIVOS_ANOTACIONES/Anotaciones_interseccion_todos_chr_E9_CDS_uniq.csv


# 2. Loop de cálculo del número de segmentos solapantes con regiones cds por cromosoma
for i in {1..22} X M
do
	awk -v i=$i 'BEGIN{FS = ","; OFS = ","; count=0} {if ("chr"i==$1) {count+=1} }  END{print "chr"i,count}' ./Apartado_2_ANOTACION/ARCHIVOS_ANOTACIONES/Anotaciones_interseccion_todos_chr_E9_CDS_uniq.csv >> ./Apartado_2_ANOTACION/ARCHIVOS_ANOTACIONES/Cuentas_anotaciones_CDS_por_cromosoma.csv
done

# 3. Loop de cálculo del total de segmentos con estado E9 y con el filtro de 0.32 (se recuerda que este filtro solo mantenía segmentos en los que la diferencia de probabilidades entre el estado E9 y el siguiente mayoritario era superior al 0.32) 
for i in {1..22} X M
do
	awk -v i=$i 'BEGIN{FS = "\t"; OFS = ","; count=0} {if ("chr"i==$1) {count+=1} }  END{print "chr"i,count}' ./Apartado_1_INTERSECCION/Interseccion_TODOS_CROMOSOMAS.bed  >> ./Apartado_2_ANOTACION/ARCHIVOS_ANOTACIONES/Cuentas_anotaciones_SEGMENTOS_por_cromosoma.csv
done

# 4. Creación del fichero "Segmentos_cds_VS_totales.csv", en los que se pone por filas el nombre del cromosoma, el número de segmentos solapantes con regiones cds y el número de segmentos totales (con estado E9 y filtrados)
cut -d "," -f 2 ./Apartado_2_ANOTACION/ARCHIVOS_ANOTACIONES/Cuentas_anotaciones_SEGMENTOS_por_cromosoma.csv > ./Apartado_2_ANOTACION/ARCHIVOS_ANOTACIONES/Valores_SEGMENTOS_por_cromosoma.csv
paste -d "," ./Apartado_2_ANOTACION/ARCHIVOS_ANOTACIONES/Cuentas_anotaciones_CDS_por_cromosoma.csv ./Apartado_2_ANOTACION/ARCHIVOS_ANOTACIONES/Valores_SEGMENTOS_por_cromosoma.csv > ./Apartado_2_ANOTACION/ARCHIVOS_ANOTACIONES/Segmentos_cds_VS_totales.csv

# 5. Eliminación de los archivos temporales creados
rm ./Apartado_2_ANOTACION/ARCHIVOS_ANOTACIONES/Valores_SEGMENTOS_por_cromosoma.csv
rm ./Apartado_2_ANOTACION/ARCHIVOS_ANOTACIONES/Cuentas_anotaciones_SEGMENTOS_por_cromosoma.csv
rm ./Apartado_2_ANOTACION/ARCHIVOS_ANOTACIONES/Cuentas_anotaciones_CDS_por_cromosoma.csv


# 6. Cálculo del porcentaje de segmentos que solapan con proteina-coding genes por cromosoma
awk 'BEGIN{FS = ","; OFS = ","} { print $1,$2/$3 }' ./Apartado_2_ANOTACION/ARCHIVOS_ANOTACIONES/Segmentos_cds_VS_totales.csv > ./Apartado_2_ANOTACION/ARCHIVOS_PARA_GRAFICA/Porcentajes_CDS_cromosoma.csv


# Output # 
#chr1,0.0434422
#chr2,0.0390595
#chr3,0.0253924
#chr4,0.0188806
#chr5,0.0304114
#chr6,0.0374332
#chr7,0.0342227
#chr8,0.0152116
#chr9,0.0351213
#chr10,0.0326355
#chr11,0.0418581
#chr12,0.0403129
#chr13,0.020438
#chr14,0.035004
#chr15,0.0329489
#chr16,0.0419325
#chr17,0.0695971
#chr18,0.0117474
#chr19,0.0780303
#chr20,0.0387158
#chr21,0.0131234
#chr22,0.0308725
#chrX,0.0197368
#chrM,-nan


