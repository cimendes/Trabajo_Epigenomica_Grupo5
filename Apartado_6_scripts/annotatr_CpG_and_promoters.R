### Apartado 6 ####

### ANOTACIÓN de los segmentos en Estado 9 (previamente filtrados y coincidentes en ambos monocitos) que solapan con regiones HYPER-metiladas (donante C001UY) ##


library("annotatr")
browseVignettes("annotatr")
setwd("~/Documents/Apartado_6")

#leemos archivo BED de interés y lo convertimos en un objeto GRanges 
hyper_meth_E9 = read_regions(con = 'seg_comunes_filtrado-E9_hyper_meth.bed',
                       genome = 'hg19', format = 'bed')

# Select annotations for intersection with regions
# The hg19_cpgs shortcut annotates regions to CpG islands, CpG shores, CpG shelves, and inter-CGI.
# añadimos PROMOTORES
annots2 = c('hg19_cpgs', 'hg19_basicgenes')

# Build the annotations (a single GRanges object)
BiocManager::install("TxDb.Hsapiens.UCSC.hg19.knownGene")
annotations2 = build_annotations(genome = 'hg19', annotations = annots2)

# Intersect the regions we read in with the annotations
# requires a GRanges object (either the result of read_regions() or an existing object)
# a GRanges object of the annotations
# and a logical value indicating whether to ignore.strand

hyper_meth_E9_annotated2 = annotate_regions(
  regions = hyper_meth_E9,
  annotations = annotations2,
  ignore.strand = TRUE,
  quiet = FALSE)

# A GRanges object is returned
print(hyper_meth_E9_annotated2)

# Coerce to a data.frame
df_hyper_meth_E9_annotated2 = data.frame(hyper_meth_E9_annotated2)

# See the GRanges column of hyper_meth_E9_annotated expanded
print(head(df_hyper_meth_E9_annotated2))

# Find the number of regions per annotation type
hyper_meth_E9_annsum2 = summarize_annotations(
  annotated_regions = hyper_meth_E9_annotated2,
  quiet = TRUE)
print(hyper_meth_E9_annsum2)


# A tibble: 10 x 2
# annot.type               n
#<chr>                <int>
#  1 hg19_cpg_inter       25983
#2 hg19_cpg_islands       378
#3 hg19_cpg_shelves      1750
#4 hg19_cpg_shores       1865
#5 hg19_genes_1to5kb     2745
#6 hg19_genes_3UTRs       816
#7 hg19_genes_5UTRs       272
#8 hg19_genes_exons      2191
#9 hg19_genes_introns   13472
#10 hg19_genes_promoters   818

# Plotting regions per Annotation 
plot_annotation(df_hyper_meth_E9_annotated2, plot_title = 'Segmentos E9 solapantes con regiones hyper-metiladas y anotaciones CpG',
                x_label = 'CpG Annotations',
                y_label = 'Count')



### ANOTACIÓN de los segmentos en Estado 9 (previamente filtrados y coincidentes en ambos monocitos) que solapan con regiones HYPO-metiladas (donante C001UY) ##
hypo_meth_E9 = read_regions(con = 'seg_comunes_filtrado-E9_hypo_meth.bed',
                             genome = 'hg19', format = 'bed')

hypo_meth_E9_annotated2 = annotate_regions(
  regions = hypo_meth_E9,
  annotations = annotations2,
  ignore.strand = TRUE,
  quiet = FALSE)

df_hypo_meth_E9_annotated2 = data.frame(hypo_meth_E9_annotated2)
print(head(df_hypo_meth_E9_annotated2))

hypo_meth_E9_annsum2 = summarize_annotations(
  annotated_regions = hypo_meth_E9_annotated2,
  quiet = TRUE)
print(hypo_meth_E9_annsum2)

# A tibble: 10 x 2
#annot.type               n
#<chr>                <int>
#  1 hg19_cpg_inter        1072
#2 hg19_cpg_islands        30
#3 hg19_cpg_shelves       107
#4 hg19_cpg_shores        146
#5 hg19_genes_1to5kb      183
#6 hg19_genes_3UTRs        33
#7 hg19_genes_5UTRs         6
#8 hg19_genes_exons        92
#9 hg19_genes_introns     582
#10 hg19_genes_promoters    33


plot_annotation(df_hypo_meth_E9_annotated2, plot_title = 'Segmentos E9 solapantes con regiones hypo-metiladas y anotaciones CpG',
                x_label = 'CpG Annotations',
                y_label = 'Count')

### gráfico comparación anotaciones de CpG en regiones solapantes hyper- e hypo- metiladas"
install.packages("ggplot2")
library("ggplot2")


# en castellano
# solo hiper e hipo
Regiones <- c("hiper", "hipo")
Genes_1to5kb <- c(2745, 183)
Genes_3UTRs <- c(816, 33)
Genes_5UTRs <- c(272, 6)
Genes_exons <- c(2191, 92)
Genes_introns <- c(13472, 582)
Genes_PROMOTERS <- c(818, 33)
contaje2 <- c(Genes_1to5kb, Genes_3UTRs, Genes_5UTRs, Genes_exons, Genes_introns, Genes_PROMOTERS)
type4 <- c(rep("Genes_1to5kb",2), rep("Genes_3UTRs",2), rep("Genes_5UTRs",2), rep("Genes_exons",2), rep("Genes_introns",2), rep("Genes_PROMOTERS",2))
CpG_annot_E9.data4 <- data.frame(Regiones, contaje2, type4, stringsAsFactors = FALSE)
str(CpG_annot_E9.data4)
plot4 <- ggplot(CpG_annot_E9.data4, aes(Regiones, contaje2))

plot4 +geom_bar(stat = "identity", aes(fill = type4), position = "dodge")+
  ggtitle("Segmentos Estado 9") +
  xlab("Regiones hiper- hipo- metiladas") +
  ylab("Número (n)") +
  labs(fill = "Anotaciones")

# Intento añadir los valores en el gráfico, pero aparecen amontonados 
plot4 + geom_text(aes(label= contaje), position = position_dodge(.9), vjust=-0.5, size = 3)



