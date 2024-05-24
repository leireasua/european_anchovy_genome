#!/bin/bash

#SBATCH --job-name=03.2_checkintrons
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=50G
#SBATCH --cpus-per-task=64

module load gemoma/1.9

#Target genome, result obtained from repeatmasker
GE=/cluster/home/lchueca/TBG_3759_anchovy/04_repeats_annotation/02_repeatmasker/Enen_ragtag_simpl.fasta.masked
#Introns file from 03.1_ERE
INT=/cluster/home/lchueca/TBG_3759_anchovy/05_annotation/03_gemoma/01_extraction_RNA_evidence/introns.gff

java -jar /cluster/software/gemoma/GeMoMa-1.9/GeMoMa-1.9.jar CLI CheckIntrons t=${GE} i=${INT}