#!/bin/bash

#SBATCH --job-name=merge_lanes
#SBATCH --partition=256x44
#SBATCH -o merge_lanes-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=END
#SBATCH --mem=112G
#SBATCH --time=12:00:00

#Forward reads
for file1 in /home/jbos/Moz_reads/MPJB_L1/*_L002_R1_001.fastq.gz
do
    base=$(basename "$file1")
    sample="${base%_L002_R1_001.fastq.gz}"

    f1="/home/jbos/Moz_reads/MPJB_L1/${sample}_L002_R1_001.fastq.gz"
    f2="/home/jbos/Moz_reads/MPJB_L2/${sample}_L001_R1_001.fastq.gz"
    f3="/home/jbos/Moz_reads/MPJB_L3/${sample}_L002_R1_001.fastq.gz"

    cat "$f1" "$f2" "$f3" > "/home/jbos/Moz_reads/merged_lanes/${sample}_F.fastq.gz"
done

#Reverse reads

for file1 in /home/jbos/Moz_reads/MPJB_L1/*_L002_R2_001.fastq.gz
do
    base=$(basename "$file1")
    sample="${base%_L002_R2_001.fastq.gz}"

    f1="/home/jbos/Moz_reads/MPJB_L1/${sample}_L002_R2_001.fastq.gz"
    f2="/home/jbos/Moz_reads/MPJB_L2/${sample}_L001_R2_001.fastq.gz"
    f3="/home/jbos/Moz_reads/MPJB_L3/${sample}_L002_R2_001.fastq.gz"

    cat "$f1" "$f2" "$f3" > "/home/jbos/Moz_reads/merged_lanes/${sample}_R.fastq.gz"
done

mkdir /home/jbos/kelp
mv /home/jbos/Moz_reads/*M_ARYQ* /home/jbos/kelp