#!/bin/bash

#SBATCH --job-name=03.3_quast
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=cpu
#SBATCH --mem=20G
#SBATCH --cpus-per-task=30

module load quast/5.0.2

# Draft genome assembly done by hifiasm
IN1=anchovy.asm.bp.p_ctg.fa
#Assembly after scaffolding with yahs
IN2=anchovy.yahs.out_scaffolds_final.fa
#Result assembly after ragtag
IN3=ragtag.scaffold.fasta
# Output directory
OUT=/cluster/home/lchueca/TBG_3759_anchovy/03_scaffolding/03_ragtag
#CPU per task
CPU=30

quast.py -o ${OUT} -m 500 -t ${CPU} ${IN1} ${IN2} ${IN3}