#!/usr/bin/env bash

## This script uses BCFtools to perform the Filtration of Variants and the Combination of SNPs and Indels per sample

cpu=24
echo "CPUs: $cpu"

ram=32
echo "RAM: $ram"
echo
echo "BCFTools FilterVariants step is ongoing now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S') ..."
echo

outdir_variants_snps="../../stubdata/variants/snps/"
outdir_variants_indels="../../stubdata/variants/indels/"
outdir_filtered_snps="../../stubdata/filteredvariants/snps/"
outdir_filtered_indels="../../stubdata/filteredvariants/indels/"
outdir_combinedvariants="../../stubdata/combinedvariants/"

input_sequence_pattern_snps=$outdir_variants_snps"*.snp.vcf"
input_sequence_pattern_indels=$outdir_variants_indels"*.indel.vcf"

input_sequence_pattern_filtered_snps=$outdir_filtered_snps"*.filtered.snp.vcf"
input_sequence_pattern_filtered_indels=$outdir_filtered_indels"*.filtered.indel.vcf"

filtered_extension_snps=".filtered.snp.vcf"
filtered_extension_indels=".filtered.indel.vcf"

## GATK SelectVariants generates .vcf and .vcf.idx file for each SNP and Indel that is included in the selection
##Filtering Conditions:
filter_extension=".filtered.vcf"
#echo line1, line2 and line3 
mkdir -pv $outdir_filtered_snps
mkdir -pv $outdir_filtered_indels
mkdir -pv $outdir_combinedvariants

echo "Input Directory for SNPs: "$outdir_variants_snps
echo "Input Directory for Indels: "$outdir_variants_indels
echo "Directory name for SNP Filtering will be: "$outdir_filtered_snps
echo "Directory name for Indel Filtering will be: "$outdir_filtered_indels
echo "Directory name for combined SNPs and Indels will be: "$outdir_combinedvariants

echo

echo "--------------------"
echo "BCFtools FilterVariants Step for SNPs is ongoing now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')"
echo "--------------------"

echo
count_acc=0
for input_vcf in $input_sequence_pattern_snps; do f=$(basename $input_vcf); accession=$(echo $f | sed 's/.snp.vcf//');
  ((++count_acc))
  echo "Now Filtering SNPs in accession Id "$count_acc": " $accession 
## Start selection of SNPs on the VCF files. We will have a SNP file per sample.
##BCFtools FilterVariants Step: successful
#echo line1, pipe line2 and redirect line3
  bcftools view --threads $cpu $input_vcf \
  | vcfutils.pl varFilter - \
  > $outdir_filtered_snps$accession$filtered_extension_snps
#  echo
  done

echo
echo "--------------------"
echo "BCFtools FilterVariants Step for indels is ongoing now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')"
echo "--------------------"
count_acc=0
for input_vcf in $input_sequence_pattern_indels; do f=$(basename $input_vcf); accession=$(echo $f | sed 's/.indel.vcf//');
  ((++count_acc))
  echo "Now Filtering Indels in accession Id "$count_acc": " $accession 
## Start selection of indels on the VCF files. We will have an indel file per sample.
##BCFtools FilterVariants Step for Indels - this section was problematic but it works now:
#echo line1, pipe line2 and redirect line3
  bcftools view --threads $cpu $input_vcf | vcfutils.pl varFilter - > $outdir_filtered_indels$accession$filtered_extension_indels
  done

echo
echo "--------------------"
echo "BCFtools ConcatenateVariants Step for SNPs and indels per sample is ongoing now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')"
echo "--------------------"
count_acc=0
for input_vcf in $input_sequence_pattern_filtered_snps; do f=$(basename $input_vcf); accession=$(echo $f | sed 's/.filtered.snp.vcf//');
  ((++count_acc))
  echo
  echo "Now Combining SNPs and Indels in accession Id "$count_acc": " $accession 
## Start selection of indels on the VCF files. We will have an indel file per sample.
##BCFtools Concatinate Variants Step:
#echo
  bcftools view --threads $cpu $input_vcf -Oz -o $input_vcf.gz
#echo
  bcftools index --threads $cpu $input_vcf.gz
#echo
  bcftools view \
  --threads $cpu \
  $outdir_filtered_indels$accession$filtered_extension_indels \
  -Oz -o $outdir_filtered_indels$accession$filtered_extension_indels.gz
#echo
  bcftools index \
  --threads $cpu \
  $outdir_filtered_indels$accession$filtered_extension_indels.gz
#echo
  bcftools concat -Ov --threads $cpu \
  -o $outdir_combinedvariants$accession.filtered.combined.vcf \
  --allow-overlaps --rm-dups both \
  $input_vcf.gz \
  $outdir_filtered_indels$accession$filtered_extension_indels.gz
  done

echo 
echo "BCFTools Variants Filtering and SNPs and Indels combination per sample successfully completed now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')"

## From the command line
## ./15_filtervariants_bcftools.sh
