#!/bin/bash

#SBATCH --job-name=01.1_simplify_headers
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=2G
#SBATCH --cpus-per-task=2

module load augustus/3.5.0

#File we want to simply its headers
IN=/cluster/home/lchueca/TBG_3759_anchovy/03_scaffolding/02_yahs/anchovy.yahs.out_scaffolds_final.fa
#The name we want to be called
OUT=Enen_yahs_simpl.fasta

simplifyFastaHeaders.pl ${IN} Enen ${OUT} Enen_yahs_header.map