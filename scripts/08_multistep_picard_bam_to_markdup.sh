#!/usr/bin/env bash

cpu=24
echo "cpu:$cpu"

ram=32
echo "ram:$ram"

input_sequence_pattern="../../stubdata/sams_bwa/*.sam"
outdir_coordsort="../../stubdata/sortedbams_coord_bwa/"
outdir_namesort="../../stubdata/sortedbams_name_bwa/"
outdir_fixmate="../../stubdata/fixmatebams_bwa/"
outdir_positionsort="../../stubdata/sortedbams_position_bwa/"
outdir_markdup="../../stubdata/markdup_sortedbams_bwa/"
outdir_remdup="../../stubdata/remdup_sortedbams_bwa/"

echo "Input sequence pattern: "$input_sequence_pattern

echo
echo "Output directory for Coordinate sorting: "$outdir_coordsort
echo "Output directory for Marked Duplicates: "$outdir_markdup
echo

echo "Picard tools SAM to sorted / marked duplicates BAM file generation is ongoing now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')"
echo
mkdir -pv $outdir_coordsort
mkdir -pv $outdir_markdup
echo

count_acc=0
for input_sam in $input_sequence_pattern; do accession=$(echo $input_sam | sed 's/[^S]*//' | sed 's/.sam//');
  ((++count_acc))
  echo "processing accession Id $count_acc: " $accession; \
  echo "Output sorted BAM file will be: "$accession".coordsort.bam"; \

  PicardCommandLine SortSam \
      I=$input_sam \
      O=$outdir_coordsort$accession.coordsort.bam \
      SORT_ORDER=coordinate
  echo "Picardtools BAM to coordinate-sorted BAM process completed for $input_sam!"; \

  PicardCommandLine MarkDuplicates READ_NAME_REGEX=null \
      I=$outdir_coordsort$accession.coordsort.bam \
      O=$outdir_markdup$accession.markdup.bam \
      M=$outdir_markdup$accession.markdup_metrics.txt
  echo "Picardtools marked duplicates process for coordinate-sorted BAM $accession.coordsort.bam completed."; \

  PicardCommandLine BuildBamIndex \
      I=$outdir_markdup$accession.markdup.bam
  echo "Picardtools indexing process for marked-duplicate-sorted BAM "$accession".markdup.bam completed."; \

  echo;
  done

  echo "Picardtools multistep BAM to mark and remove duplicates from BAM files successfully completed for all BAM files now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')"

## From the command line
## ./08_multistep_picard_bam_to_markdup.sh
