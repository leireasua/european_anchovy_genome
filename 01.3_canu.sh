#!/bin/bash

#SBATCH --job-name=01.3_canu
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=550G
#SBATCH --cpus-per-task=64

module load canu/2.2

#IN1,2,3 I specified the paths of the variables

# TBG_3759
IN1=/cluster/home/lchueca/TBG_3759/01.hifi_deepconsensus/m64037e_230114_104235.deepconsensus.lima.pbmarkdup.fastq
# TBG_3759_4
IN2=/cluster/home/lchueca/TBG_3759_4/deepconsensus/m64347e_230513_102840.deepconsensus.combined.lima.pbmarkdup.fastq
# TBG_3759_6
IN3=/cluster/home/lchueca/TBG_3759_6/m84051_230814_140752_s1.hifi_reads.default.fastq
PREF=anchovy.asm
# Output directory
OUT=/cluster/home/lchueca/TBG_3759_anchovy/01.3_canu

canu -p ${PREF} -d ${OUT} genomeSize=1.54g minInputCoverage=4 -pacbio-hifi ${IN1} ${IN2} ${IN3} 