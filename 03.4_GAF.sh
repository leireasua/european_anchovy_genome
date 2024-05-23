#!/bin/bash

#SBATCH --job-name=03.4_GAF
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=50G
#SBATCH --cpus-per-task=64

module load gemoma/1.9

#Gene annotation file obtained from gemoma_pipeline

java -Xmx45G -jar /cluster/software/gemoma/GeMoMa-1.9/GeMoMa-1.9.jar CLI GAF g=<gene_annotation_file>