#!/usr/bin/env bash

## This script performs the GATK Variant Calling

cpu=32
echo "CPUs: $cpu"

ram=32
echo "RAM: $ram"
echo
echo "GATK Variant Calling step is ongoing now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S') ..."
echo

#Broad Institute Fasta:
human_reference_fasta="../../databases/human_gencode/ref_broad/resources_broad_hg38_v0_Homo_sapiens_assembly38.fasta"

outdir_recal_data="../../stubdata/recal_data_out/"
recal_data_name="recal_data.table"

outdir_variantcaller="../../stubdata/variantcaller_sortedbams_bwa/"
outdir_applybsqr="../../stubdata/applybsqr_markdup/"
input_sequence_pattern=$outdir_applybsqr"*.applybsqr.bam"
outdir_variants="../../stubdata/variants/"
outfile_variants="output"

echo "Input sequence pattern: "$input_sequence_pattern
mkdir -pv $outdir_variantcaller
mkdir -pv $outdir_variants
echo "Directory name for Variant Caller BAM files will be: "$outdir_variantcaller

echo
echo "Starting GATK Variant Calling step ..."

count_acc=0
for input_bam in $input_sequence_pattern; do f=$(basename $input_bam); accession=$(echo $f | sed 's/.applybsqr.bam//');
  ((count_acc++))
  echo; \
  echo "Doing Variant Calling on accession Id "$count_acc": " $accession \

##HaplotypeCaller Step:
gatk --java-options "-Xmx4g" HaplotypeCaller \
   -R $human_reference_fasta \
   -I $outdir_applybsqr$accession.applybsqr.bam \
   -O $outdir_variants$outfile_variants.vcf.gz \
   -bamout $outdir_variantcaller$accession.variantcall.bam \
   --native-pair-hmm-threads $cpu

  done

echo
echo "GATK is now unzipping the called variants ..."
cd $outdir_variants
gunzip $outfile_variants.vcf.gz

  echo
  echo "GATK Haplotype Caller successfully run on all sorted BAM files now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')"

## From the command line
## ./12_variantcaller.sh
## GATK HaplotypeCaller can multithread using the following argument, default integer value is 4. Specify 32 for 32 cores:
## --native-pair-hmm-threads 32
##
