#!/bin/bash

#SBATCH --job-name=busco_summaries
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out

#SBATCH --partition=cpu
#SBATCH --mem=1G
#SBATCH --cpus-per-task=1

module load busco/5.2.2

cp /cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_adult/04_trinity/busco5.5_odb10/short_summary.specific.actinopterygii_odb10.busco5.5_odb10.txt ./short_summary.specific.actinopterygii_odb10.RNA_adult.txt &&
cp /cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_ena_01/04_trinity/busco5.5_odb10/short_summary.specific.actinopterygii_odb10.busco5.5_odb10.txt ./short_summary.specific.actinopterygii_odb10.RNA_ena_01.txt &&
cp /cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_ena_02/04_trinity/busco5.5_odb10/short_summary.specific.actinopterygii_odb10.busco5.5_odb10.txt ./short_summary.specific.actinopterygii_odb10.RNA_ena_02.txt &&
cp /cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_egg_juvenil/04_trinity/busco5.5_odb10/short_summary.specific.actinopterygii_odb10.busco5.5_odb10.txt ./short_summary.specific.actinopterygii_odb10.RNA_egg_juvenil.txt &&

#Working directory
WD=/cluster/home/lchueca/TBG_3759_anchovy/RNA/busco_summaries

/cluster/software/busco/busco-5.2.2/scripts/generate_plot.py -wd ${WD}