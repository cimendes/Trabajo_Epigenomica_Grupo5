######################################
# TAREA 3: porcentaje intersección con segmentos DNase
######################################
cat CD14_monocytesDukeDNaseSeq.pk | cut -f1,2,3 > segments_DNase.bed

#  da segments en común entre E9 y DNasa
bedtools intersect -a ./segmentos_mismo_estado_E9.txt -b ./segments_DNase.bed -wb  | awk '{FS = "\t"; OFS = "\t"} { print $1, $2, $3 }' > segmentos_comunes_E9_DNase.txt

#  da el total de nt comunes (para cada chr)
awk 'BEGIN{FS = "\t"; OFS = "\t"; chr = ""; count=0} {if (chr==$1) {count+=$3-$2} else {print chr,count; chr=$1; count=$3-$2}}  END{print chr,count}' segmentos_comunes_E9_DNase.txt > interseccion

#  se le puede aplicar también al de solo E9
awk 'BEGIN{FS = "\t"; OFS = "\t"; chr = ""; count=0} {if (chr==$1) {count+=$3-$2} else {print chr,count; chr=$1; count=$3-$2}}  END{print chr,count}' segmentos_mismo_estado_E9.txt > todoE9

#  calculamos porcentaje de NUCLEÓTIDOS E9 que solapan con picos de DNasa (por chr y total):
paste interseccion todoE9 | awk 'BEGIN{total=0;count=0} NR>1{print $1,$2/$4*100"%"; total+=$2/$4; count++} END{print "total "total/count*100"%"}'