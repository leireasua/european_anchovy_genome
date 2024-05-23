#!/bin/bash

#SBATCH --job-name=03.2_denoiseintrons
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=50G
#SBATCH --cpus-per-task=64

module load gemoma/1.9

#Introns file from 03.1_ERE
INT=/cluster/home/lchueca/TBG_3759_anchovy/05_annotation/03_gemoma/03.1_extraction_RNA_evidence/introns.gff
#Coverage from 03.1_ERE
CO=/cluster/home/lchueca/TBG_3759_anchovy/05_annotation/03_gemoma/03.1_extraction_RNA_evidence/coverage.bedgraph

java -Xmx45G -jar /cluster/software/gemoma/GeMoMa-1.9/GeMoMa-1.9.jar CLI DenoiseIntrons i=${INT} coverage_unstranded=${CO}