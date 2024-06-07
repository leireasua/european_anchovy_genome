#!/bin/bash

#SBATCH --job-name=04.1_interproscan
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=50G
#SBATCH --cpus-per-task=64

module load interproscan/5.64-96.0

#Input file in fasta format
PRO=proteins.fasta
#Number of threads
CPU=64

interproscan.sh -i ${PRO} -f tsv -iprlookup -b Enen -pa -goterms -exclappl SignalP_GRAM_NEGATIVE,SignalP_GRAM_POSITIVE -dp -cpu ${CPU}