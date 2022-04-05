#!/usr/bin/env bash

cpus=24
echo "CPUS: $cpus"

prefix_url="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.29_GRCh38.p14"
echo "PREFIX URL: $prefix_url"

download_filename=$1
echo "INPUT FILENAME: $download_filename"

wget ${prefix_url}/${download_filename}
echo "WGET successfully processed $download_filename"

# for u in $(cat ../data/human_gencode/assembly_files.txt); do ./04_gencode.sh $u; done
