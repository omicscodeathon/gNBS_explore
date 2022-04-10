#/usr/bin/env bash

cpus=24
echo "CPUS: $cpus"

path_to_index="../../stubdata/humangenome/"
prefix_index="index_broad"
echo "INPUT FILE: "$path_to_index_and_prefix

ref_genome="../../databases/human_gencode/ref_broad/resources_broad_hg38_v0_Homo_sapiens_assembly38.fasta"
echo "REFERENCE GENOME: $ref_genome"

bwa index -p $path_to_index_and_prefix $ref_genome
echo
echo "BWA Indexing successfully completed for "$ref_genome" and built in "$path_to_index
echo "Prefix is: "$prefix_index 

# bwa index -p human_index_gencode/human_index human_gencode/GCA_000001405.29_GRCh38.p14_genomic.fna.gz
