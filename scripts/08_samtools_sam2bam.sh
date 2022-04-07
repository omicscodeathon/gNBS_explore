#!/usr/bin/env bash

## This script takes a SAM file as inpute and generates a BAM file by using samtools
cpu=24
echo "cpu:$cpu"

ram=32
echo "ram:$ram"

input_sequence_pattern="../../data_99/sams_bwa/*.sam"
outdir2="../../data_99/bams_bwa/"
echo "BAM directory: $outdir2"

mkdir -pv $outdir2

for f in $input_sequence_pattern; do accession=$(echo $f | sed 's/[^S]*//' | sed 's/.sam//');
  echo "processing accession Id: " $accession; \
  echo "Output BAM file will be: "$accession".bam"; \
  samtools view -@$cpu -q 10 -b -o $outdir2"$accession".bam $f; \
  echo "samtools SAM to BAM process completed for "$f"!"; \
  echo;
done

echo "samtools SAM to BAM process finally completed for all SAM files"

## From the command line
## for f in sam_dir/*.sam; do echo "processing: "${f/.sam/}; ./08_samtools_sam2bam.sh $f; done
