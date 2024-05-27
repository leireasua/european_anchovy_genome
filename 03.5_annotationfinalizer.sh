#!/bin/bash

#SBATCH --job-name=03.5_annotationfinalizer
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=50G
#SBATCH --cpus-per-task=64

module load gemoma/1.9

#Genome assembly after scaffolding and masking
GE=/cluster/home/lchueca/TBG_3759_anchovy/04_repeats_annotation/02_repeatmasker/Enen_ragtag_simpl.masked.fasta
#Annotation obtained from GAF (gemoma annotation filter)
ANOT=/cluster/home/lchueca/TBG_3759_anchovy/05_annotation/03_gemoma/04_GAF/filtered_predictions.gff
#Introns file
INT=/cluster/home/lchueca/TBG_3759_anchovy/05_annotation/03_gemoma/02_introns/denoised_introns.gff
#Coverage from 03.1_ERE
CO=/cluster/home/lchueca/TBG_3759_anchovy/05_annotation/03_gemoma/01_extraction_RNA_evidence/coverage.bedgraph

java -Xmx45G -jar /cluster/software/gemoma/GeMoMa-1.9/GeMoMa-1.9.jar CLI AnnotationFinalizer g=${GE} a=${ANOT} p=Enen u=YES i=${INT} c=UNSTRANDED coverage_unstranded=${CO}