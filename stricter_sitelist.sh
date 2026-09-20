#!/bin/bash

#SBATCH --job-name=strict_sitelist
#SBATCH -o strict_sitelist-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=1
#SBATCH --mem=396G
#SBATCH --time=72:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load samtools
module load angsd/0.940

DIR1=/scratch/jbos/Moz_aligned_mil/beagle_contigs_caldeira
DIR2=/scratch/jbos/Moz_aligned_mil/beagle_contigs_pemba_broad
DIR3=/scratch/jbos/Moz_aligned_mil/beagle_contigs_pemba_narrow
DIR4=/scratch/jbos/Moz_aligned_mil/saf_contigs_wimbe
DIR5=/scratch/jbos/Moz_aligned_mil/saf_contigs_peninsula

# Extract positions from each population's .saf.pos.gz file
realSFS print $DIR1/caldeira_saf.saf.idx | cut -f1-2 > caldeira_positions.txt
realSFS print $DIR3/pemba_narrow_saf.saf.idx | cut -f1-2 > pemba_positions.txt
realSFS print $DIR4/wimbe_saf.saf.idx | cut -f1-2 > wimbe_positions.txt
realSFS print $DIR5/peninsula_saf.saf.idx | cut -f1-2 > peninsula_positions.txt


# Get intersection
cat caldeira_positions.txt pemba_positions.txt wimbe_positions.txt peninsula_positions.txt \
    | sort \
    | uniq -c \
    | awk '$1==4 {print $2"\t"$3}' \
    > common_sites.txt

# Index it
angsd sites index common_sites.txt