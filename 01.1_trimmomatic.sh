#!/bin/bash

#SBATCH --job-name=01.1_trimmomatic
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=cpu
#SBATCH --mem=550G
#SBATCH --cpus-per-task=64

module load trimmomatic/0.39

#CPU per task
CPU=64

PE -threads ${CPU} [-phred33|-phred64] -trimlog anchovy_rna.trimLog \
> -basein <inputBase> | <inputFile1> <inputFile2> -baseout <anchovy_rna.fq> | <outputFile1P> <outputFile1U> <outputFile2P> <outputFile2U>] \
> ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 \
> LEADING:3 TRAILING:3 \
> SLIDINGWINDOW:4:15 \
> MINLEN:36 

#phred 33 or 64? depends on the illumina pipeline used (they are quality scores)
#input and output files names no entiendo muy bien
#me faltan los datos de illumina RNA
