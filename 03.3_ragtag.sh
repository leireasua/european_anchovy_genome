#!/bin/bash

#SBATCH --job-name=03.3_ragtag
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=cpu
#SBATCH --mem=200G
#SBATCH --cpus-per-task=64

module load ragtag/2.1.0 python3/3.7.4 perl/5.30.0 mummer/4.0.0b2

#Reference genome
REF=GCA_034702125.1_IST_EnEncr_1.0_genomic.fna
#Alignment results of Hi-C reads to the contigs after yahs
QUE=anchovy.yahs.out_scaffolds_final
#Output directory
OUT=/cluster/home/lchueca/TBG_3759_anchovy/03_scaffolding/03_ragtag
#Number of threads
CPU=64

#correct contigs
ragtag.py correct -t ${CPU} -o ${OUT} ${REF} ${QUE}.fa

#scaffold contigs
ragtag.py scaffold -t ${CPU} -o ${OUT} ${REF} ragtag.correct.fasta