#!/usr/bin/env bash

## This script performs the GATK BaseRecalibrator step which is necessary for variant calling

cpu=24
echo "CPUs: $cpu"

ram=32
echo "RAM: $ram"

human_reference_fasta="../../databases/human_gencode/GCA_000001405.29_GRCh38.p14_genomic_ref.fasta"
#NCBI dbSNP
#This site is problematic
#knownsite_snps1="../../databases/human_gencode/snps_vcf_files/ncbi/known_sites_GCF_000001405.39.vcf"
knownsite_snps1="../../databases/human_gencode/snps_vcf_files/ncbi/known_sites_GCF_000001405.25.vcf"

#Broad Institute
knownsite_snps2="../../databases/human_gencode/snps_vcf_files/broad/resources_broad_hg38_v0_1000G_omni2.5.hg38.vcf.gz"
knownsite_snps3="../../databases/human_gencode/snps_vcf_files/broad/resources_broad_hg38_v0_1000G_phase1.snps.high_confidence.hg38.vcf.gz"
knownsite_snps4="../../databases/human_gencode/snps_vcf_files/broad/resources_broad_hg38_v0_Axiom_Exome_Plus.genotypes.all_populations.poly.hg38.vcf.gz"
knownsite_snps5="../../databases/human_gencode/snps_vcf_files/broad/resources_broad_hg38_v0_Homo_sapiens_assembly38.known_indels.vcf.gz"
knownsite_snps6="../../databases/human_gencode/snps_vcf_files/broad/resources_broad_hg38_v0_Mills_and_1000G_gold_standard.indels.hg38.vcf.gz"
knownsite_snps7="../../databases/human_gencode/snps_vcf_files/broad/resources_broad_hg38_v0_hapmap_3.3.hg38.vcf.gz"


outdir_recal_data="../../data_99/recal_data_out/"
recal_data_name="recal_data.table"

mkdir -pv $outdir_recal_data
echo "Filename for Recalibaration Data Table will be: "$outdir_recal_data$recal_data_name

outdir_remdup="../../data_99/remdup_sortedbams_bwa/"
input_sequence_pattern=$outdir_remdup"*.remdup.bam"

echo "Input sequence pattern: "$input_sequence_pattern

echo

echo "Starting GATK BaseRecalibrator step ..."

echo
for input_bam in $input_sequence_pattern; do accession=$(echo $input_bam | sed 's/[^S]*//' | sed 's/.remdup.bam//');
  echo "processing accession Id: " $accession \

##BaseRecalibrator Step:
gatk BaseRecalibrator \
   -I $outdir_remdup$accession.remdup.bam \
   -R $human_reference_fasta \
   --known-sites $knownsite_snps1 \
   --known-sites $knownsite_snps2 \
   --known-sites $knownsite_snps3 \
   --known-sites $knownsite_snps4 \
   --known-sites $knownsite_snps5 \
   --known-sites $knownsite_snps6 \
   --known-sites $knownsite_snps7 \
   -O $outdir_recal_data$recal_data_name

  echo;
  done

  echo "GATK BaseRecalibrator step successfully completed for all BAM files!"

## From the command line
## ./13_baserecalibrator.sh
