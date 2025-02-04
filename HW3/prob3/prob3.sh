#!/bin/bash
#SBATCH --job-name=prob3_index  
#SBATCH -A CLASS-ECOEVO283
#SBATCH --cpus-per-task 8
#SBATCH --mem=16gb
#SBATCH --output=/pub/jayalaan/EE283/HW3/prob3/HW3_prob3-%J.log

module load picard-tools/2.27.1
module load bwa/0.7.8
module load samtools/1.15.1

ref="/pub/jayalaan/EE283/HW3/ref/dmel-all-chromosome-r6.13.fasta"

bwa index ${ref} 
samtools faidx $ref
java -jar /opt/apps/picard-tools/2.27.1/picard.jar\
CreateSequenceDictionary R=$ref O='/pub/jayalaan/EE283/HW3/ref/dm6.r6.dict'
