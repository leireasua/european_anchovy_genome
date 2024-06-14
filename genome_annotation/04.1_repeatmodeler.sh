#!/bin/bash

#SBATCH --job-name=04.1_repeatmodeler
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=100G
#SBATCH --cpus-per-task=64

module load repeatmodeler/2.0.5

#Input file 
IN=/cluster/home/lchueca/TBG_3759_anchovy/03_scaffolding/02_yahs/anchovy.yahs.out_scaffolds_final.fa
#Number of threads
CPU=64

BuildDatabase -name Enen ${IN}
RepeatModeler -threads ${CPU} -LTRStruct -database Enen 