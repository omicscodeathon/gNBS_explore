#/usr/bin/env bash

cpus=24
echo "CPUS: $cpus"

path_to_index="../../stubdata/humangenome/"
prefix_index="index_broad"
echo "INPUT FILE: "$path_to_index_and_prefix

ref_genome="../../databases/human_gencode/ref_broad/resources_broad_hg38_v0_Homo_sapiens_assembly38.fasta"
echo "REFERENCE GENOME: $ref_genome"
echo
echo "BWA Indexing is ongoing now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')"
echo
bwa index -p $path_to_index_and_prefix $ref_genome
echo
echo "Prefix is: "$prefix_index 
echo
echo "BWA Indexing for "$ref_genome" and built in "$path_to_index" successfully completed now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')" 

##Command Line
## ./05_bwa_index.sh
