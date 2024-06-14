#!/bin/bash

#SBATCH --job-name=03.1_mapping_slurm
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=300G
#SBATCH --cpus-per-task=64

module load bwa/0.7.17 samtools/1.19.1 java/jdk-20.0.2

./arima_mapping_pipeline_1.sh
