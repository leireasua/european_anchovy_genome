#!/bin/bash

#SBATCH --job-name=01.5_wtdbg2-racon-pilon
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=600G
#SBATCH --cpus-per-task=64

module load wtdbg2-racon-pilon/0.4-dev

#IN1,2,3 I specified the paths of the variables

# TBG_3759
IN1=/cluster/home/lchueca/TBG_3759/01.hifi_deepconsensus/m64037e_230114_104235.deepconsensus.lima.pbmarkdup.fastq
# TBG_3759_4
IN2=/cluster/home/lchueca/TBG_3759_4/deepconsensus/m64347e_230513_102840.deepconsensus.combined.lima.pbmarkdup.fastq
# TBG_3759_6
IN3=/cluster/home/lchueca/TBG_3759_6/m84051_230814_140752_s1.hifi_reads.default.fastq
# Output directory
OUT=/cluster/home/lchueca/TBG_3759_anchovy/01.5_wtdbg2

wtdbg2-racon-pilon.pl -l ${IN1} ${IN2} ${IN3} -x ccs -o ${OUT} -wtdbg-opts -g 1,54g

#In this script a wrapper created by shcellt has been used: https://github.com/schellt/wtdbg2-racon-pilon
#Moreover, in this script, wtdbg2 and 3 rounds of polishing with racon are used, polishing with pilon is also used