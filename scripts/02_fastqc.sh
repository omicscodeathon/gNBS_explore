#/usr/bin/env bash

##This script expects a Fastq file (supplied from the command line) and performs quality control on it.
## Dependencies: Fastqc

cpus=24
echo "CPUS: $cpus"

input_file=$1
echo "INPUT FILE: $input_file"
echo
echo "FASTQC process is ongoing now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')"
echo

fastqc -t $cpus $input_file
echo "FASTQC successfully processed $input_file"

echo
echo "FASTQC successfully processed all files now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')"
