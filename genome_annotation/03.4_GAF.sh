#!/bin/bash

#SBATCH --job-name=03.4_GAF
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=50G
#SBATCH --cpus-per-task=64

module load gemoma/1.9

#Directory where gene annotations are (from gemoma pipeline)
IN=/cluster/home/lchueca/TBG_3759_anchovy/05_annotation/03_gemoma/03_gemoma_pipeline/unfiltered_predictions_from_species

java -Xmx45G -jar /cluster/software/gemoma/GeMoMa-1.9/GeMoMa-1.9.jar CLI GAF \
g=${IN}_0.gff p=SeDor \
g=${IN}_1.gff p=CaAur \
g=${IN}_2.gff p=CyLum \
g=${IN}_3.gff p=MiSal \
g=${IN}_4.gff p=AlAlo \
g=${IN}_5.gff p=CyCar \
g=${IN}_6.gff p=AlSap \
g=${IN}_7.gff p=DeClu \
g=${IN}_8.gff p=ClHar \
g=${IN}_9.gff p=ThAma 