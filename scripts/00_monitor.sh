#/usr/bin/env bash

cpus=24
#echo "CPUS: $cpus"

#path_to_command=$1
command="ls -lAhtr ../../databases/human_gencode/snps_vcf_files/broads/"

while [ 0 ]; do echo "processing the command: "; $command; sleep 10; done

# bwa index -p human_index_gencode/human_index human_gencode/GCA_000001405.29_GRCh38.p14_genomic.fna.gz
