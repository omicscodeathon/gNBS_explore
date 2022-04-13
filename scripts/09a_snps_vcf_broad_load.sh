#/usr/bin/env bash

cpus=24
echo "CPUS: $cpus"

base_url=""
echo "BASE URL: $base_url"

download_filename="../../databases/human_gencode/snps_vcf_files/broad/snps_homosapiens_urls2.txt"
echo "Download Filename: $download_filename"
outdir="../../databases/human_gencode/snps_vcf_files/broad/"
echo "Output Directory: $outdir"

echo
echo "Checking to make sure that the output directory already exists ..."

mkdir -pv $outdir

echo "WGET file download is ongoing now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')"
echo
for u in $(cat $download_filename); do wget -O $outdir$(basename $u) $u; 
echo "WGET successfully processed: "$u; \
done

echo
echo "WGET successfully downloaded all files now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')"

echo
#fastq -> fasta conversion
for f in $(ls $outdir*.gz); do fname=$(basename $f); knownsite=$(echo $f | sed 's/.gz//'); echo "Known site file: "$fname; 
echo $f "is a .gz file"; \
echo "Converting SNPs from .gz file to .vcf ..."; \
zcat $f  $outdir"known_sites_"$knownsite;\
echo;
done 

echo "SNPs or known sites successfully generated in as VCF!"

# Command Line
# ./11_snps_vcf_download.sh
