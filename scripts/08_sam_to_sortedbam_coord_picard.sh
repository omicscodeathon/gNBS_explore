#/usr/bin/env bash

##This script takes SAM/BAM files as input and generates sorted BAM files

cpus=8
echo "CPUS: $cpus"

pattern="sams_bwa/*.sam"
echo "File Pattern: $pattern"

out_dir="sortedbams"
echo "Output Directory: $out_dir"

echo
for f in $pattern; do echo "Input: "$f; \
sample=$(echo $f | sed 's/[^SRR]*//' | sed 's/.sam//' );
echo "Accession ID: "$sample
#java -jar picard.jar SortSam \
picard SortSam \
 INPUT=$f \
 OUTPUT="$out_dir"/$sample.bam \
 SORT_ORDER=coordinate
echo "Output: "$out_dir/$sample.bam
echo
done

echo "Picard completely generated sorted BAMs successfully!"
