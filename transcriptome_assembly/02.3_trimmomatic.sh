#!/bin/bash

#SBATCH --job-name=02.3_trimmomatic
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=cpu
#SBATCH --mem=25G
#SBATCH --cpus-per-task=28

module load trimmomatic/0.39 fastqc/0.12.1 multiqc/1.20

# Raw data input directory
IN=/cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_ena_02/raw_data
R1=SRR1575626
R2=SRR1575628
CPU=28

# Create a soft link to the raw data
for i in $(find ${IN} -name "*.gz"); do ln -s ${i}; done

java -jar /cluster/software/Trimmomatic/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads ${CPU} \
 ${R1}_1.fastq.gz ${R1}_2.fastq.gz \
 ${R1}_1_paired.fastq.gz ${R1}_1_unpaired.fastq.gz \
 ${R1}_2_paired.fastq.gz ${R1}_2_unpaired.fastq.gz \
 ILLUMINACLIP:/cluster/software/Trimmomatic/Trimmomatic-0.39/adapters/adapter_all.fa:2:30:10 SLIDINGWINDOW:4:20 MINLEN:50 &&

java -jar /cluster/software/Trimmomatic/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads ${CPU} \
 ${R2}_1.fastq.gz ${R2}_2.fastq.gz \
 ${R2}_1_paired.fastq.gz ${R2}_1_unpaired.fastq.gz \
 ${R2}_2_paired.fastq.gz ${R2}_2_unpaired.fastq.gz \
 ILLUMINACLIP:/cluster/software/Trimmomatic/Trimmomatic-0.39/adapters/adapter_all.fa:2:30:10 SLIDINGWINDOW:4:20 MINLEN:50 &&

#Quality control of Illumina reads with fastqc
#Combine fastqc results into a single report

fastqc -t ${CPU} *.gz &&
multiqc .