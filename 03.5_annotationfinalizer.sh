#!/bin/bash

#SBATCH --job-name=03.4_annotationfinalizer
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=50G
#SBATCH --cpus-per-task=64

module load gemoma/1.9

#Genome assembly after scaffolding and masking
GE=/cluster/home/lchueca/TBG_3759_anchovy/04_repeats_annotation/02_repeatmasker/Enen_ragtag_simpl.fasta.masked
#Annotation obtained from GAF (gemoma annotation filter)
ANOT=
#Introns file
INT=denoise_introns
#Coverage from 03.1_ERE
CO=/cluster/home/lchueca/TBG_3759_anchovy/05_annotation/03_gemoma/03.1_extraction_RNA_evidence/coverage.bedgraph

java -Xmx45G -jar /cluster/software/gemoma/GeMoMa-1.9/GeMoMa-1.9.jar CLI AnnotationFinalizer g=${GE} a=${ANOT} p=Enen_annotation i=${INT} c=${CO}