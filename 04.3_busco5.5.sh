#!/bin/bash

#SBATCH --job-name=04.3_busco5.5
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=cpu
#SBATCH --mem=100G
#SBATCH --cpus-per-task=40

module load busco/5.5.0

#CPUs
CPU=40
#Linage for busco analysis
LIN=/cluster/software/busco/datasets/odb10_2021_09_02/actinopterygii_odb10
#Output directory for busco results
OUT=busco5.5_odb10
#BUSCO mode
M=transcriptome

# Run busco on the trasncriptome
busco -i $(pwd)/Trinity.fasta -l ${LIN} -c ${CPU} -o ${OUT} -m ${M} --long --offline