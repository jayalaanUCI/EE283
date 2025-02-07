#!/bin/bash
#SBATCH --job-name=ATAcseqAlign
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=8
#SBATCH --error=ATACseqAlign.%A_%a.err
#SBATCH --output=ATACseqAlign.%A_%a.out
#SBATCH --mem-per-cpu=4G
#SBATCH --time=1-00:00:00
#SBATCH --array=1-12

module load bwa/0.7.8
module load samtools/1.15.1

files="/pub/jayalaan/EE283/HW3/prob4/prefix.txt"
prefix=`head -n $SLURM_ARRAY_TASK_ID $files | tail -n 1`

data="/pub/jayalaan/EE283/HW2/data/DNAseq"
out="/pub/jayalaan/EE283/HW3/prob4/DNAout"
ref="/pub/jayalaan/EE283/HW3/ref/dmel-all-chromosome-r6.13.fasta"
THREADS=8

echo $prefix

bwa mem -t $THREADS $ref ${data}/${prefix}_1.fq.gz ${data}/${prefix}_2.fq.gz | samtools sort - -@ $THREADS -m 4G -o ${out}/${prefix}.sort.bam

