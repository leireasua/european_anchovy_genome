#!/bin/bash

#SBATCH --job-name=01.1_fastaqc-multiqc
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=cpu
#SBATCH --mem=550G
#SBATCH --cpus-per-task=64

module load fastqc/0.12.1
module load multiqc/1.20

#RNA sequences
IN1=/cluster/home/lchueca/TBG_3759_5/X204SC23051431-Z01-F001/01.RawData/Anchovis_Mix_7/Anchovis_Mix_7_EKRN23H000053-1A_HFC7MDSX7_L3_1.fq.gz
IN2=/cluster/home/lchueca/TBG_3759_5/X204SC23051431-Z01-F001/01.RawData/Anchovis_Mix_7/Anchovis_Mix_7_EKRN23H000053-1A_HFC7MDSX7_L3_2.fq.gz
IN3=/cluster/home/lchueca/TBG_3759_5/X204SC23051431-Z01-F001/01.RawData/Anchovis_Mix_7/Anchovis_Mix_7_EKRN23H000053-1A_HFCCLDSX7_L4_1.fq.gz
IN4=/cluster/home/lchueca/TBG_3759_5/X204SC23051431-Z01-F001/01.RawData/Anchovis_Mix_7/Anchovis_Mix_7_EKRN23H000053-1A_HFCCLDSX7_L4_2.fq.gz
#Output directory
OUT=/cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_adult/01_fastaqc
#CPU per task
CPU=64

fastqc -o ${OUT} --noextract -f fastq -t ${CPU} ${IN1} ${IN2} ${IN3} ${IN4} &&
multiqc .