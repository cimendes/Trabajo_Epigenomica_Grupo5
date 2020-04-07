# Trabajo de Epigenómica - Grupo 5
###  Máster de Bioinformática y Biología Computacional, Universidad Autónoma de Madrid, Curso Académido 2019-2020 
Análisis de estados de cromatina mediante segmentación: Multivariate Hidden Markov Model (ChromHMM). Este trabajo está centrado en el estado 9 - CTCF. 

Autoras: **Silvia García Cobos, Rosalía Palomino Cabrera, Ana Rodríguez Ronchel, Lucía Sánchez García, Silvia Talavera Marcos**


Este repositorio contiene los scripts utilizados en los diferentes apartados del trabajo. 

### Apartado 1
Obtener los segmentos que tengan el mismo estado en los dos replicados de monocitos.

En este apartado se utilizaron 6 scripts:

**1_1_Filtrar_segmentos_E9.sh**: este script procesa los archivos "POSTERIOR" generados por ChromHMM y genera nuevos archivos con el mismo formato pero que contienen solo los segmentos asignados al estado 9.
**1_2_Generar_grafica_densidad.ipynb**: este script permite ver la distribución de las diferencias entre la dos probabilidades de estado más altas asignadas a cada segmento por el programa ChromHMM (diseñado para analizar datos de ChIP-Seq). En este caso se llevará a cabo sobre archivos previamente filtrados con el script **1_1_Filtrar_segmentos_E9.sh** que contienen solo los segmentos cuyo estado más probable es el 9. 
**1_3_Filtrar_032_archivos_indices**: este script permite la generación de ficheros que contienen el número de línea de aquellos segmentos de los archivos "posterior_state_9_chr" en los que la diferencia de probabilidades entre el estado 9 (E9) y el segundo estado más probable es superior a 0,32.  
**1_4_Generar_archivos_filtrados_E9_032**: este script procesa los archivos de índices de aquellos segmentos cuyo estado mayoritario es el estado 9 y en los que además, la diferencia de probabilidades entre el estado 9 y el siguiente estado más probable es mayor de 0,32. 
