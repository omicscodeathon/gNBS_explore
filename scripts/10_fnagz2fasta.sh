#!/usr/bin/env bash

# This script converts a zipped genome assembly (.gz) file to Fasta format

cpu=24
echo "cpu:$cpu"

ram=32
echo "ram:$ram"

echo
input_dir="../../databases/human_gencode"
input_sequence="../../databases/human_gencode/GCA_000001405.29_GRCh38.p14_genomic.fna.gz"
assembly_fasta_file="GCA_000001405.29_GRCh38.p14_genomic_ref.fasta"

echo "Input file, human genome assembly: "$input_sequence" will be re-formatted and re-written to the directory: "$input_dir
echo

echo "Genome conversion to Fasta format is in progress ..."

echo
#fastq -> fasta conversion

zcat $input_sequence > $input_dir/$assembly_fasta_file

#zcat $input_sequence | sed -n '1~4s/^@/>/p;2~4p' > $input_dir/$assembly_fasta_file

echo "Reference Fasta File created: "$input_dir/$assembly_fasta_file
echo $input_sequence" has been successfully converted to Fasta format!"

## From the command line
## ./fastq2fasta.sh
