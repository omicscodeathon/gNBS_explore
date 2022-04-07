#!/usr/bin/env bash

cpu=24
echo "cpu:$cpu"

ram=32
echo "ram:$ram"

input_sequence_pattern="../../data_99/bams_bwa/*.bam"
outdir_coordsort="../../data_99/sortedbams_coord_bwa/"
outdir_namesort="../../data_99/sortedbams_name_bwa/"
outdir_fixmate="../../data_99/fixmatebams_bwa/"
outdir_positionsort="../../data_99/sortedbams_position_bwa/"
outdir_markdup="../../data_99/markdup_sortedbams_bwa/"
outdir_remdup="../../data_99/remdup_sortedbams_bwa/"

echo "Input sequence pattern: "$input_sequence_pattern

echo
echo "Output directory for Coordinate sorting: "$outdir_coordsort
echo "Output directory for Name sorting: "$outdir_namesort
echo "Output directory for fixmate BAMs: "$outdir_fixmate
echo "Output directory Position sorting: "$outdir_positionsort
echo "Output directory for Marked Duplicates: "$outdir_markdup
echo "Output directory for Removed Duplicates: "$outdir_remdup
echo

mkdir -pv $outdir_coordsort
mkdir -pv $outdir_namesort
mkdir -pv $outdir_fixmate
mkdir -pv $outdir_positionsort
mkdir -pv $outdir_markdup
mkdir -pv $outdir_remdup
echo

for input_bam in $input_sequence_pattern; do accession=$(echo $input_bam | sed 's/[^S]*//' | sed 's/.bam//');
  echo "processing accession Id: " $accession; \
  echo "Output sorted BAM file will be: "$accession".sort.bam"; \

  #samtools sort -@$cpu -O BAM -o $outdir_coordsort$accession.coordsort.bam $input_bam; \
  echo "samtools BAM to coordinate-sorted BAM process completed for $input_bam!"; \

  samtools sort -@$cpu -O BAM -n -o $outdir_namesort$accession.namesort.bam $input_bam; \
  echo "samtools BAM to name-sorted BAM process completed for $input_bam!"; \

  samtools fixmate -@$cpu -O BAM -m $outdir_namesort$accession.namesort.bam $outdir_fixmate$accession.fixmate.bam; \
  echo "samtools added ms and MC tags for markduplicates process to use later."; \

#fixmate is working!
  samtools sort -@$cpu -O BAM -o $outdir_positionsort$accession.positionsort.bam $outdir_fixmate$accession.fixmate.bam; \
  echo "samtools sorted the (fixmate) BAM $accession.fixmate.bam by position for markduplicates to use later."; \

  samtools markdup -@$cpu $outdir_positionsort$accession.positionsort.bam $outdir_markdup$accession.markdup.bam; \
  echo "samtools marked duplicates process for position-sorted BAM $accession.positionsort.bam completed."; \

#remove duplicate has no file
  samtools markdup -@$cpu -r $outdir_markdup$accession.markdup.bam $outdir_remdup$accession.remdup.bam; \
  echo "samtools remove duplicates process for BAM file $accession.markdup.bam completed."; \

  echo;
  done

  echo "samtools multistep BAM to mark and remove duplicates from BAM files successfully completed for all BAM files!"

## From the command line
## for f in bam_dir/*.bam; do echo "processing: "$f; ./samtools_bam2sortedbam.sh $f; done
