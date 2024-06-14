#!/bin/bash

#SBATCH --job-name=02.1_quast3
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=6G
#SBATCH --cpus-per-task=12

module load quast/5.0.2

# Draft genome assembly 01.1_hifiasm
IN1=/cluster/home/lchueca/TBG_3759_anchovy/01.1_hifiasm/anchovy.asm.bp.p_ctg.fa
# Draft genome assembly 01.2_flye
IN2=/cluster/home/lchueca/TBG_3759_anchovy/01.2_flye/assembly.fasta
# Draft genome assembly 01.4_wtdbg/prueba
IN3=/cluster/home/lchueca/TBG_3759_anchovy/01.4_wtdbg/prueba/anchovy.asm.cns.fa
# Output directory
OUT=/cluster/home/lchueca/TBG_3759_anchovy/02_quast
#CPU per task
CPU=12

#quast for comparing 3 different assemblies
quast.py -o ${OUT} -m 500 -t ${CPU} ${IN1} ${IN2} ${IN3}