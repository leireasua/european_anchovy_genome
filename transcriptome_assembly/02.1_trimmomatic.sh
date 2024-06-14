#!/bin/bash

#SBATCH --job-name=02.1_trimmomatic
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=23G
#SBATCH --cpus-per-task=28

module load trimmomatic/0.39

# Raw data input directory
IN=/cluster/home/lchueca/TBG_3759_5/X204SC23051431-Z01-F001/01.RawData/Anchovis_Mix_7
R1=Anchovis_Mix_7_EKRN23H000053-1A_HFC7MDSX7_L3
R2=Anchovis_Mix_7_EKRN23H000053-1A_HFCCLDSX7_L4
CPU=28

# Creat a soft link to the raw data
for i in $(find ${IN} -name "*fq.gz"); do ln -s ${i}; done

java -jar /cluster/software/Trimmomatic/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads ${CPU} \
 ${R1}_1.fq.gz ${R1}_2.fq.gz \
 ${R1}_1_paired.fq.gz ${R1}_1_unpaired.fq.gz \
 ${R1}_2_paired.fq.gz ${R1}_2_unpaired.fq.gz \
 ILLUMINACLIP:/cluster/software/Trimmomatic/Trimmomatic-0.39/adapters/adapter_all.fa:2:30:10 SLIDINGWINDOW:4:20 MINLEN:50 &&

java -jar /cluster/software/Trimmomatic/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads ${CPU} \
 ${R2}_1.fq.gz ${R2}_2.fq.gz \
 ${R2}_1_paired.fq.gz ${R2}_1_unpaired.fq.gz \
 ${R2}_2_paired.fq.gz ${R2}_2_unpaired.fq.gz \
 ILLUMINACLIP:/cluster/software/Trimmomatic/Trimmomatic-0.39/adapters/adapter_all.fa:2:30:10 SLIDINGWINDOW:4:20 MINLEN:50
 
