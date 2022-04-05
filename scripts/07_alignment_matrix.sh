#/usr/bin/env bash

##This script generates stats from samtools SAM/BAM file

cpus=8
echo "CPUS: $cpus"

pattern="sams_bwa/*.sam"
echo "File Pattern: $pattern"

out_dir="samstats"
echo "Output Directory: $out_dir"

matrix_out="$matrix_out"
echo "Alignment Matrix Output Dir from MultiQC: $out_dir"

echo
for f in $pattern; do echo $f; \
sample=$(echo $f | sed 's/[^SRR]*//' | sed 's/.sam//' );
echo "Accession ID: "$sample
samtools stats $f > $out_dir/${sample}.txt
done

echo
echo "samtools completely generated stats successfully!"

cd $matrix_out
multiqc ../$out_dir/

echo
echo "MultiQC completely generated stats successfully!"
