#!/bin/bash

#SBATCH --job-name=fastp
#SBATCH -o fastp_1st_-%j.out
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=12
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=200G
#SBATCH --partition=lab-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky

# this script will do all trimming, except 5'
# no merging of overlapping reads
# this is first step in prepping reads for de novo assembly

module load fastp

INDIR=/home/jbos/Moz_reads/merged_lanes            
OUTDIR=/scratch/jbos/Moz_intermediates/trim1
FQPATTERN=*.fastq.gz
EXTPATTERN=[FR]\.fastq\.gz
FWDEXT=F.fastq.gz
REVEXT=R.fastq.gz
THREADS=12 #1/2 of total threads avail

#mkdir $OUTDIR $OUTDIR/failed

ls $INDIR/$FQPATTERN | \
	sed -e "s/$EXTPATTERN//" -e 's/.*\///g' | \
	uniq | \
	parallel --no-notice -j $THREADS \
	fastp \
		--in1 $INDIR/{}$FWDEXT \
		--in2 $INDIR/{}$REVEXT \
		--out1 $OUTDIR/{}r1.fq.gz \
		--out2 $OUTDIR/{}r2.fq.gz \
		--unpaired1 $OUTDIR/failed/{}unprd.fq.gz \
		--unpaired2 $OUTDIR/failed/{}unprd.fq.gz \
		--failed_out $OUTDIR/failed/{}fail.fq.gz \
		-h $OUTDIR/{}fastp.html \
		-j $OUTDIR/{}fastp.json \
		--qualified_quality_phred 20 \
		--unqualified_percent_limit 40 \
		--length_required 33 \
		--low_complexity_filter \
		--complexity_threshold 30 \
		--detect_adapter_for_pe \
		--adapter_sequence=CTGTCTCTTATACACATCT \
		--adapter_sequence_r2=CTGTCTCTTATACACATCT \
		--cut_tail \
		--cut_tail_window_size 1 \
		--cut_tail_mean_quality 20 \
		--trim_poly_g \
		--poly_g_min_len 10 \
		--trim_poly_x \
		--dedup\
		--report_title "First Trim 4 De Novo" 

module load multiqc

multiqc $OUTDIR -n $OUTDIR/1st_fastp_report --interactive
multiqc -v -p -ip -f --data-dir --data-format tsv --cl-config "max_table_rows: 3000" --filename 1st_fastp_report --outdir $OUTDIR $OUTDIR
