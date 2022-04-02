#!/usr/bin/env bash

cpus=24
echo "CPUS: $cpus"

input_file=$1
echo "INPUT FILE: $input_file"

fastqc -t $cpus $input_file
echo "FASTQC successfully processed $input_file"

# for f in ../../*.fastq; do echo $f; ./fastqc $f; done
