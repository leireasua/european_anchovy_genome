#!/bin/bash

#SBATCH --job-name=02.4_trimmomatic
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=cpu
#SBATCH --mem=23G
#SBATCH --cpus-per-task=28

module load trimmomatic/0.39 fastqc/0.12.1 multiqc/1.20

# Raw data input directory
IN=/cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_egg_juvenil/raw_data/X204SC22112109-Z01-F001/01.RawData/BIOMAN220*
R1=BIOMAN2201_EKRO220002520-1A_HYVG3DSX3_L2
R2=BIOMAN2202_EKRO220002521-1A_H22FLDSX5_L4
R3=BIOMAN2202_EKRO220002521-1A_H25LYDSX5_L4
CPU=28

# Create a soft link to the raw data
for i in $(find ${IN} -name "*.gz"); do ln -s ${i}; done

java -jar /cluster/software/Trimmomatic/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads ${CPU} \
 ${R1}_1.fq.gz ${R1}_2.fq.gz \
 ${R1}_1_paired.fq.gz ${R1}_1_unpaired.fq.gz \
 ${R1}_2_paired.fq.gz ${R1}_2_unpaired.fq.gz \
 ILLUMINACLIP:/cluster/software/Trimmomatic/Trimmomatic-0.39/adapters/adapter_all.fa:2:30:10 SLIDINGWINDOW:4:20 MINLEN:50 &&

java -jar /cluster/software/Trimmomatic/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads ${CPU} \
 ${R2}_1.fq.gz ${R2}_2.fq.gz \
 ${R2}_1_paired.fq.gz ${R2}_1_unpaired.fq.gz \
 ${R2}_2_paired.fq.gz ${R2}_2_unpaired.fq.gz \
 ILLUMINACLIP:/cluster/software/Trimmomatic/Trimmomatic-0.39/adapters/adapter_all.fa:2:30:10 SLIDINGWINDOW:4:20 MINLEN:50 &&

 java -jar /cluster/software/Trimmomatic/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads ${CPU} \
 ${R3}_1.fq.gz ${R3}_2.fq.gz \
 ${R3}_1_paired.fq.gz ${R3}_1_unpaired.fq.gz \
 ${R3}_2_paired.fq.gz ${R3}_2_unpaired.fq.gz \
 ILLUMINACLIP:/cluster/software/Trimmomatic/Trimmomatic-0.39/adapters/adapter_all.fa:2:30:10 SLIDINGWINDOW:4:20 MINLEN:50 &&

#Quality control of Illumina reads with fastqc
#Combine fastqc results into a single report

fastqc -t ${CPU} *.gz &&
multiqc .