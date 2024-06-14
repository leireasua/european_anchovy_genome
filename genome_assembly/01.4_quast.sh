#!/bin/bash

#SBATCH --job-name=01.4_quast
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=cpu
#SBATCH --mem=5G
#SBATCH --cpus-per-task=16

module load quast/5.0.2

# Draft genome assembly
IN=/cluster/home/lchueca/TBG_3759_anchovy/01.4_wtdbg/prueba/anchovy.asm.cns.fa
OUT=/cluster/home/lchueca/TBG_3759_anchovy/01.4_wtdbg/prueba/quast
#CPU per task
CPU=16

quast.py -o ${OUT} -m 500 -t ${CPU} ${IN}