#!/bin/bash

#SBATCH --job-name=03.2_yahs
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=460G
#SBATCH --cpus-per-task=30

module load yahs/1.1 samtools/1.19.1

#Hifi assembly (contig seq) in fasta format
IN1=anchovy.asm.bp.p_ctg.fa
#Alignment results of Hi-C reads to the contigs in a bam file
IN2=/cluster/home/lchueca/TBG_3759_anchovy/03_scaffolding/01_mapping_pipeline/deduplicated_files/ANTXOA_rep1.bam

samtools faidx ${IN1}

yahs -o anchovy.yahs.out ${IN1} ${IN2}