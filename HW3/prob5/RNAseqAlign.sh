#!/bin/bash
#SBATCH --job-name=RNAseqAlign
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=8
#SBATCH --error=RNAseqAlign.%A_%a.err
#SBATCH --output=RNAseqAlign.%A_%a.out
#SBATCH --mem-per-cpu=4G
#SBATCH --time=1-00:00:00
#SBATCH --array=1-12

module load hisat2/2.2.1
module load samtools/1.15.1

#To make the prefix list for a specified samples and specific tinnues E/B. I used the following sed command to create the shortlist 
#ls | sed -En '/(21148|21286|22162|21297|21029|22052|22031|21293|22378|22390)[EB]0_R1.fq.gz/p | sed -n s/_R1.fq.gz//'>/pub/jayalaan/EE283/HW3/prob5/RNAprefix.txt

files="/pub/jayalaan/EE283/HW3/prob5/RNAprefix.txt"
prefix=`head -n $SLURM_ARRAY_TASK_ID $files | tail -n 1`

data="/pub/jayalaan/EE283/HW2/data/RNAseq"
out="/pub/jayalaan/EE283/HW3/prob5/RNAout"
ref="/pub/jayalaan/EE283/HW3/prob5/RNAindex/dm6_trans"


echo $prefix

hisat2 -p 2 -x ${ref} -1 ${data}/${prefix}_R1.fq.gz -2 ${data}/${prefix}_R2.fq.gz \
| samtools sort - -@ 2 -m 4G -o ${out}/${prefix}.sort.bam

samtools index ${out/${prefix}.sort.bam
