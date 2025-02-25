#!/bin/bash
#SBATCH --job-name=ReadGroups
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=2
#SBATCH --error=Groups_%A_%a.err
#SBATCH --output=Groups_%A_%a.out
#SBATCH --mem-per-cpu=3G
#SBATCH --time=1-00:00:00
#SBATCH --array=1-4

module load java/1.8.0
module load gatk/4.2.6.1 
module load picard-tools/2.27.1  
module load samtools/1.15.1

# you want to add paths to output files so they are not in your root directory
ref="/pub/jayalaan/HW3/ref/dmel-all-chromosome-r6.13.fasta"
bamin="/pub/jayalaan/EE283/HW5/prob1/mergedbams/"
bamout="/pub/jayalaan/EE283/HW5/prob1/"
samples="/pub/jayalaan/EE283/HW3/prob4/DNAout"
prefix=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${samples}/prefixes.txt)

#dedup.bam bam files with duplicates removed
#metrics file - contain statistics about duplicates
java -jar /opt/apps/picard-tools/2.27.1/picard.jar MarkDuplicates REMOVE_DUPLICATES=true \
	I=${bamout}/RG/${prefix}.RG.bam \
	O=${bamout}/dedup/${prefix}.dedup.bam \
	M=${bamout}/dedup/${prefix}_marked_dup_metrics.txt  

#creates index for the duplicated bam file
samtools index ${bamout}/dedup/${prefix}.dedup.bam 
