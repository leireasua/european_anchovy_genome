#!/bin/bash

#SBATCH --job-name=04.1.2_repeatmodeler
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=cpu
#SBATCH --mem=100G
#SBATCH --cpus-per-task=64

module load repeatmodeler/2.0.5

#Input file 
IN=/cluster/home/lchueca/TBG_3759_anchovy/05_annotation/01_simplify_headers/Enen_ragtag_simpl.fasta
#Number of threads
CPU=64

BuildDatabase -name Enen ${IN}
RepeatModeler -threads ${CPU} -LTRStruct -database Enen 