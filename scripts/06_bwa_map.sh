#/usr/bin/env bash

cpus=32
echo "CPUS: $cpus"

path_to_index_and_prefix="../../stubdata/humangenome/index_broad"
echo "PREFIX: $path_to_index_and_prefix"

forward_seq_pattern="../../stubdata/trimmed_fastqs/*_1_val_1.fq"
echo "FORWARD SEQUENCE PATTERN: $forward_seq_pattern"

outdir_sams="../../stubdata/sams_bwa"
echo "SAM File Output Directory: "$outdir_sams

outdir_logs="../../stubdata/logs_bwa"
echo "Log File Output Directory: "$outdir_logs

mkdir -pv $outdir_sams
mkdir -pv $outdir_logs

echo
echo "BWA mem is mapping the reads to the reference genome now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')"
echo
#ref_genome="../../databases/human_gencode/GCA_000001405.29_GRCh38.p14_genomic.fna.gz"
#echo "REFERENCE GENOME: $ref_genome="

count_acc=0
for file in $(ls $forward_seq_pattern); do filename=$(basename $file); a=$(echo $filename | sed 's/_1_val_1.fq//'); 
   ((++count_acc))
   echo; \
   echo "Accession ID $count_acc:"$a; \
   echo "Output SAM file: "sams_bwa/$a.sam; \
   echo "Output Log file: "logs_bwa/$a.log; \
   bwa mem -M -t $cpus -R "@RG\tID:$a\tLB:lib1\tPL:ILLUMINA\tPU:unit1\tSM:$a" $path_to_index_and_prefix $file ${file/_1_val_1.fq/_2_val_2.fq} \
   > $outdir_sams/$a.sam 2> $outdir_logs/$a.log
done

echo 
echo "Mapping process completed for all Fastq files now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')"
# Mapping command that we ran
# ./06_bwa_map.sh
