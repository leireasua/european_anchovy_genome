#Input file or we can put only the filename instead of the variable
IN=/cluster/home/lchueca/TBG_3759_anchovy/RNA/RNA_adult/04_trinity/busco5.5_odb10/run_actinopterygii_odb10/full_table.tsv

#Print the first column (buscos names) that are completed and copy them to this new file (complete_busco_list.tsv)
awk '$2 == "Complete" {print $1}' full_table.tsv > complete_busco_list.tsv 

#Print the first column (buscos names) that are duplicated and copy them to this new file (duplicated_busco_list0.tsv)
#As the buscos will be duplicated many times, we use uniq -d command to only print one copy of each in this new file (duplicated_busco_list.tsv)
awk '$2 == "Duplicated" {print $1}' full_table.tsv > duplicated_busco_list0.tsv && uniq -d duplicated_busco_list0.tsv duplicated_busco_list.tsv && rm duplicated_busco_list0.tsv

#Create a new file (missing_busco_list0.tsv) where the first three lines of the missing_busco_list.tsv file are deleted
tail -n +4 missing_busco_list.tsv > missing_busco_list0.tsv

blastp -num_threads 64 -query ${PRO} -db uniprot_sprot.fasta -evalue 1e-6 -max_hsps 1 -max_target_seqs 1 -outfmt 6 -out Enen_proteins.fasta.blastp

interproscan.sh -i 05_Enen_proteins.02.fasta -f tsv -iprlookup -b Enen -pa -goterms -exclappl SignalP_GRAM_NEGATIVE,SignalP_GRAM_POSITIVE -dp -cpu 96
