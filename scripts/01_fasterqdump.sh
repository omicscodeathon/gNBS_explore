#/usr/bin/env bash

cat accession99.txt | xargs fasterq-dump -e 24 --outdir fastqs
