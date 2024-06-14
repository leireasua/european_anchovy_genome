#!/bin/bash

#SBATCH --job-name=04.4_add_functional_annot
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=60G
#SBATCH --cpus-per-task=64

module load maker/2.31.10-mpi

PRO=proteins02.fasta
CDS=cds.fasta
ANOT=final_annotation.gff
UNI=uniprot_sprot_2024-05.fasta

ipr_update_gff ${ANOT} Enen.tsv > Enen.all.ipr.gff &&

maker_functional_gff ${UNI} Enen_proteins.fasta.blastp Enen.all.ipr.gff > Enen.all.fun.gff &&

maker_functional_fasta ${UNI} Enen_proteins.fasta.blastp ${CDS} > Enen_CDS.fun.fasta &&

maker_functional_fasta ${UNI} Enen_proteins.fasta.blastp ${PRO} > Enen_proteins.fun.fasta