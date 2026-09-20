#!/bin/bash

#SBATCH --job-name=sfs
#SBATCH -o sfs_bysite-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=8
#SBATCH --mem=296G
#SBATCH --time=72:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load samtools
module load angsd/0.940

DIR1=/scratch/jbos/Moz_aligned_mil/beagle_contigs_caldeira2
DIR2=/scratch/jbos/Moz_aligned_mil/beagle_contigs_pemba_broad2
DIR3=/scratch/jbos/Moz_aligned_mil/saf_contigs_pemba_narrow2
DIR4=/scratch/jbos/Moz_aligned_mil/saf_contigs_wimbe2
DIR5=/scratch/jbos/Moz_aligned_mil/saf_contigs_peninsula2

OUTDIR=/scratch/jbos/Moz_aligned_mil/sfs

realSFS cat $DIR1/Acropora_moz.NC*saf.idx -outnames $DIR1/caldeira_saf
realSFS cat $DIR2/Acropora_moz.NC*saf.idx -outnames $DIR2/pemba_broad_saf
realSFS cat $DIR3/Acropora_moz.NC*saf.idx -outnames $DIR3/pemba_narrow_saf
realSFS cat $DIR4/Acropora_moz.NC*saf.idx -outnames $DIR4/wimbe_saf
realSFS cat $DIR5/Acropora_moz.NC*saf.idx -outnames $DIR5/peninsula_saf

realSFS $DIR1/caldeira_saf.saf.idx -P 8 -fold 1 > $OUTDIR/caldeira.sfs
realSFS $DIR2/pemba_broad_saf.saf.idx -P 8 -fold 1 > $OUTDIR/pemba_broad.sfs
realSFS $DIR3/pemba_narrow_saf.saf.idx -P 8 -fold 1 > $OUTDIR/pemba_narrow.sfs
realSFS $DIR4/wimbe_saf.saf.idx -P 8 -fold 1 > $OUTDIR/wimbe.sfs
realSFS $DIR5/peninsula_saf.saf.idx -P 8 -fold 1 > $OUTDIR/peninsula.sfs