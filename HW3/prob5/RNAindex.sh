#!/bin/bash
#SBATCH --job-name=RNAseqIndex
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=8
#SBATCH --error=RNAseqIndex.err
#SBATCH --output=RNAseqIndex.out
#SBATCH --mem-per-cpu=4G
#SBATCH --time=1-00:00:00


module load hisat2/2.2.1
ref="/pub/jayalaan/EE283/HW3/ref/dmel-all-chromosome-r6.13.fasta "
gtf="/pub/jayalaan/EE283/HW3/ref/dmel-all-r6.13.gtf"
out="/pub/jayalaan/EE283/HW3/prob5"

python hisat2_extract_splice_sites.py $gtf > "${out}/RNAindex/dm6.ss"
python hisat2_extract_exons.py $gtf > "${out}/RNAindex/dm6.exon"
hisat2-build -p 8 --exon ${out}/RNAindex/dm6.exon --ss ${out}/RNAindex/dm6.ss $ref ${out}/RNAindex/dm6_trans
