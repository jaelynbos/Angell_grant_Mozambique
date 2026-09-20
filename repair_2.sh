#!/bin/bash

#SBATCH --job-name=bb_repair
#SBATCH -o bb_repair-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=16
#SBATCH --mem=180G
#SBATCH --partition=lab-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --time=48:00:00

#Required software: bbtools
module load bbtools 

for file1 in $(ls -v /scratch/jbos/Moz_intermediates/trim2/*fp2_r1.fq.gz)
do
	name1=$(basename "$file1")
	name1="${name1%_fp2_r1.fq.gz}"
	repair.sh in1=/scratch/jbos/Moz_intermediates/trim2/${name1}_fp2_r1.fq.gz in2=/scratch/jbos/Moz_intermediates/trim2/${name1}_fp2_r2.fq.gz out1=/scratch/jbos/Moz_intermediates/repaired/${name1}_fp2_r1.fq.gz out2=/scratch/jbos/Moz_intermediates/repaired/${name1}_fp2_r2.fq.gz outs=/scratch/jbos/Moz_intermediates/repaired/singletons2/${name1}.fq repair
done
