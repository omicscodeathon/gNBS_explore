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

outdir_recal_data="../../stubdata/recal_data_out/"
recal_data_name="recal_data.table"

outdir_variantcaller="../../stubdata/variantcaller_sortedbams_bwa/"
outdir_applybsqr="../../stubdata/applybsqr_markdup/"
input_sequence_pattern=$outdir_variants$accession"*.vcf"
outdir_variants="../../stubdata/variants/"
outdir_selectvariants="../../stubdata/selectvariants/"
outfile_variants="output"

echo "Input sequence pattern: "$input_sequence_pattern
echo mkdir -pv $outdir_selectvariants
echo mkdir -pv $outdir_variantcaller
echo mkdir -pv $outdir_variants$outfile_variants
echo "Directory name for Variant Selection will be: "$outdir_variantcaller

echo 

count_acc=0
for input_bam in $input_sequence_pattern; do f=$(basename $input_bam); accession=$(echo $f | sed 's/.vcf//');
  ((count_acc++))
  echo; \
  echo "Doing Variant Selection on accession Id "$count_acc": " $accession \

##GATK SelectVariants Step:
echo gatk SelectVariants \
   -R $human_reference_fasta \
   -V $outdir_variants$outfile_variants.vcf
   --select-type-to-include SNP \
   -O $outdir_selectvariants$accession.selected.vcf

  done

  echo
  echo "GATK Select Variants successfully completed now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')"

## From the command line
## ./12_variantcaller.sh

#-----SelectVariants-----

#     gatk SelectVariants \
#     -R Homo_sapiens_assembly38.fasta \
#     -V input.vcf \
#     --select-type-to-include SNP \
#     -O output.vcf
 
#--------
#we need to create a single file with both SNPs and indels
#----- VariantFiltration---

#  gatk VariantFiltration \
#    -R reference.fasta \
#    -V input.vcf.gz \
#    -O output.vcf.gz \
#    --filter-name "my_filter" \
#    --filter-expression "AB < 0.2 || MQ0 > 50"

#---------Annotation using SnpEff----
