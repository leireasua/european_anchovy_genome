#!/bin/bash

#SBATCH --job-name=03.1_ERE
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=30G
#SBATCH --cpus-per-task=64

module load gemoma/1.9

#mapped reads file from hisat2 in sam format
IN=/cluster/home/lchueca/TBG_3759_anchovy/05_annotation/02_hisat2/Enen_hisat2.bam

#Extract introns and coverage from mapped RNA-seq reads
java -jar /cluster/software/gemoma/GeMoMa-1.9/GeMoMa-1.9.jar CLI ERE m=${IN}