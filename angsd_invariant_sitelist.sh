#!/bin/bash
#SBATCH --job-name=angsd_invariant_getsites
#SBATCH -o angsd_out/angsd_sites-%A_%a.out
#SBATCH --cpus-per-task=2
#SBATCH --mem=32G
#SBATCH --time=48:00:00
#SBATCH --array=0-14%14
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load samtools
module load angsd/0.940

REF=/home/jbos/ncbi/GCF_013753865.1_Amil_v2.1_genomic.fna
CONTIG_LIST=/home/jbos/Moz_reads/contig_list_Amillepora.txt
CONTIG=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${CONTIG_LIST})

BAMLIST_ALL=/home/jbos/Moz_reads/bam_names_grp137_noclones.txt   # cat of all three lists
OUTDIR=/scratch/jbos/Moz_aligned_mil/invariant_sites

mkdir -p $OUTDIR

MINDEPTH=$(( $(wc -l < $BAMLIST_ALL) * 5 ))
MAXDEPTH=$(( $(wc -l < $BAMLIST_ALL) * 150 ))
MININD=$(( $(wc -l < $BAMLIST_ALL) * 9 / 10 ))

angsd -bam ${BAMLIST_ALL} \
    -doCounts 1 -doDepth 1 -dumpCounts 2 \
    -minMapQ 25 -minQ 30 \
    -minInd $MININD \
    -setMinDepth $MINDEPTH -setMaxDepth $MAXDEPTH \
    -P 2 \
    -ref ${REF} \
    -r ${CONTIG} \
    -out ${OUTDIR}/pooled.${CONTIG}