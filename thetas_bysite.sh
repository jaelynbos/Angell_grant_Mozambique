#!/bin/bash

#SBATCH --job-name=thetas
#SBATCH -o thetas-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=8
#SBATCH --mem=128G
#SBATCH --time=7:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load angsd/0.940

DIR=/scratch/jbos/Moz_aligned_mil/sfs
DIR1=/scratch/jbos/Moz_aligned_mil/beagle_contigs_caldeira
DIR2=/scratch/jbos/Moz_aligned_mil/beagle_contigs_pemba_broad
DIR3=/scratch/jbos/Moz_aligned_mil/saf_contigs_pemba_narrow
DIR4=/scratch/jbos/Moz_aligned_mil/saf_contigs_wimbe
DIR5=/scratch/jbos/Moz_aligned_mil/saf_contigs_peninsula

cd $DIR
#realSFS saf2theta $DIR1/caldeira_saf.saf.idx -P 8 -fold 1 -sfs caldeira.sfs -outname thetas_caldeira
#thetaStat do_stat thetas_caldeira.thetas.idx -outnames thetas_caldeira_all

#realSFS saf2theta $DIR2/pemba_broad_saf.saf.idx -P 8 -fold 1 -sfs pemba_broad.sfs -outname thetas_pemba_broad
#thetaStat do_stat thetas_pemba_broad.thetas.idx -outnames thetas_pemba_broad_all

#realSFS saf2theta $DIR3/pemba_narrow_saf.saf.idx -P 8 -fold 1 -sfs pemba_narrow.sfs -outname thetas_pemba_narrow
#thetaStat do_stat thetas_pemba_narrow.thetas.idx -outnames thetas_pemba_narrow_all

#realSFS saf2theta $DIR4/wimbe_saf.saf.idx -P 8 -fold 1 -sfs wimbe.sfs -outname thetas_wimbe
#thetaStat do_stat thetas_wimbe.thetas.idx -outnames thetas_wimbe

realSFS saf2theta $DIR5/peninsula_saf.saf.idx -P 8 -fold 1 -sfs peninsula.sfs -outname thetas_peninsula
thetaStat do_stat thetas_peninsula.thetas.idx -outnames thetas_peninsula