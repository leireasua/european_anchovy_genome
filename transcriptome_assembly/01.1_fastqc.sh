#!/bin/bash

#SBATCH --job-name=01.1_fastqc
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=cpu
#SBATCH --mem=5G
#SBATCH --cpus-per-task=4

module load fastqc/0.12.1 multiqc/1.20

#RNA sequences
IN=/cluster/home/lchueca/TBG_3759_5/X204SC23051431-Z01-F001/01.RawData/Anchovis_Mix_7/*.gz
#Output directory
OUT=/cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_adult/01_fastqc
#CPU per task
CPU=4

#Quality control of Illumina reads with fastqc
#Combine fastqc results into a single report
#multiqc . or ${pwd} or ${OUT} is the same

fastqc -o ${OUT} -t ${CPU} ${IN} &&
multiqc .