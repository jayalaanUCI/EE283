#!/bin/bash
#SBATCH --job-name=DNAextract1
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=1
#SBATCH --error=DNAextract1.%A_%a.err
#SBATCH --output=DNAProb1.%A_%a.out
#SBATCH --mem-per-cpu=3G
#SBATCH --time=1-00:00:00



module load samtools/1.15.1
module load bedtools2/2.30.0


A4="/pub/jayalaan/EE283/HW3/prob4/DNAout/ADL06_3.sort.bam"
A5="/pub/jayalaan/EE283/HW3/prob4/DNAout/ADL09_1.sort.bam"
dir="/pub/jayalaan/EE283/HW4/Prob1"

interval="X:1880000-2000000"

samtools view $A4 $interval | cut -f1 > ${dir}/A4.IDs.txt
samtools view $A5 $interval | cut -f1 > ${dir}/A5.IDs.txt

#Chromosome X
samtools view $A4 | grep -f ${dir}/A4.IDs.txt |\
    awk '{if($3 == "X"){printf(">%s\n%s\n",$1,$10)}}' >${dir}/A4_X.fa

samtools view $A5 | grep -f ${dir}/A5.IDs.txt |\
    awk '{if($3 == "X"){printf(">%s\n%s\n",$1,$10)}}' >${dir}/A5_X.fa
#Elsewhere
samtools view $A4 | grep -f ${dir}/A4/A4.IDs.txt |\
    awk '{if($3 != "X"){printf(">%s\n%s\n",$1,$10)}}' >${dir}/A4_other.fa
samtools view $A5 | grep -f ${dir}/A5/A5.IDs.txt |\
    awk '{if($3 != "X"){printf(">%s\n%s\n",$1,$10)}}' >${dir}/A5_other.fa

