#!/bin/bash

#SBATCH --job-name=01.2_simplify_headers
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=2G
#SBATCH --cpus-per-task=2

module load augustus/3.5.0

#File we want to simply its headers
IN=/cluster/home/lchueca/TBG_3759_anchovy/03_scaffolding/03_ragtag/ragtag.scaffold.fasta
#The name we want to be called
OUT=Enen_ragtag_simpl.fasta

simplifyFastaHeaders.pl ${IN} Enen ${OUT} Enen_ragtag_header.map