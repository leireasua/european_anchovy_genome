#!/bin/bash

#SBATCH --job-name=01.4_wtdbg
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=550G
#SBATCH --cpus-per-task=64

module load wtdbg/2.5

#IN1,2,3 I specified the paths of the variables

# TBG_3759
IN1=/cluster/home/lchueca/TBG_3759/01.hifi_deepconsensus/m64037e_230114_104235.deepconsensus.lima.pbmarkdup.fastq
# TBG_3759_4
IN2=/cluster/home/lchueca/TBG_3759_4/deepconsensus/m64347e_230513_102840.deepconsensus.combined.lima.pbmarkdup.fastq
# TBG_3759_6
IN3=/cluster/home/lchueca/TBG_3759_6/m84051_230814_140752_s1.hifi_reads.default.fastq
PREF=anchovy.asm
CPU=64

wtdbg2 -x ccs -g '1.54g' -t ${CPU} -i ${IN1} ${IN2} ${IN3} -o ${PREF}
