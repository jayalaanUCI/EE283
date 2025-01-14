#!/bin/bash
#SBATCH --job-name=HW1JAA
#SBATCH -A CLASS-ECOEVO283
#SBATCH -p standard
#SBATCH --cpus-per-task=1
#SBATCH --error=HW1JAA.J.err
#SBATCH --output=HW1JAA.%J.out

wget https://wfitch.bio.uci.edu/~tdlong/problem1.tar.gz
tar -xvf problem1.tar.gz
rm problem1.tar.gz

head -n 10 problem1/p.txt | tail -n 1 > line10p.txt
head -n 10 problem1/f.txt | tail -n 1 > line10f.txt
cat line10o.txt line 10f.txt > lines10pf.txt

