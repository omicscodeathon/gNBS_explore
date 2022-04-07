#!/usr/bin/env bash

cpu=24
echo "cpu:$cpu"

ram=32
echo "ram:$ram"

input_sequence_pattern="../../data_99/sortedbams_bwa/*.sort.bam"
outdir="../../data_99/indexbams_bwa/"
echo "Sorted BAM directory: $outdir"

mkdir -pv $outdir

echo "Duplicates were removed and now, the Index building process is staring!"
echo
for input_sortedbam in $input_sequence_pattern; do accession=$(echo $input_sortedbam | sed 's/[^S]*//' | sed 's/.sort.bam//');
  echo "processing accession Id: " $accession; \
  echo "Output BAM index file will be: "$accession".bam.bai"; \
  echo samtools index -@$cpu $input_sortedbam $f; \
  echo "samtools index sorted BAM process completed for $input_sortedbam"; \
  echo; \
  done

echo "samtools BAM indexing process finally completed for the entire dataset!"; \

## From the command line
## for f in bam_dir/*.sort.bam; do echo "processing: "$f; ./samtools_indexbam.sh $f; done
