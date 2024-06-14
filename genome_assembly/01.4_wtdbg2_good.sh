#!/bin/bash

#SBATCH --job-name=01.4_wtdbg2_prueba
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=550G
#SBATCH --cpus-per-task=64

module load wtdbg/2.5
module load minimap2/2.26
module load samtools/1.19.1

#IN1,2,3 I specified the paths of the variables

# TBG_3759
IN1=/cluster/home/lchueca/TBG_3759/01.hifi_deepconsensus/m64037e_230114_104235.deepconsensus.lima.pbmarkdup.fastq
# TBG_3759_4
IN2=/cluster/home/lchueca/TBG_3759_4/deepconsensus/m64347e_230513_102840.deepconsensus.combined.lima.pbmarkdup.fastq
# TBG_3759_6
IN3=/cluster/home/lchueca/TBG_3759_6/m84051_230814_140752_s1.hifi_reads.default.fastq
PREF=anchovy.asm
PREF2=anchovy.asm.raw.fa
PREF3=anchovy.asm.cns.fa
CPU=64

#assemble long reads
wtdbg2 -x ccs -g '1.54g' -t ${CPU} -i ${IN1} ${IN2} ${IN3} -o ${PREF}

#derive consensus
wtpoa-cns -t ${CPU} -i anchovy.asm.ctg.lay.gz -o ${PREF2} 

# polish consensus
minimap2 -t ${CPU} -ax map-pb -r2k anchovy.asm.raw.fa ${IN1} ${IN2} ${IN3} | samtools sort -@4 >anchovy.asm.bam
samtools view -F0x900 anchovy.asm.bam | wtpoa-cns -t ${CPU} -d anchovy.asm.raw.fa -i - -o ${PREF3}
