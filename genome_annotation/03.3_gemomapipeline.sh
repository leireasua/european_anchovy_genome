#!/bin/bash

#SBATCH --job-name=03.3_gemomapipeline
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=750G
#SBATCH --cpus-per-task=64

module load gemoma/1.9

#Number of threads
CPU=64
#Input directory where related species genomes are
IN=/cluster/home/lchueca/TBG_3759_anchovy/05_annotation/related_species
#Output directory
OUT=/cluster/home/lchueca/TBG_3759_anchovy/05_annotation/03_gemoma/03_gemoma_pipeline
#Target genome, result obtained from repeatmasker (the name was changed to masked.fasta in 03_genoma_pipeline dir)
GE=/cluster/home/lchueca/TBG_3759_anchovy/04_repeats_annotation/02_repeatmasker/Enen_ragtag_simpl.masked.fasta
#Denoised introns
INT=/cluster/home/lchueca/TBG_3759_anchovy/05_annotation/03_gemoma/02_introns/denoised_introns.gff
#Coverage from 03.1_ERE
CO=/cluster/home/lchueca/TBG_3759_anchovy/05_annotation/03_gemoma/01_extraction_RNA_evidence/coverage.bedgraph

java -Xmx700G -jar /cluster/software/gemoma/GeMoMa-1.9/GeMoMa-1.9.jar CLI GeMoMaPipeline threads=${CPU} outdir=${OUT} tblastn=false \
r=EXTRACTED \
introns=${INT} \
coverage_unstranded=${CO} \
DenoiseIntrons.m=50000 GeMoMa.m=50000 \
GeMoMa.Score=ReAlign AnnotationFinalizer.r=NO o=true p=false \
t=${GE} \
s=own i=SeDor a=${IN}/GCF_002814215.2_Sedor1_genomic.gff g=${IN}/GCF_002814215.2_Sedor1_genomic.fna \
s=own i=CaAur a=${IN}/GCF_003368295.1_ASM336829v1_genomic.gff g=${IN}/GCF_003368295.1_ASM336829v1_genomic.fna \
s=own i=CyLum a=${IN}/GCF_009769545.1_fCycLum1.pri_genomic.gff g=${IN}/GCF_009769545.1_fCycLum1.pri_genomic.fna \
s=own i=MiSal a=${IN}/GCF_014851395.1_ASM1485139v1_genomic.gff g=${IN}/GCF_014851395.1_ASM1485139v1_genomic.fna \
s=own i=AlAlo a=${IN}/GCF_017589495.1_AALO_Geno_1.1_genomic.gff g=${IN}/GCF_017589495.1_AALO_Geno_1.1_genomic.fna \
s=own i=CyCar a=${IN}/GCF_018340385.1_ASM1834038v1_genomic.gff g=${IN}/GCF_018340385.1_ASM1834038v1_genomic.fna \
s=own i=AlSap a=${IN}/GCF_018492685.1_fAloSap1.pri_genomic.gff g=${IN}/GCF_018492685.1_fAloSap1.pri_genomic.fna \
s=own i=DeClu a=${IN}/GCF_900700375.1_fDenClu1.1_genomic.gff g=${IN}/GCF_900700375.1_fDenClu1.1_genomic.fna \
s=own i=ClHar a=${IN}/GCF_900700415.2_Ch_v2.0.2_genomic.gff g=${IN}/GCF_900700415.2_Ch_v2.0.2_genomic.fna \
s=own i=ThAma a=${IN}/GCF_902500255.1_fThaAma1.1_genomic.gff g=${IN}/GCF_902500255.1_fThaAma1.1_genomic.fna \
s=own i=SaPil a=${IN}/Louro_et_al_2019-Sardine-coding_genes.gff g=${IN}/Louro_et_al_2019-Sardine-GCA_900499035.1_SP_G_genomic.fna 