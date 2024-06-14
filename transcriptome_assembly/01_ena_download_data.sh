#!/bin/bash

#SBATCH --job-name=01_ena_download_data
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=1G
#SBATCH --cpus-per-task=1
#SBATCH --array=1-5%5

module load sratoolkit/3.0.7

FILE=$(cat 01_ena_samples_download.txt | sed -n ${SLURM_ARRAY_TASK_ID}p) &&
bash -c "$FILE" &&

gzip *fastq

