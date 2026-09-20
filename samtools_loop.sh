#!/bin/bash

#SBATCH --job-name=samtools
#SBATCH -o samtools-%j.out
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --cpus-per-task=20
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=180G
#SBATCH --time=200:00:00

module load samtools 

DIR=/scratch/jbos/Moz_aligned_mil/amillepora_samfiles
OUTDIR=/scratch/jbos/Moz_aligned_mil/amillepora_bamfiles

mkdir $OUTDIR

for file in "$DIR"/*.sam
do
    sample=$(basename "$file" | cut -d. -f1)
    samtools view --threads 20 -b -F 2308 $DIR/$sample.sam \
    | samtools sort --threads 20 -o $OUTDIR/$sample.sorted.bam
    samtools index $OUTDIR/$sample.sorted.bam
done