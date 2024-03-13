#!/bin/bash

#SBATCH --job-name=01.1_hifiasm
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=cpu
#SBATCH --mem=230G
#SBATCH --cpus-per-task=96

module load hifiasm/0.19.8

# TBG_2523_3
IN1=/cluster/home/lchueca/TBG_2523_3/m64167e_220127_013751.hifi.fq
# TBG_2523_6
IN2=/cluster/home/lchueca/TBG_2523_6/m64346e_220323_230227.deepconsensus.lima.pbmarkdup.fastq
# TBG_2523_7
IN3=/cluster/home/lchueca/TBG_2523_7/hifi_reads/m64167e_220617_hifi.lima.pbmarkdup.fastq
PREF=Argo.asm
CPU=96

hifiasm -o ${PREF} -t ${CPU} ${IN1} ${IN2} ${IN3} &&

gfa2fa.sh ${PREF}.bp.p_ctg.gfa
