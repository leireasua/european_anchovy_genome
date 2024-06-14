#!/bin/bash

#SBATCH --job-name=01.4_busco5.5
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=50G
#SBATCH --cpus-per-task=8

module load busco/5.5.0

# Draft genome assembly
IN=/cluster/home/lchueca/TBG_3759_anchovy/01.4_wtdbg/prueba/anchovy.asm.cns.fa
# Lineage
LIN=/cluster/software/busco/datasets/odb10_2021_09_02/actinopterygii_odb10
# Output directory
OUT=busco5.5_odb10_results
#CPU per task
CPU=8

busco -i ${IN} -l ${LIN} -o ${OUT} -m genome -c ${CPU} --long --offline