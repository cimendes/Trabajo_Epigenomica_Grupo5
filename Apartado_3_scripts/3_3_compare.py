#!/usr/bin/env python

########################################################
# Script que ordena los valores cada línea de un archivo
#
# En este caso le pasamos los archivos Monocyte"$a"_11_Master_11_chr"$i"_posterior.txt,
# pero sin las dos líneas de cabecera
#
# Basado en: https://stackoverflow.com/questions/18709507/maximum-and-minimum-using-awk
########################################################
import sys
file = sys.argv[1]

for line in open(file):
    line = line.strip().split("\t")
    new_line = [ float(x) for x in line ]
    new_line.sort(reverse=True)
    newest_line = [ str(x) for x in new_line ]
    print('\t'.join(newest_line))

