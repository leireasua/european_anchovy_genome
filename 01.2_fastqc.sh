#!/bin/bash

#SBATCH --job-name=01.2_fastqc
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=cpu
#SBATCH --mem=5G
#SBATCH --cpus-per-task=4

module load fastqc/0.12.1 multiqc/1.20

#RNA sequences
IN=/cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_ena_01/raw_data/*.gz
#Output directory
OUT=/cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_ena_01/01_fastqc
#CPU per task
CPU=4

#Quality control of Illumina reads with fastqc
#Combine fastqc results into a single report

fastqc -o ${OUT} -t ${CPU} ${IN} &&
multiqc .