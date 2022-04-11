#!/usr/bin/env bash

## This script performs the GATK BaseRecalibrator step which is necessary for variant calling

cpu=24
echo "CPUs: $cpu"

ram=32
echo "RAM: $ram"
echo
echo "GATK ApplyBSQR step is ongoing ..."
echo

#Broad Institute Fasta:
human_reference_fasta="../../databases/human_gencode/ref_broad/resources_broad_hg38_v0_Homo_sapiens_assembly38.fasta"

outdir_recal_data="../../stubdata/recal_data_out/"
recal_data_name="recal_data.table"

outdir_markdup="../../stubdata/markdup_sortedbams_bwa/"
outdir_applybsqr="../../stubdata/applybsqr_markdup/"
output_sequence_pattern=$outdir_applybsqr"*.applybsqr.bam"
input_sequence_pattern=$outdir_markdup"*.markdup.bam"

echo "Input sequence pattern: "$input_sequence_pattern
echo mkdir -pv $outdir_applybsqr
echo "Directory name for ApplyRecalibration BAM files will be: "$outdir_applybsqr

echo
echo "Starting GATK Base Quality Score Recalibrator step ..."

count_acc=0
for input_bam in $input_sequence_pattern; do f=$(basename $input_bam); accession=$(echo $f | sed 's/.markdup.bam//');
  ((count_acc++))
  echo; \
  echo "Applying Base Quality Score Recalibration on accession Id "$count_acc": " $accession \

##BaseQualityScore ApplyRecalibrator Step:
echo gatk ApplyBQSR \
   -R $human_reference_fasta \
   -I $outdir_markdup$accession.markdup.bam \
   --bqsr-recal-file $outdir_recal_data$recal_data_name \
   -O $outdir_applybsqr$accession.applybsqr.bam

  done

  echo
  echo "GATK Apply BaseQualityScoreRecalibrator step successfully completed for all BAM files!"

## From the command line
## ./11_applybsqr.sh
