#!/bin/bash

#SBATCH --job-name=trimming_5bp
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=mem
#SBATCH --mem=20G
#SBATCH --cpus-per-task=10

#Input files
IN1=/cluster/home/lchueca/TBG_3759_3/X204SC23011763-Z01-F001/01.RawData/ANTXOA_4_final_combined/ANTXOA_4_final_EKDL230000582-1A_HMTGCDSX5_C_1.fq.gz
IN2=/cluster/home/lchueca/TBG_3759_3/X204SC23011763-Z01-F001/01.RawData/ANTXOA_4_final_combined/ANTXOA_4_final_EKDL230000582-1A_HMTGCDSX5_C_2.fq.gz

#Output files, we have added another C to the file name (first C is for combined, and second C for cleaned, because we have trimmed 5 bp)
OUT1=/cluster/home/lchueca/TBG_3759_3/X204SC23011763-Z01-F001/01.RawData/ANTXOA_4_final_combined/ANTXOA_4_final_EKDL230000582-1A_HMTGCDSX5_C_C_1.fq.gz
OUT2=/cluster/home/lchueca/TBG_3759_3/X204SC23011763-Z01-F001/01.RawData/ANTXOA_4_final_combined/ANTXOA_4_final_EKDL230000582-1A_HMTGCDSX5_C_C_2.fq.gz

#As we have used libraries generated with Arima Hi-C library prep kit, we are going to trim 5 bases from the 5' end of both reads.
zcat ${IN1} | awk '{ if(NR%2==0) {print substr($1,6)} else {print}
}' | gzip > ${OUT1}

zcat ${IN2} | awk '{ if(NR%2==0) {print substr($1,6)} else {print}
}' | gzip > ${OUT2}
