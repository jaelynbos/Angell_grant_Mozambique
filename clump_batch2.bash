#!/bin/bash

#SBATCH --job-name=clmp_r12_wrap
#SBATCH -o clmp-%A_%a.out
#SBATCH -c 1
#SBATCH --exclusive=user
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --partition=lab-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --array=%1

#Pass in the maximum number of nodes to use at once
nodes=1

FQPATTERN=*r1.fq.gz
INDIR=/scratch/jbos/Moz_intermediates/trim1
OUTDIR=/scratch/jbos/Moz_intermediates/clump
TMPDIR=/scratch/jbos/Moz_intermediates/temp

SCRIPTPATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

all_samples=$(ls $INDIR/$FQPATTERN | \
	sed -e 's/r1\.fq\.gz//' -e 's/.*\///g')
all_samples=($all_samples)

echo $((${#all_samples[@]}-1))
sbatch --array=0-$((${#all_samples[@]}-1))%${nodes} $SCRIPTPATH/clumpify2.sh ${INDIR} ${OUTDIR} ${TMPDIR} ${FQPATTERN}