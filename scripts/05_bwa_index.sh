#/usr/bin/env bash

cpus=24
echo "CPUS: $cpus"

path_to_index_and_prefix=$1
echo "INPUT FILE: $input_file"

ref_genome="human_gencode/GCA_000001405.29_GRCh38.p14_genomic.fna.gz"
echo "REFERENCE GENOME: $ref_genome="

bwa index -p $path_to_index_and_prefix $ref_genome
echo "BWA Indexing successfully completed for $ref_genome and built in "

# bwa index -p human_index_gencode/human_index human_gencode/GCA_000001405.29_GRCh38.p14_genomic.fna.gz
