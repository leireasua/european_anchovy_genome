#!/bin/bash

#SBATCH --job-name=04.3_blast
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=30G
#SBATCH --cpus-per-task=64

module load ncbi-blast/2.15.0

#Input file in fasta format
PRO=proteins02.fasta
#Number of threads
CPU=64

#uniprot_sprot_2024-05.fasta was downloaded using wget from uniprot

#blast vs swissprot for putative names:

makeblastdb -in uniprot_sprot_2024-05.fasta -out uniprot_sprot_2024-05.fasta -parse_seqids -dbtype prot &&

blastp -num_threads ${CPU} -query ${PRO} -db uniprot_sprot_2024-05.fasta -evalue 1e-6 -max_hsps 1 -max_target_seqs 1 -outfmt 6 -out Enen_proteins.fasta.blastp