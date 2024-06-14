#!/bin/bash

#SBATCH --job-name=03.4_quast
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=cpu
#SBATCH --mem=20G
#SBATCH --cpus-per-task=30

module load quast/5.0.2

#Create soft links for input files
ln -s /cluster/home/lchueca/TBG_3759_anchovy/05_annotation/related_species/GCA_034702125.1_IST_EnEncr_1.0_genomic.fna
ln -s /cluster/home/lchueca/TBG_3759_anchovy/03_scaffolding/02_yahs/anchovy.yahs.out_scaffolds_final.fa
ln -s /cluster/home/lchueca/TBG_3759_anchovy/03_scaffolding/03_ragtag/ragtag.scaffold.fasta

#Reference genome downloaded from ncbi
IN1=GCA_034702125.1_IST_EnEncr_1.0_genomic.fna
#Assembly after scaffolding with yahs
IN2=anchovy.yahs.out_scaffolds_final.fa
#Result assembly after ragtag
IN3=ragtag.scaffold.fasta
# Output directory
OUT=/cluster/home/lchueca/TBG_3759_anchovy/03_scaffolding/04_quality
#CPU per task
CPU=30

quast.py -o ${OUT} -m 500 -t ${CPU} ${IN1} ${IN2} ${IN3}