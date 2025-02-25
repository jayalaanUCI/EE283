#!/bin/bash
#SBATCH --job-name=MergeBAMs
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=4
#SBATCH --error=snpsmerge_%A_%a.err
#SBATCH --output=snpsmerge_%A_%a.out
#SBATCH --mem-per-cpu=8G
#SBATCH --time=1-00:00:00
#SBATCH --array=1-4

module load java/1.8.0
module load gatk/4.2.6.1 
module load picard-tools/2.27.1  
module load samtools/1.15.1

# you want to add paths to output files so they are not in your root directory
ref="/pub/jayalaan/HW3/ref/dmel-all-chromosome-r6.13.fasta"
bamin="/pub/jayalaan/EE283/HW3/prob4/DNAout"
bamout="/pub/jayalaan/EE283/HW5/prob1/mergedbams"

#generated prefixes.txt in DNAseq RawData directory
# ls *.sort.bam | sed -E 's/_[^_]+\.sort\.bam$//' | sort -u > prefixes.txt
#get prefix for current task
prefix=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${bamin}/prefixes.txt)
reps= $(printf '%s ' ${prefix}_*.sort.bam)

#merge bam files associated with same genotype into a single sorted BAM file
samtools merge -o ${bamout}/${prefix}.bam ${bamin}/${prefix}*.sort.bam 
samtools sort -o ${bamout}/${prefix}.sort.bam ${bamout}/${prefix}.bam
