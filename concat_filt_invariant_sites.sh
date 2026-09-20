#!/bin/bash
#SBATCH --job-name=sites_filt_all
#SBATCH -o sites_filt.out
#SBATCH --cpus-per-task=2
#SBATCH --mem=32G
#SBATCH --time=48:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load angsd/0.940

CONTIG_LIST=/home/jbos/Moz_scripts/chrom_list_Amillepora.txt
OUTDIR=/scratch/jbos/Moz_aligned_mil/invariant_sites

POS_OUT=${OUTDIR}/pooled_all.pos.gz

FIRST=1
while read -r CONTIG; do
    POS_FILE=${OUTDIR}/pooled.${CONTIG}.pos.gz
    COUNTS_FILE=${OUTDIR}/pooled.${CONTIG}.counts.gz

    if [[ $FIRST -eq 1 ]]; then
        cat ${POS_FILE} >> ${POS_OUT}
        FIRST=0
    else
        zcat ${POS_FILE} | tail -n +2 | gzip >> ${POS_OUT}
    fi
done < ${CONTIG_LIST}

zcat $POS_OUT | tail -n +2 | awk '{print $1"\t"$2}' > ANGSD_sites_invariant.txt
angsd sites index ANGSD_sites_invariant.txt