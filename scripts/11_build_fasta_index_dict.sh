#!/usr/bin/env bash

# This script builds a Fasta Index and a Fasta Dictionary from a Fasta file.

cpu=24
echo "cpu:$cpu"

ram=32
echo "ram:$ram"

index_prefix="../../databases/human_index_gencode/human_index"
input_dir="../../databases/human_gencode"
assembly_fasta_file="GCA_000001405.29_GRCh38.p14_genomic_ref.fasta"

echo
echo "Index file will now be generated for fasta file: "$input_dir/$assembly_fasta_file

echo
echo "Index building is in progress ..."

echo

#The bwa index option is not for .fai file generation, bwtsw only works for long genomes (it works for the human genome)
# Note: It seems like we can't use bwa index to generate .fai from Fasta file
#bwa index -a bwtsw $input_dir/$assembly_fasta_file $index_prefix
samtools faidx $input_dir/$assembly_fasta_file

indexfile=$assembly_fasta_file.fai
echo "Index file "$indexfile" has been successfully built!"

echo
echo "Creating dictionary is in progress ..."
echo
# Creating dictionary from fasta file (Note: gatk -launch doesn't work, we had to use picard-tools)
#echo gatk -launch CreateSequenceDictionary -R $input_dir/$assembly_fasta_file

seq_dict=$(echo $assembly_fasta_file | sed 's/.fasta/.dict/')

PicardCommandLine CreateSequenceDictionary R=$input_dir/$assembly_fasta_file O=$input_dir/$seq_dict

echo "Sequence dictionary "$seq_dict" has been successfully created!"

## From the command line
## ./11_build_fasta_index_dict.sh
