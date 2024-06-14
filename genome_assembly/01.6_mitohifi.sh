#!/bin/bash

#SBATCH --job-name=01.6_mitohifi
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=200G
#SBATCH --cpus-per-task=64

module load mitohifi/3.2

# TBG_3759_6 copied in 01.6_mitohifi directory as fasta format
IN=/cluster/home/lchueca/TBG_3759_anchovy/01.6_mitohifi/m84051_230814_140752_s1.hifi_reads.default.fasta
#Output drectory
OUT=/cluster/home/lchueca/TBG_3759_anchovy/01.6_mitohifi
#Number of threads
CPU=64
#Variables for related mitogenomes, downloaded in ncbi
R1=/cluster/home/lchueca/TBG_3759_anchovy/01.6_mitohifi/anchovy_mitochondrial_seq_ncbi.fa
R2=/cluster/home/lchueca/TBG_3759_anchovy/01.6_mitohifi/anchovy_mitochondrial_seq_ncbi.gb

mitohifi.py -r ${IN} -f ${R1} -g ${R2} -t ${CPU} -a animal -o 2