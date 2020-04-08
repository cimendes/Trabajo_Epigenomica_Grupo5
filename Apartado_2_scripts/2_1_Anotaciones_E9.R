###################################################### 
#                    DESCRIPCIÓN                     #
###################################################### 
# Script realizado para introducir distintas anotaciones en los segmentos previamente
# seleccionados tras el filtrado y la interseccion (Apartado_0 y Apartado_1, respectivamente)

# Se carga la librería necesaria para la ejecución de este Script
library("annotatr")

setwd("~/Documentos/Master_Lucia/Segundo_cuatri/Transcriptomica/Epigenomica/Trabajo/Filtrado/Practica_Master_ChromHMM/Apartado_1_INTERSECCION/")

# Lectura de los segmentos filtrados: con estado E9 como estado más probable y con una 
# diferencia entre el estado E9 y el siguiente más probable superior a 0.32
dm_segmentos = read_regions(con = 'Interseccion_TODOS_CROMOSOMAS.bed', genome = 'hg19', format = 'bed')

# Selección de las anotaciones de interés
annots = c('hg19_cpgs', 'hg19_basicgenes', 'hg19_genes_intergenic',
           'hg19_genes_intronexonboundaries', 'hg19_genes_cds')

# Build the annotations (a single GRanges object)
annotations = build_annotations(genome = 'hg19', annotations = annots)

# Intersect the regions we read in with the annotations
dm_annotated = annotate_regions(
  regions = dm_segmentos,
  annotations = annotations,
  ignore.strand = TRUE,
  quiet = FALSE)
# A GRanges object is returned

# Coerce to a data.frame
df_dm_annotated = data.frame(dm_annotated)

# See the GRanges column of dm_annotaed expanded
print(head(df_dm_annotated))

# Escritura del archivo de interes
# write.csv(df_dm_annotated, "Anotaciones_interseccion_todos_chr_E9.csv", quote = FALSE, row.names = FALSE)

