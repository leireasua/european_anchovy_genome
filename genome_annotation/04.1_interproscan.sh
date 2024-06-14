#!/bin/bash

#SBATCH --job-name=04.1_interproscan
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=500G
#SBATCH --cpus-per-task=64

module load interproscan/5.47-82.0

#In order to replace * symbol that represents stop codon, the following command was used:
#sed 's/\*//g' proteins.fasta > proteins02.fasta

#Input file in fasta format
PRO=proteins02.fasta
#Number of threads
CPU=64

interproscan.sh -i ${PRO} -f tsv -iprlookup -b Enen -pa -goterms -exclappl SignalP_GRAM_NEGATIVE,SignalP_GRAM_POSITIVE -dp -cpu ${CPU}