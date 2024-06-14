#!/bin/bash

#SBATCH --job-name=03.5_busco
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=100G
#SBATCH --cpus-per-task=8

module load busco/5.5.0

#Proteins file obtained from extractor
IN=/cluster/home/lchueca/TBG_3759_anchovy/05_annotation/03_gemoma/05_annotation_finalizer/proteins.fasta
#Lineage
LIN=/cluster/software/busco/datasets/odb10_2021_09_02/actinopterygii_odb10
#Output directory
OUT=busco5.5_odb10 
#CPU per task
CPU=8

busco -i ${IN} -l ${LIN} -o ${OUT} -m proteins -c ${CPU} --long --offline