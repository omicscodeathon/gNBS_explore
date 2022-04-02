#!/usr/bin/env bash

##This script expects the forward sequence as mandatory input

#maximum number of cores for trim_galore is 8
cpus=8
echo "CPUS: $cpus"

qual=25
echo "Quality: $qual"

min_read_length=50
echo "Minimum Read Length: $min_read_length"

input_file=$1
echo "INPUT FILE: $input_file"

outdir=$2
echo "Output Directory: $outdir"

trim_galore --paired $input_file ${input_file/_1/_2} -q $qual --length $min_read_length --cores $cpus --fastqc -o $outdir
