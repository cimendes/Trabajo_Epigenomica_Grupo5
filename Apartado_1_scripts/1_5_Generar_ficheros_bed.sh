#!/bin/bash

###################################### DESCRIPCIÓN ######################################
#
# Este script permite generar los ficheros ('Monocyte'$i'_11_Master_11_chr'$j'_pre_bedtools.bed) de los segmentos de interés (cuyo estado mayoritario es el estado_9 y que además, la diferencia entre el estado_9 (mayoritario) y el siguiente es mayor a 0.32) correctamente anotados para el siguiente paso. Los ficheros generados contienen 3 líneas:
#	1. Número de cromosoma
#	2. Sitio de inicio del segmento
#	3. Sitio de fin del segmento
# 
###################################### REQUISITOS #######################################  
#
# Este script está pensado para ser ejecutado desde una carpeta que contenga en su interior las carpetas:
#	- Apartado_0_FILTRADO:
#		1. ARCHIVOS_GRAFICA_DISTRIBUCION: con los ficheros '$i'_line_number_state_9_chr'$j'_filtrado.txt'generados en el Script 4, ya que contienen las posiciones de los segmentos de interés.
#	- Apartado_1_INTERSECCION: 
#		1. ARCHIVOS_INTERSECCION: carpeta vacía, que contendrá los archivos generados en este script

###################################### EJECUCIÓN ######################################
# 
# Ubicándose en la carpeta indicada, el script se puede ejecutar con el siguiente comando:
# ./Apartado_1_INTERSECCION/1_5_Generar_ficheros_bed.sh
#

# Bucle para poder procesar todos los ficheros:

for i in 1 2
do
	for j in {1..22} M X
	do
		# Con awk se generan las tres columnas de interés. Las columnas se start y end se generan multiplicando el valor de índice de los ficheros '$i'_line_number_state_9_chr'$j'_filtrado.txt' -2. **Es necesario restarle -2 porque los ficheros que contienen los índices han partido de un archivo con dos líneas de cabecera, que no computan.	
		awk -v j=$j '{ OFS="\t"; start = 0; end = 200}{ print "chr"j, start+=200*($0-2), end+=200*($0-2) }' './Apartado_0_FILTRADO/ARCHIVOS_GRAFICA_DISTRIBUCION/'$i'_line_number_state_9_chr'$j'_filtrado.txt' > ./Apartado_1_INTERSECCION/ARCHIVOS_PRE_BEDTOOLS/'Monocyte'$i'_11_Master_11_chr'$j'_pre_bedtools.bed'

	done
done
