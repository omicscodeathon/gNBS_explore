#!/usr/bin/env bash

## This script performs the GATK SelectVariants step

cpu=24
echo "CPUs: $cpu"

ram=32
echo "RAM: $ram"
echo

#Broad Institute Fasta:
human_reference_fasta="../../databases/human_gencode/ref_broad/resources_broad_hg38_v0_Homo_sapiens_assembly38.fasta"

outdir_variants="../../stubdata/variants/"
subdir_v="vcfs"
outdir_selectvariants="../../stubdata/selectvariants/"
#outfile_variants="output"
subdir_i="indels"
subdir_s="snps"
outdir_indels=$outdir_variants$subdir_i
outdir_snps=$outdir_variants$subdir_s
input_sequence_pattern=$outdir_variants"*.vcf.gz"

echo
echo "Input sequence pattern: "$input_sequence_pattern
mkdir -pv $outdir_variants$subdir_s
mkdir -pv $outdir_variants$subdir_i
echo "Directory name for SNP Variant Selection will be: "$outdir_variants$subdir_s
echo "Directory name for Indel Variant Selection will be: "$outdir_variants$subdir_i

echo
echo "GATK SelectVariants step is ongoing now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S') ..."

count_acc=0
for input_vcf in $input_sequence_pattern; do f=$(basename $input_vcf); accession=$(echo $f | sed 's/.vcf.gz//');
  ((count_acc++))
  echo; \
  echo "Selecting Variants in accession Id "$count_acc": " $accession \
## Start selection of indels and SNPs on the VCF files. We will have an indel file and then a SNP file per sample.
## GATK SelectVariants generates .vcf and index (.vcf.idx) file for each SNP and Indel that is included in the selection.
##GATK SelectVariants Step:
gatk SelectVariants \
   -R $human_reference_fasta \
   -V $outdir_variants$accession.vcf.gz \
   --select-type-to-include SNP \
   -O $outdir_variants$subdir_s/$accession.snp.vcf

gatk SelectVariants \
   -R $human_reference_fasta \
   -V $outdir_variants$accession.vcf.gz \
   --select-type-to-include INDEL \
   -O $outdir_variants$subdir_i/$accession.indel.vcf

   done
echo
echo "GATK SelectVariants successfully completed now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')"

## From the command line
## ./13_selectvariants.sh
