#/usr/bin/env bash

##This script expects the forward sequence as mandatory input

cpus=8
echo "CPUS: $cpus"

qual=25
echo "Quality: $qual"

min_read_length=50
echo "Minimum Read Length: $min_read_length"

input_forward_pattern="../../stubdata/fastqs/*_1.fastq"
echo "INPUT PATTERN: $input_forward_pattern"

trimmed_reads_outdir="../../stubdata/trimmed_fastqs"
echo "Output Directory: $outdir"

trimmed_reports_dir="../../stubdata/fastqc_trimmed_report"
echo "Trimmed Reports Directory: "$trimmed_reports_dir
echo
echo "Trimgalore adapter trimming is ongoing now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')"
echo
count_acc=0
for input_file in $input_forward_pattern; do f=$(basename $input_file); accession=$(echo $f | sed 's/_1.fastq//');
  ((count_acc++))
  echo; \
  echo "Trimming adapters from accession Id "$count_acc": " $accession \

  trim_galore --paired $input_file ${input_file/_1/_2} -q $qual --length $min_read_length --cores $cpus --fastqc -o $trimmed_reads_outdir

  done

mkdir -pv $trimmed_reports_dir
mv -fv $trimmed_reads_outdir/*.{txt,html,zip} $trimmed_reports_dir

echo "Post-trimming Fastqc Reports have been moved to this location: "$trimmed_reports_dir
echo
echo "Trimming for all Fastq files completed successfully now, $(date +%a) $(date +'%Y-%m-%d %H:%M:%S')"
