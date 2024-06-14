#!/bin/bash

#SBATCH --job-name=04.5_trinity
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=300G
#SBATCH --cpus-per-task=64

module load trinity/2.11.0 busco/5.5.0

#Directory with trimmed input data:
IN1=/cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_adult/03_cutadapt
IN2=/cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_ena_01/03_cutadapt
IN3=/cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_ena_02/03_cutadapt
IN4=/cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_egg_juvenil/03_cutadapt
#CPUs
CPU=64
#Linage for busco analysis
LIN=/cluster/software/busco/datasets/odb10_2021_09_02/actinopterygii_odb10
#Output directory for busco results
OUT=busco5.5_odb10
#BUSCO mode
M=transcriptome

#Create soft links for the trimmed data, same data name (fq or fastq .gz, for that the *)
for i in $(find "${IN1}" "${IN2}" "${IN3}" "${IN4}" -name "*_paired_cutadapt.*.gz"); do ln -s ${i}; done

#Create the samples_file
#Define the variables
SampleA="adult"
SampleA_rep1="${SampleA}_rep1"
SampleA_rep2="${SampleA}_rep2"
R1="Anchovis_Mix_7_EKRN23H000053-1A_HFC7MDSX7_L3"
R2="Anchovis_Mix_7_EKRN23H000053-1A_HFCCLDSX7_L4"
SampleB="ena_01"
SampleB_rep1="${SampleB}_juvenil5"
SampleB_rep2="${SampleB}_testis1"
SampleB_rep3="${SampleB}_ovary1"
SampleB_rep4="${SampleB}_liver1"
R3=SRR4431660
R4=SRR4431653
R5=SRR4431649
R6=SRR4431645
SampleC="ena_02"
SampleC_rep1="${SampleC}_muscle1"
SampleC_rep2="${SampleC}_muscle2"
R7=SRR1575626
R8=SRR1575628
SampleD="egg_juvenil"
SampleD_rep1="${SampleD}_rep1"
SampleD_rep2="${SampleD}_rep2"
SampleD_rep3="${SampleD}_rep3"
R9=BIOMAN2201_EKRO220002520-1A_HYVG3DSX3_L2
R10=BIOMAN2202_EKRO220002521-1A_H22FLDSX5_L4
R11=BIOMAN2202_EKRO220002521-1A_H25LYDSX5_L4

# Create the tab-delimited text file
echo -e "${SampleA}\t${SampleA_rep1}\t${R1}_1_paired_cutadapt.fq.gz\t${R1}_2_paired_cutadapt.fq.gz" > samples_file.txt
echo -e "${SampleA}\t${SampleA_rep2}\t${R2}_1_paired_cutadapt.fq.gz\t${R2}_2_paired_cutadapt.fq.gz" >> samples_file.txt
echo -e "${SampleB}\t${SampleB_rep1}\t${R3}_1_paired_cutadapt.fastq.gz\t${R3}_2_paired_cutadapt.fastq.gz" >> samples_file.txt
echo -e "${SampleB}\t${SampleB_rep2}\t${R4}_1_paired_cutadapt.fastq.gz\t${R4}_2_paired_cutadapt.fastq.gz" >> samples_file.txt
echo -e "${SampleB}\t${SampleB_rep3}\t${R5}_1_paired_cutadapt.fastq.gz\t${R5}_2_paired_cutadapt.fastq.gz" >> samples_file.txt
echo -e "${SampleB}\t${SampleB_rep4}\t${R6}_1_paired_cutadapt.fastq.gz\t${R6}_2_paired_cutadapt.fastq.gz" >> samples_file.txt
echo -e "${SampleC}\t${SampleC_rep1}\t${R7}_1_paired_cutadapt.fastq.gz\t${R7}_2_paired_cutadapt.fastq.gz" >> samples_file.txt
echo -e "${SampleC}\t${SampleC_rep2}\t${R8}_1_paired_cutadapt.fastq.gz\t${R8}_2_paired_cutadapt.fastq.gz" >> samples_file.txt
echo -e "${SampleD}\t${SampleD_rep1}\t${R9}_1_paired_cutadapt.fq.gz\t${R9}_2_paired_cutadapt.fq.gz" >> samples_file.txt
echo -e "${SampleD}\t${SampleD_rep2}\t${R10}_1_paired_cutadapt.fq.gz\t${R10}_2_paired_cutadapt.fq.gz" >> samples_file.txt
echo -e "${SampleD}\t${SampleD_rep3}\t${R11}_1_paired_cutadapt.fq.gz\t${R11}_2_paired_cutadapt.fq.gz" >> samples_file.txt

# Run Trinity assembler
Trinity --seqType fq --max_memory 300G --samples_file samples_file.txt --CPU ${CPU} --output $(pwd) &&

# Run busco on the trasncriptome
busco -i $(pwd)/Trinity.fasta -l ${LIN} -c ${CPU} -o ${OUT} -m ${M} --long --offline