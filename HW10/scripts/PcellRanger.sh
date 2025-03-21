#!/bin/bash
#SBATCH --job-name=CellRanger
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=8
#SBATCH --error=test_%J.err
#SBATCH --output=test_%J.out
#SBATCH --mem-per-cpu=4G
#SBATCH --time=1-00:00:00

#Downloaded Data from Google Drive. Data is in /pub/jayalaan/EE283/HW10/data

module load cellranger/8.0.1

Pathogenic= "/pub/jayalaan/EE283/HW10/data/P"
Nonpathogenic= "/pub/jayalaan/EE283/HW10/data/NP"
ref= "/pub/jayalaan/EE283/HW10/data"

#For Pathogenic Samples
cellranger count --id=P --transcriptome=/pub/jayalaan/EE283/HW10/data/refdata-gex-GRCh38-2024-A --fastqs=/pub/jayalaan/EE283/HW10/data/P --sample=P --create-bam=true

#For NonPathogenic Samples
#cellranger count --id=NP --transcriptome=/pub/jayalaan/EE283/HW10/data/refdata-gex-GRCh38-2024-A --fastqs=/pub/jayalaan/EE283/HW10/data/NP --sample=NP --create-bam=true

