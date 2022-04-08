#/usr/bin/env bash

cpus=24
echo "CPUS: $cpus"

base_url="https://ftp.ncbi.nih.gov/snp/latest_release/VCF/"
echo "BASE URL: $base_url"

download_filename="../../databases/human_gencode/snps_vcf_files/snps_homosapiens_urls.txt"
echo "Download Filename: $download_filename"
outdir="../../databases/human_gencode/snps_vcf_files/"
echo "Output Directory: $outdir"

echo
echo "Checking to make sure that the output directory already exists ..."

mkdir -pv $outdir

echo
for u in $(cat $download_filename); do wget -O $outdir$u $base_url$u; 
#echo "WGET successfully processed: "$u; \
#done

echo
echo "WGET successfully downloaded all files!"

echo
#fastq -> fasta conversion
for f in $(ls $outdir*.gz); do knownsite=$(echo $f | sed 's/[^GCF]*//' | sed 's/.gz//'); echo "Known site: "$knownsite".vcf"; 

echo "Converting SNPs from .gz file to .vcf ..."; \

zcat $f > $outdir"known_sites_"$knownsite".vcf";
done 

echo "SNPs or known sites successfully generated in as VCF!"

# Command Line
# ./11_snps_vcf_download.sh
