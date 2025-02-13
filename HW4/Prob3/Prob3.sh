#!/bin/bash
#SBATCH --job-name=Xmap
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=2
#SBATCH --error=Xmmap3.%A_%a.err
#SBATCH --output=Xmmap.%A_%a.out
#SBATCH --mem-per-cpu=3G
#SBATCH --time=1-00:00:00


##create environment for deeptools
#mamba create -n deeptols python=3.8   I know I misspelled deeptools
#mamba activate deeptols
#mamba install deeptools


#source /pub/jayalaan/miniforge3/etc/profile.d/mamba.sh
mamba init
mamba activate deeptol
module load samtools/1.15.1
#Directory for bam files
A4="/pub/jayalaan/EE283/HW3/prob4/DNAout/ADL06_1.sort.bam"
A5="/pub/jayalaan/EE283/HW3/prob4/DNAout/ADL09_1.sort.bam"
dir="/pub/jayalaan/EE283/HW4/Prob3"

#index bam files
samtools index $A4
samtools index $A5

#run bamCoverage
bamCoverage -b $A4 -o ${dir}/A4.bedgraph --normalizeUsing RPKM --region X:1903000:1905000 --binSize 10 --outFileFormat bedgraph
bamCoverage -b $A5 -o ${dir}/A5.bedgraph --normalizeUsing RPKM --region X:1903000:1905000 --binSize 10 --outFileFormat bedgraph

mamba deactivate
