# Mozambique _Acropora_ multi scale genetic variation
This repo uses Illumina short read whole genome sequences from samples of _Acropora aff. divaricata_ corals to examine spatial variation in genetic diversity. 

The README is organized into four sections: \
A) Data sources \
B) Required software \
C) Bioninformatic pre-processing for all samples \
D) Genetic diversity analysis 

All pre-processing, mapping, and  analysis was run on the University of California's high performance computing cluster 'Elkhorn' (https://its.ucsc.edu/services/research-computing/research-specific-computing-and-applications/elkhorn-high-performance-computing-cluster/)

## Data availability
Reads from Mozambique are not publicly available at this time, pending publication and approval from the Mozambican government.\
Backups of raw reads are stored on UCSC data storage server 'Bishop' in three directories called MPJB_L1, MPJB_L2, and MPJB_L3, corresponding to three Illumina NovaSeqX sequencing lanes. Metadata is available through LIMS. Do not use data from this project without first contacting Jaelyn due to stringent permitting requirements.

The _Acropora millepora_ reference genome was downloaded from NCBI, at https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_013753865.1/, GenBank assembly GCA_013753865.1 

## Required software
Fastp version 0.23.4. https://github.com/opengene/fastp \
Multiqc version 1.27. https://seqera.io/multiqc/  \
GNU Parallel version 20200122. https://www.gnu.org/software/parallel/ \
BBtools version 39.06. https://archive.jgi.doe.gov/data-and-tools/software-tools/bbtools/ \
BWA-mem version  0.7.17. https://bio-bwa.sourceforge.net/ \
SAMtools version 1.20. https://github.com/samtools/samtools \
GNU Datamash version 1.9. https://www.gnu.org/software/datamash/ \
ANGSD version 0.940 https://www.popgen.dk/angsd/index.php/ANGSD \
R version 4.3.3 

## Bioinformatic pre-processing
Samples from Mozambique were pooled and sequenced across three different lanes. Reads on the storage server are de-multiplexed, but not merged across lanes. The three lane directories can be downloaded from the storage server at the beginning of this pipeline - here they are stored in a higher level directory called Moz_reads. 

Bioinformatic processing should be conducted using the following scripts in order: 

1.1 Merge reads across lanes (forward and reverse reads separately) using lane_merge.sh. Note that this script also has a line to remove _Macrocystis_ reads from a different project that were sequenced on the same lanes. \
1.2 First trim using trim_funcs.sh. Requires: Fastp, Parallel, and Multiqc. \
1.3 Deduplicate using clump_batch2.bash to run clumpify2.sh. Requires: Clumpify (from BBtools). \
1.4 Second trim using trim_funcs2.sh. Requires: Fastp, Parallel, and Multiqc. \
1.5 Re-pair unpaired reads using repair_2.sh. Requires: BBtools. \
1.6 Map genes to _Acropora_millepora_ reference using bwa_array.bash to run bwa_amillepora.sh. Requires: BWA. \
1.7 Sort and index SAMfiles and convert to BAMfiles with samtools_loop.sh Requires: SAMtools. 

## Data analysis
This needs to be done in two rounds, in order to find loci that are usable in all populations, then compute diversity metrics using those loci. 

2.1 Make initial list of loci for all samples using angsd_invariant_sitelist.sh. Concatenate that list with concat_filt_invariant_sites.sh. Note that the resulting list includes both variant and invariant sites! \
2.2 Make site allele frequency (.saf) files with ANGSD_saf_by_site.sh. \
2.3 Concatenate those .saf files with sfs_by_site.sh \
2.4 Use the concatenated .saf files to create a better list of loci using stricter_sitelist.sh \
2.5 Re-run ANGSD using ANGSD_saf_by_site2.sh. \
2.6 Concatenate those .saf files and create site frequency spectra with sfs_by_site2.sh \
2.7 Calculate a variety of diversity metrics by chromosome with thetas_bysite.sh \
2.8 Do final per-population calculations of pi, Watterson's theta, and Tajima's D with Angell_calcs.R 
