#/usr/bin/env bash

cpus=24
echo "CPUS: $cpus"

path_to_index_and_prefix=$1
echo "INPUT FILE: $input_file"

#ref_genome="human_gencode/GCA_000001405.29_GRCh38.p14_genomic.fna.gz"
#echo "REFERENCE GENOME: $ref_genome="

#bwa index -p $path_to_index_and_prefix $ref_genome
#echo "BWA Indexing successfully completed for $ref_genome and built in "

# human_index_gencode/human_index
#mkdir -p 02_bams
#for INDEX in 1 2 3 34 35;
#do
#   bwa mem -M -t 1 -R "@RG\tID:COL_${INDEX}\tSM:COL_${INDEX}" 00_genome/Falb \
#   01_fastqs/Falb_COL${INDEX}.1.fastq.gz \
#   01_fastqs/Falb_COL${INDEX}.2.fastq.gz \
#   > 02_bams/Falb_COL${INDEX}.sam #2> Falb_COL${INDEX}.log
#done
