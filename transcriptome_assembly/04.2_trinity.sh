#!/bin/bash

#SBATCH --job-name=04.2_trinity
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=cpu
#SBATCH --mem=200G
#SBATCH --cpus-per-task=40

module load trinity/2.11.0 busco/5.5.0

#Directory with trimmed input data:
IN=/cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_ena_01/03_cutadapt
#CPUs
CPU=40
#Linage for busco analysis
LIN=/cluster/software/busco/datasets/odb10_2021_09_02/actinopterygii_odb10
#Output directory for busco results
OUT=busco5.5_odb10
#BUSCO mode
M=transcriptome

#Create soft links for the trimmed data
for i in $(find "${IN}" -name "*_paired_cutadapt.fastq.gz"); do ln -s ${i}; done

#Create the samples_file
#Define the variables
SampleA="Anchovy"
SampleA_rep1="${SampleA}_juvenil5"
SampleA_rep2="${SampleA}_testis1"
SampleA_rep3="${SampleA}_ovary1"
SampleA_rep4="${SampleA}_liver1"
R1=SRR4431660
R2=SRR4431653
R3=SRR4431649
R4=SRR4431645

# Create the tab-delimited text file
echo -e "${SampleA}\t${SampleA_rep1}\t${R1}_1_paired_cutadapt.fastq.gz\t${R1}_2_paired_cutadapt.fastq.gz" > samples_file.txt
echo -e "${SampleA}\t${SampleA_rep2}\t${R2}_1_paired_cutadapt.fastq.gz\t${R2}_2_paired_cutadapt.fastq.gz" >> samples_file.txt
echo -e "${SampleA}\t${SampleA_rep3}\t${R3}_1_paired_cutadapt.fastq.gz\t${R3}_2_paired_cutadapt.fastq.gz" >> samples_file.txt
echo -e "${SampleA}\t${SampleA_rep4}\t${R4}_1_paired_cutadapt.fastq.gz\t${R4}_2_paired_cutadapt.fastq.gz" >> samples_file.txt

# Run Trinity assembler
Trinity --seqType fq --max_memory 200G --samples_file samples_file.txt --CPU ${CPU} --output $(pwd) &&

# Run busco on the trasncriptome
busco -i $(pwd)/Trinity.fasta -l ${LIN} -c ${CPU} -o ${OUT} -m ${M} --long --offline