#/usr/bin/env bash

# This script monitors a process in a linux environment

cpus=24
#echo "CPUS: $cpus"

#path_to_command=$1
command="ls -lAhtr ../../databases/human_gencode/snps_vcf_files/broads/"

sleeptime=10

while [ 0 ]; do echo "processing the command: "; $command; sleep $sleeptime; done

# ./00_monitor.sh
