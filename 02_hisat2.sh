#!/bin/bash

#SBATCH --job-name=02_hisat2
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=cpu
#SBATCH --mem=150G
#SBATCH --cpus-per-task=96

module load hisat/2.2.1 samtools/1.19.1

#Directories of RNA data
IN1=/cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_adult/03_cutadapt
IN2=/cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_ena_01/03_cutadapt
IN3=/cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_ena_02/03_cutadapt
IN4=/cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_egg_juvenil/03_cutadapt

#Create soft links for the trimmed data, same data name (fq or fastq .gz, for that the *)
for i in $(find "${IN1}" "${IN2}" "${IN3}" "${IN4}" -name "*paired_cutadapt.*.gz"); do ln -s ${i}; done

#Genome assembly after scaffolding and masking
GE=/cluster/home/lchueca/TBG_3759_anchovy/04_repeats_annotation/02_repeatmasker/Enen_ragtag_simpl.fasta.masked
#RNA data from different directories
R1=Anchovis_Mix_7_EKRN23H000053-1A_HFC7MDSX7_L3
R2=Anchovis_Mix_7_EKRN23H000053-1A_HFCCLDSX7_L4
R3=SRR4431660
R4=SRR4431653
R5=SRR4431649
R6=SRR4431645
R7=SRR1575626
R8=SRR1575628
R9=BIOMAN2201_EKRO220002520-1A_HYVG3DSX3_L2
R10=BIOMAN2202_EKRO220002521-1A_H22FLDSX5_L4
R11=BIOMAN2202_EKRO220002521-1A_H25LYDSX5_L4
#Number of threads
CPU=96

#Build an index from reference sequence
hisat2-build -p ${CPU} ${GE} Enen_genome_hisat2 &&

#Alignment
hisat2 -k 3 --pen-noncansplice 12 -x Enen_genome_hisat2 \
-1 ${R1}_1_paired_cutadapt.fq.gz,${R2}_1_paired_cutadapt.fq.gz,${R3}_1_paired_cutadapt.fastq.gz,${R4}_1_paired_cutadapt.fastq.gz,${R5}_1_paired_cutadapt.fastq.gz,${R6}_1_paired_cutadapt.fastq.gz,${R7}_1_paired_cutadapt.fastq.gz,${R8}_1_paired_cutadapt.fastq.gz,${R9}_1_paired_cutadapt.fq.gz,${R10}_1_paired_cutadapt.fq.gz,${R11}_1_paired_cutadapt.fq.gz \
-2 ${R1}_2_paired_cutadapt.fq.gz,${R2}_2_paired_cutadapt.fq.gz,${R3}_2_paired_cutadapt.fastq.gz,${R4}_2_paired_cutadapt.fastq.gz,${R5}_2_paired_cutadapt.fastq.gz,${R6}_2_paired_cutadapt.fastq.gz,${R7}_2_paired_cutadapt.fastq.gz,${R8}_2_paired_cutadapt.fastq.gz,${R9}_2_paired_cutadapt.fq.gz,${R10}_2_paired_cutadapt.fq.gz,${R11}_2_paired_cutadapt.fq.gz \
-U ${R1}_1_unpaired_cutadapt.fq.gz,${R2}_1_unpaired_cutadapt.fq.gz,${R3}_1_unpaired_cutadapt.fastq.gz,${R4}_1_unpaired_cutadapt.fastq.gz,${R5}_1_unpaired_cutadapt.fastq.gz,${R6}_1_unpaired_cutadapt.fastq.gz,${R7}_1_unpaired_cutadapt.fastq.gz,${R8}_1_unpaired_cutadapt.fastq.gz,${R9}_1_unpaired_cutadapt.fq.gz,${R10}_1_unpaired_cutadapt.fq.gz,${R11}_1_unpaired_cutadapt.fq.gz,${R1}_2_unpaired_cutadapt.fq.gz,${R2}_2_unpaired_cutadapt.fq.gz,${R3}_2_unpaired_cutadapt.fastq.gz,${R4}_2_unpaired_cutadapt.fastq.gz,${R5}_2_unpaired_cutadapt.fastq.gz,${R6}_2_unpaired_cutadapt.fastq.gz,${R7}_2_unpaired_cutadapt.fastq.gz,${R8}_2_unpaired_cutadapt.fastq.gz,${R9}_2_unpaired_cutadapt.fq.gz,${R10}_2_unpaired_cutadapt.fq.gz,${R11}_2_unpaired_cutadapt.fq.gz \
-S Enen_hisat2.sam &&

#Convert sam output file to bam file, sorted and compressed
samtools view -@ 96 -b Enen_hisat2.sam | samtools sort -@ 90 -l 9 -o Enen_hisat2.bam