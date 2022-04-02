#!/usr/bin/env bash

cpus=24
echo "CPUS: $cpus"

path_to_index_and_prefix="../../databases/human_index_gencode/human_index"
echo "PREFIX: $path_to_index_and_prefix"

forward_seq_pattern="trimmed_fastqs/*_1_val_1.fq"
echo "FORWARD SEQUENCE PATTERN: $forward_seq_pattern"

#bwa index -p $path_to_index_and_prefix $ref_genome
#echo "BWA Indexing successfully completed for $ref_genome and built in "

# prefix: human_index_gencode/human_index
mkdir -pv 02_sams
mkdir -pv 02_logs

for file in $(ls $forward_seq_pattern); do a=$(echo $file | sed 's/[^SRR]*//' | sed 's/_1_val_1.fq//');
   echo "Accession ID: "$a; \
   echo "Output SAM file: "02_sams/$a.sam; \
   echo "Output Log file: "02_logs/$a.log; \
   bwa mem -M -t $cpus $path_to_index_and_prefix $file ${file/_1_val_1.fq/_2_val_2.fq} \
   > 02_sams/$a.sam 2> 02_logs/$a.log
done

# Indexing command that we ran
# bwa index -p human_index_gencode/human_index human_gencode/GCA_000001405.29_GRCh38.p14_genomic.fna.gz
# bwa mem -M -t 1 -R "@RG\tID:COL_${INDEX}\tSM:COL_${INDEX}" human_index_gencode/human_index \
