#!/bin/bash
#SBATCH --job-name=deeptools
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=2
#SBATCH --mem=3GB

module load mamba/24.3.0
source /pub/jayalaan/miniforge3/envs/deeptol
mamba activate deeptols #I know I misspelled it

# Directory for indexed bam files
A4="/pub/jayalaan/EE283/HW3/prob4/DNAout/ADL06_1.sort.bam"
A5="/pub/jayalaan/EE283/HW3/prob4/DNAout/ADL09_1.sort.bam"
dir="/pub/jayalaan/EE283/HW4/Prob4"


bamCoverage -b $A4 -o ${dir}/A4_ext.bedgraph --extendReads 500 --normalizeUsing RPKM --region X:1903000:1905000 --binSize 10 --outFileFormat bedgraph
bamCoverage -b $A5 -o ${dir}/A5_ext.bedgraph --extendReads 500 --normalizeUsing RPKM --region X:1903000:1905000 --binSize 10 --outFileFormat bedgraph

# Deactivate conda environment
conda deactivate
