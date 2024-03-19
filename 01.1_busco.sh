#!/bin/bash

#SBATCH --job-name=01.1_busco
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=50G
#SBATCH --cpus-per-task=8

module load busco/5.5.0

# Draft genome assembly
IN1=/cluster/home/lchueca/TBG_3759_anchovy/01.1_hifiasm/anchovy.asm.bp.p_ctg.fa
# Lineage
LIN=/cluster/software/busco/datasets/odb10_2021_09_02/actinopterygii_odb10
# Output directory
OUT=/cluster/home/lchueca/TBG_3759_anchovy/01.1_hifiasm/busco5.5_odb10
#CPU per task
CPU=8

busco -i ${IN1} -l ${LIN} -o ${OUT} -m genome -c ${CPU} --long --offline

