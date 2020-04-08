##################### DESCRIPCIÓN #####################
#
# Este script permite la ANOTACIÓN de islas CpG (regiones con alta concentración de citosinas y guaninas) y estructuras genéticas asociadas
# en segmentos con estado 9 (previamente filtrados y coincidentes en los dos monocitos) que solapan con regiones hiper- e hipo-metiladas de monocitos del donante C001UY.
# Utiliza el paquete en R annotatr
#######################################################

# Anotación de los segmentos en Estado 9 (previamente filtrados y coincidentes en ambos monocitos)
# que solapan con regiones HIPER-metiladas del donante C001UY. 


library("annotatr")
browseVignettes("annotatr")
setwd("~/Documents/Apartado_6")

#leemos archivo BED de interés y lo convertimos en un objeto GRanges
#el archivo BED generado de la intersección de los segmentos en estado 9 solapantes con regiones HIPER-metiladas (monocitos donate C001UY)
hyper_meth_E9 = read_regions(con = 'seg_comunes_filtrado-E9_hyper_meth.bed',
                       genome = 'hg19', format = 'bed')

# Seleccionamos anotaciones
# hg19_cpgs anota las regiones: CpG islands, CpG shores, CpG shelves,inter-CGI.
# hg19_basicgenes anota las regiones:
# 1-5Kb upstream of the TSS (transcriptional start site), PROMOTORES (< 1Kb upstream of the TSS), 5’UTR, exons, introns, 3’UTR, and intergenic regions (the intergenic regions exclude the previous list of annotations)
annots2 = c('hg19_cpgs', 'hg19_basicgenes')

# para el siguiente paso, puede que necesitemos instalar:
BiocManager::install("TxDb.Hsapiens.UCSC.hg19.knownGene")
# Construimos las anotaciones (objeto GRanges)
annotations2 = build_annotations(genome = 'hg19', annotations = annots2)

# Intersect the regions we read in with the annotations
# se requiere objeto GRanges (como resultado de read_regions() o uno ya existente)
# también se requiere objeto GRanges resultado de annotations2
# y un valor lógico indicando si ignore.strand

hyper_meth_E9_annotated2 = annotate_regions(
  regions = hyper_meth_E9,
  annotations = annotations2,
  ignore.strand = TRUE,
  quiet = FALSE)

# Obtenemos un objeto GRanges 
print(hyper_meth_E9_annotated2)

# Lo transformamos en un data.frame
df_hyper_meth_E9_annotated2 = data.frame(hyper_meth_E9_annotated2)
print(head(df_hyper_meth_E9_annotated2))

# Número de regiones por cada anotación
hyper_meth_E9_annsum2 = summarize_annotations(
  annotated_regions = hyper_meth_E9_annotated2,
  quiet = TRUE)
print(hyper_meth_E9_annsum2)

# Gráfico simple de las regiones por anotación 
plot_annotation(df_hyper_meth_E9_annotated2, plot_title = 'Segmentos E9 solapantes con regiones hyper-metiladas y anotaciones CpG',
                x_label = 'CpG Annotations',
                y_label = 'Count')


# (Repetimos el proceso para las regiones hipo-metiladas)
# Anotación de los segmentos en Estado 9 (previamente filtrados y coincidentes en ambos monocitos)
# que solapan con regiones HIPO-metiladas (donante C001UY)

hypo_meth_E9 = read_regions(con = 'seg_comunes_filtrado-E9_hypo_meth.bed',
                             genome = 'hg19', format = 'bed')

hypo_meth_E9_annotated2 = annotate_regions(
  regions = hypo_meth_E9,
  annotations = annotations2,
  ignore.strand = TRUE,
  quiet = FALSE)

# Lo transformamos en un data.frame
df_hypo_meth_E9_annotated2 = data.frame(hypo_meth_E9_annotated2)
print(head(df_hypo_meth_E9_annotated2))

# Número de regiones por cada anotación
hypo_meth_E9_annsum2 = summarize_annotations(
  annotated_regions = hypo_meth_E9_annotated2,
  quiet = TRUE)
print(hypo_meth_E9_annsum2)

# Gráfico simple de las regiones por anotación
plot_annotation(df_hypo_meth_E9_annotated2, plot_title = 'Segmentos E9 solapantes con regiones hypo-metiladas y anotaciones CpG',
                x_label = 'CpG Annotations',
                y_label = 'Count')





