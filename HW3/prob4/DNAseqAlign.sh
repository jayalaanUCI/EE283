#!/bin/bash
#SBATCH --job-name=DNAseqAlign
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=12
#SBATCH --error=DNAseAlign.%A_%a.err
#SBATCH --output=RealDNAseqAlign.%A_%a.out
#SBATCH --mem-per-cpu=3G
#SBATCH --time=1-00:00:00
#SBATCH --output=/pub/jayalaan/EE283/HW3/prob4/DNAseq/
#SBATCH --array=1-12

module load bwa/0.7.8
module load samtools/1.15.1

files="/pub/jayalaan/EE283/HW3/prob4/prefix.txt"
prefix='head -n $SLURM_ARRAY_TASK_ID $files | tail -1 n'
data="/pub/jayalaan/EE283/HW2/data/DNAseq"
out="/pub/jayalaan/EE283/HW3/prob4/DNAout"
index="/pub/jayalaan/EE283/HW3/ref/index/bwaindex"
ref="/pub/jayalaan/EE283/HW3/ref/dmel-all-chromosome-r6.13.fasta"

bwa mem  -t $SLURM_CPUS_PER_TASK -M ${ref} ${data}/${prefix}_1.fq.gz ${data}/${prefix}_2.fq.gz | samtools view -bS - > ${out}/${prefix}.sort.bam
samtools sort - -@ $SLURM_CPUS_PER_TASK -m 4G -o ${out}/${prefix}.bam -o ${output}/${prefix}.sort.bam
samtools index ${out}/${prefix}.sort.bam

