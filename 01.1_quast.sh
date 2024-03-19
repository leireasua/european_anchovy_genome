#!/bin/bash

#SBATCH --job-name=01.1_quast
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=cpu
#SBATCH --mem=5G
#SBATCH --cpus-per-task=64

module load quast/5.0.2

# Draft genome assembly
IN1=/cluster/home/lchueca/TBG_3759_anchovy/01.1_hifiasm/anchovy.asm.bp.p_ctg.fa
# Output directory
OUT=/cluster/home/lchueca/TBG_3759_anchovy/01.1_hifiasm/quast
#CPU per task
CPU=64

quast.py -o ${OUT} -m 500 -t ${CPU} ${IN1}
