#!/bin/bash

#SBATCH --job-name=04.2_repeatmasker
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=150G
#SBATCH --cpus-per-task=64

module load repeatmasker/4.1.4

#Zebrafish (danio rerio) repbase
RB=/cluster/software/repbase/RepBase27.03.fasta/zebrep.ref
#European anchovy repeat database obtained from repeatmodeler
DB=/cluster/home/lchueca/TBG_3759_anchovy/04_repeats_annotation/01_repeatmodeler/Enen-families.fa

ln -s ${RB} &&
ln -s ${DB} &&

#Combine both repeat databases in one database file
cat zebrep.ref Enen-families.fa > zebrep_Enen.ref &&

#Genome assembly after scaffolding with yahs in fasta format
IN=/cluster/home/lchueca/TBG_3759_anchovy/05_annotation/01_simplify_headers/Enen_ragtag_simpl.fasta

RepeatMasker -pa 16 -s -lib zebrep_Enen.ref -no_is -dir . -xsmall ${IN}