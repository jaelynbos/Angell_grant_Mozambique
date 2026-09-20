#!/bin/bash

FQPATTERN="*_fp2_r1.fq.gz"
INDIR=/scratch/jbos/Moz_intermediates/repaired/
OUTDIR=/scratch/jbos/Moz_aligned_mil/amillepora_samfiles/
REF=/home/jbos/ncbi/GCF_013753865.1_Amil_v2.1_genomic.fna
SCRIPT=/home/jbos/Moz_scripts/bwa_amillepora.sh
NODES=4

module load ohpc 
module load bwa-mem2

all_samples=($INDIR/$FQPATTERN)
n=$((${#all_samples[@]} - 1))
echo "Submitting array job with indices 0-${n}"

sbatch \
  --job-name=bwamem \
  --array=0-${n}%${NODES} \
  $SCRIPT