#!/bin/bash

#SBATCH --job-name=03.3_cutadapt
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=cpu
#SBATCH --mem=30G
#SBATCH --cpus-per-task=40

module load cutadapt/2.8 fastqc/0.12.1 multiqc/1.20

# Raw data input directory
IN=/cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_ena_02/02_trimmomatic
#Output directory
OUT=/cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_ena_02/03_cutadapt
CPU=40

# Create a loop for input data

for i in $(find ${IN} -name "*.gz" | sed "s|"$IN"\/||" | sed 's/.fastq.gz//'); do cutadapt -u 15 -j ${CPU} -o ${OUT}/${i}_cutadapt.fastq.gz  ${IN}/${i}.fastq.gz; done &&

#Quality control of Illumina reads with fastqc
#Combine fastqc results into a single report

fastqc -t ${CPU} *.gz &&
multiqc .