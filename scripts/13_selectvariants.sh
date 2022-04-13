#!/usr/bin/env bash

## This script performs the GATK SelectVariants step

cpu=24
echo "CPUs: $cpu"

ram=32
echo "RAM: $ram"
echo
echo "GATK SelectVariants step is ongoing now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S') ..."
echo

#Broad Institute Fasta:
human_reference_fasta="../../databases/human_gencode/ref_broad/resources_broad_hg38_v0_Homo_sapiens_assembly38.fasta"

input_sequence_pattern=$outdir_variants$accession"*.vcf"
outdir_variants="../../stubdata/variants/"
outdir_selectvariants="../../stubdata/selectvariants/"
outfile_variants="output"
outfile_selected_variants="variants"

echo "Input sequence pattern: "$input_sequence_pattern
mkdir -pv $outdir_selectvariants
echo "Directory name for Variant Selection will be: "$outdir_selectvariants
echo "Filename for Variant Selection will be: "$outdir_selectvariants$outfile_selected_variants.selected.vcf

echo

echo "GATK Select Variant Step is ongoing now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')"

##GATK SelectVariants Step:
gatk SelectVariants \
   -R $human_reference_fasta \
   -V $outdir_variants$outfile_variants.vcf \
   --select-type-to-include SNP \
   -O $outdir_selectvariants$outfile_selected_variants.selected.vcf

echo
echo "GATK Select Variants successfully completed now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')"

## From the command line
## ./12_variantcaller.sh
