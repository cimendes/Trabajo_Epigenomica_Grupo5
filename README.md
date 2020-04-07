# Trabajo de Epigenómica - Grupo 5
###  Máster en Bioinformática y Biología Computacional, Universidad Autónoma de Madrid
### Curso Académido 2019-2020 
Análisis de estados de cromatina mediante segmentación: Multivariate Hidden Markov Model (ChromHMM). Este trabajo está centrado en el estado 9 - CTCF. 

Autoras: **Silvia García Cobos, Rosalía Palomino Cabrera, Ana Rodríguez Ronchel, Lucía Sánchez García, Silvia Talavera Marcos**


Este repositorio contiene los scripts utilizados en los diferentes apartados del trabajo. 

### Apartado 1
*Obtener los segmentos que tengan el mismo estado en los dos replicados de monocitos.*

En este apartado se utilizaron 6 scripts:

**1_1_Filtrar_segmentos_E9.sh**: este script procesa los archivos "POSTERIOR" generados por ChromHMM y genera nuevos archivos con el mismo formato pero que contienen solo los segmentos asignados al estado 9.
**1_2_Generar_grafica_densidad.ipynb**: este script permite ver la distribución de las diferencias entre la dos probabilidades de estado más altas asignadas a cada segmento por el programa ChromHMM (diseñado para analizar datos de ChIP-Seq). En este caso se llevará a cabo sobre archivos previamente filtrados con el script **1_1_Filtrar_segmentos_E9.sh** que contienen solo los segmentos cuyo estado más probable es el 9.  
**1_3_Filtrar_032_archivos_indices.ipynb**: este script permite la generación de ficheros que contienen el número de línea de aquellos segmentos de los archivos "posterior_state_9_chr" en los que la diferencia de probabilidades entre el estado 9 (E9) y el segundo estado más probable es superior a 0.32.  
**1_4_Generar_archivos_filtrados_E9_032.sh**: este script procesa los archivos de índices de aquellos segmentos cuyo estado mayoritario es el estado 9 y en los que además, la diferencia de probabilidades entre el estado 9 y el siguiente estado más probable es mayor de 0.32.  
**1_5_Generar_ficheros_bed.sh**: este script permite generar los ficheros con formato BED de los segmentos de interés (cuyo estado mayoritario es el 9 y en los que además, la diferencia entre el estado 9 (mayoritario) y el siguiente más probable es mayor de 0.32). Los ficheros generados contienen 3 columnas:  
1. Número de cromosoma. 
2. Sitio (pb) de inicio del segmento. 
3. Sitio (pb) de fin del segmento.  

**1_6_Interseccion_replicas.sh**: este script realiza la intersección entre los archivos (Estado 9 y filtrados según diferencia de probabilidad con el segundo estado > 0.32) de los monocitos 1 y 2 para cada cromosoma.  


### Apartado 2

*Anotar los segmentos. Como mínimo, se deberá dar el porcentaje de segmentos que solapan con protein-coding genes en dicho cromosoma.*


### Apartado 3

*Descargar los picos de DNase I en monocitos de ENCODE y calcular el porcentaje de solapamiento entre DNaseI-peaks y vuestros segmentos de trabajo. Usad el fichero wgEncodeOpenChromDnaseMonocd14Pk.narrowPeak.gz en: http://hgdownload.cse.ucsc.edu/goldenpath/hg19/encodeDCC/wgEncodeOpenChromDnase/*

En este apartado se utilizaron 3 scripts:  

**3_solapamiento_E9.sh**: este script realiza la intersección 
