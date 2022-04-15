#/usr/bin/env bash
# This script uses BCFtools to generate the stats from VCF files

cpus=32
echo "CPUS: "$cpus

echo
echo "BCF tools stats generation step is ongoing now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S') ..."
echo

path_to_vcf="../../stubdata/variants/*.vcf.gz"
outdir_variants="../../stubdata/variants/"
datadir="../../stubdata/"
bcfdir="vcfstats"
multiqc_vcfstats="multiqc_vcfstats"


mkdir -pv $outdir_variants$bcfdir

echo "Pattern for input files: "$path_to_vcf

count_acc=0
for file in $(ls $path_to_vcf); do filename=$(basename $file); a=$(echo $filename | sed 's/.vcf.gz//'); 
   ((++count_acc))
   echo; \
   echo "BCFtools is now generating stats for accession ID $count_acc:"$a; \
   bcftools stats -c indels -c snps $file > $outdir_variants$bcfdir/$a"_vcfstats.txt" 2> $outdir_variants$bcfdir/$a"_vcfstats.log"
done

echo
mkdir -pv $datadir$multiqc_vcfstats
cd $datadir$multiqc_vcfstats
echo "Now generating MultiQC reports from the VCF stats"
multiqc $outdir_variants$bcfdir

echo 
echo "The stats for all VCF files have been generated now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')" 
