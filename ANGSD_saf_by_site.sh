#!/bin/bash

#SBATCH --job-name=angsd
#SBATCH -o angsd_out/angsd_by_site-%A_%a.out
#SBATCH --cpus-per-task=2
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=180G
#SBATCH --time=720:00:00
#SBATCH --array=0-853%4
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load samtools
module load angsd/0.940

REF=/home/jbos/ncbi/GCF_013753865.1_Amil_v2.1_genomic.fna
CONTIG_LIST=/home/jbos/Moz_reads/contig_list_Amillepora.txt

SITES=/home/jbos/Moz_scripts/ANGSD_sites_invariant.txt

CONTIG=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${CONTIG_LIST})

BAMLIST_CALDEIRA=/home/jbos/Moz_reads/bam_names_caldeira.txt
OUTDIR_CALDEIRA=/scratch/jbos/Moz_aligned_mil/beagle_contigs_caldeira
#68 individuals


#Use GATK model to follow Ilha's Angell methodology

angsd -bam ${BAMLIST_CALDEIRA} \
    -GL 2 \
	-doSaf 1 \
	-doMajorMinor 2 \
	-doCounts 1 \
    -P 2 \
    -ref ${REF} \
	-anc ${REF} \
	-sites $SITES \
    -r ${CONTIG} \
    -out ${OUTDIR_CALDEIRA}/Acropora_moz.${CONTIG}
	
BAMLIST_PEMBA1=/home/jbos/Moz_reads/bam_names_pemba_broad.txt
OUTDIR_PEMBA1=/scratch/jbos/Moz_aligned_mil/beagle_contigs_pemba_broad

#166 individuals
angsd -bam ${BAMLIST_PEMBA1} \
    -GL 2 \
	-doSaf 1 \
	-doMajorMinor 2 \
	-doCounts 1 \
    -P 2 \
    -ref ${REF} \
	-anc ${REF} \
	-sites $SITES \
    -r ${CONTIG} \
    -out ${OUTDIR_PEMBA1}/Acropora_moz.${CONTIG}

BAMLIST_PEMBA2=/home/jbos/Moz_reads/bam_names_pemba_narrow.txt
OUTDIR_PEMBA2=/scratch/jbos/Moz_aligned_mil/saf_contigs_pemba_narrow

mkdir -p $OUTDIR_PEMBA2
#93 individuals
angsd -bam ${BAMLIST_PEMBA2} \
    -GL 2 \
	-doSaf 1 \
	-doMajorMinor 2 \
	-doCounts 1 \
    -P 2 \
    -ref ${REF} \
	-sites $SITES \
	-anc ${REF} \
    -r ${CONTIG} \
    -out ${OUTDIR_PEMBA2}/Acropora_moz.${CONTIG}

BAMLIST_WIMBE=/home/jbos/Moz_reads/bam_names_wimbe_da.txt
OUTDIR_WIMBE=/scratch/jbos/Moz_aligned_mil/saf_contigs_wimbe
mkdir -p $OUTDIR_WIMBE
angsd -bam ${BAMLIST_WIMBE} \
	-GL 2 \
	-doSaf 1 \
	-doCounts 1 \
	-doMajorMinor 2 \
	-P 2 \
	-ref ${REF} \
	-sites $SITES \
	-anc ${REF} \
	-r ${CONTIG} \
	-out ${OUTDIR_WIMBE}/Acropora_moz.${CONTIG}
	
BAMLIST_PENINSULA=/home/jbos/Moz_reads/bam_names_peninsula_da.txt
OUTDIR_PENINSULA=/scratch/jbos/Moz_aligned_mil/saf_contigs_peninsula
mkdir -p $OUTDIR_PENINSULA
angsd -bam ${BAMLIST_PENINSULA} \
	-GL 2 \
	-doSaf 1 \
	-doCounts 1 \
	-doMajorMinor 2 \
	-P 2 \
	-ref ${REF} \
	-sites $SITES \
	-anc ${REF} \
	-r ${CONTIG} \
	-out ${OUTDIR_PENINSULA}/Acropora_moz.${CONTIG}