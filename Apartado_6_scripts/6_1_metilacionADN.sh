
#!/bin/bash

###################################### DESCRIPCIÓN ######################################
#
# Este script permite calcular el porcentaje (en segmentos y pb) de solapamiento de segmentos con estado 9 (en los dos monocitos) y filtrados (diferencia de probabilidad posterior con el segundo estado mas probable >0.32) con regiones hiper- e hipo-metiladas de monocitos del donante C001UY.
# Ademas, permite realizar la interseccion de segmentos con estado 9 y filtrados, previamente solapados con picos de DNasa I (script 3_1_solapamiento_E9.sh), con regiones hiper- e hipo-metiladas de monocitos del donante C001UY.
#
#########################################################################################

# Convertir archivos bigBed (indexed binary format) en archivos con formato ASCII BED, utilizando bigBedToBed (http://hgdownload.soe.ucsc.edu/admin/exe/)
./bigBedToBed PATH_to/C001UYA3bs.hyper_meth.bs_call.GRCh38.20150707.bb PATH_to_output_folder/C001UYA3bs.hyper_meth.bed
./bigBedToBed PATH_to/C001UYA3bs.hypo_meth.bs_call.GRCh38.20150707.bb PATH_to_output_folder/C001UYA3bs.hypo_meth.bed

# Seleccionamos las tres primeras columnas de estos dos archivos (1.  Chromosome, 2.  Region start position, 3. Region end position):
cat C001UYA3bs.hyper_meth.bed | cut -f1,2,3 > C001UYA3bs.hyper_meth_final.bed
cat C001UYA3bs.hypo_meth.bed | cut -f1,2,3 > C001UYA3bs.hypo_meth_final.bed

# Utilizamos bedtools intersect para obtener segmentos con estado 9 (en los dos monocitos) y filtrados (diferencia de probabilidad posterior con el segundo estado mas probable >0.32) que solapan con regiones hiper- e hipo-metiladas de monocitos del donante C001UY:
bedtools intersect -a seg_filtrado_E9_INTERSECTION_allChr.bed -b C001UYA3bs.hyper_meth_final.bed -wb | awk '{FS = "\t"; OFS = "\t"} { print $1, $2, $3 }' > seg_comunes_filtrado-E9_hyper_meth.txt
bedtools intersect -a seg_filtrado_E9_INTERSECTION_allChr.bed -b C001UYA3bs.hypo_meth_final.bed -wb | awk '{FS = "\t"; OFS = "\t"} { print $1, $2, $3 }' > seg_comunes_filtrado-E9_hypo_meth.txt

# Calculamos la longitud (pb) de los segmentos con estado 9 en ambos monocitos y filtrados (diferencia de probabilidad posterior con el segundo estado mas probable >0.32) que solapan con regiones HIPER-metiladas:
awk 'BEGIN{FS = "\t"; OFS = "\t"; chr = ""; count=0} {if (chr==$1) {count+=$3-$2} else {print chr,count; chr=$1; count=$3-$2}}  END{print chr,count}' seg_comunes_filtrado-E9_hyper_meth.txt | grep -v chrM > seg_comunes_filtrado-E9_hyper_meth_LENGTH

# Calculamos la longitud (pb) de los segmentos con estado 9 en ambos monocitos y filtrados (diferencia de probabilidad posterior con el segundo estado mas probable >0.32) que solapan con regiones HIPO-metiladas
awk 'BEGIN{FS = "\t"; OFS = "\t"; chr = ""; count=0} {if (chr==$1) {count+=$3-$2} else {print chr,count; chr=$1; count=$3-$2}}  END{print chr,count}' seg_comunes_filtrado-E9_hypo_meth.txt | grep -v chrM > seg_comunes_filtrado-E9_hypo_meth_LENGTH

# Calculamos la longitud (pb) de los segmentos con estado 9 (previamente filtrados y coincidentes en ambos monocitos) (TOTAL):
awk 'BEGIN{FS = "\t"; OFS = "\t"; chr = ""; count=0} {if (chr==$1) {count+=$3-$2} else {print chr,count; chr=$1; count=$3-$2}}  END{print chr,count}' seg_filtrado_E9_INTERSECTION_allChr.bed | grep -v chrM > todoE9

# Porcentaje (pb) de los segmentos filtrados y con estado 9 en ambos monocitos que solapan con regiones hiper- e hipo- metiladas:
paste seg_comunes_filtrado-E9_hyper_meth_LENGTH.txt todoE9 | awk 'BEGIN{total=0;count=0} NR>1{print $1,$2/$4*100"%"; total+=$2/$4; count++} END{print "total "total/count*100"%"}' > porcentaje_pb_HYPER_meth.txt
paste seg_comunes_filtrado-E9_hypo_meth_LENGTH.txt todoE9 | awk 'BEGIN{total=0;count=0} NR>1{print $1,$2/$4*100"%"; total+=$2/$4; count++} END{print "total "total/count*100"%"}' > porcentaje_pb_HYPO_meth.txt

# Solapamiento de segmentos DNase I con regiones hiper- (e hipo-) metiladas:
bedtools intersect -a seg_comunes_filtrado-E9_hyper_meth.bed -b segmentos_comunes_E9_DNase.txt -wb | awk '{FS = "\t"; OFS = "\t"} { print $1, $2, $3 }' > seg_comunes_filtrado-E9_hyperMeth_DNase.txt
bedtools intersect -a seg_comunes_filtrado-E9_hypo_meth.bed -b segmentos_comunes_E9_DNase.txt -wb | awk '{FS = "\t"; OFS = "\t"} { print $1, $2, $3 }' > seg_comunes_filtrado-E9_hypoMeth_DNase.txt

