#/usr/bin/env bash

# This script uses fasterq-dump to download SRA accessions listed in the input accession file

cpus=24

accessions="accession99.txt"

output_dir="fastqs"

cat $accessions | xargs fasterq-dump -e $cpus --outdir $output_dir
