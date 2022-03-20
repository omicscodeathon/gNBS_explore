#/usr/bin/env bash

cpus=24

accessions="accession99.txt"

output_dir="fastqs"

cat accession99.txt | xargs fasterq-dump -e $cpus --outdir $output_dir
