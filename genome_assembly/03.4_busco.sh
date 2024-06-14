#!/bin/bash

#SBATCH --job-name=03.4_busco
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=50G
#SBATCH --cpus-per-task=8

module load busco/5.5.0

# Draft genome assembly
IN=GCA_034702125.1_IST_EnEncr_1.0_genomic.fna
# Lineage
LIN=/cluster/software/busco/datasets/odb10_2021_09_02/actinopterygii_odb10
# Output directory
OUT=busco5.5_odb10 
#CPU per task
CPU=8

busco -i ${IN} -l ${LIN} -o ${OUT} -m genome -c ${CPU} --long --offline