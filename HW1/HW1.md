#Homework 1

Basically, used wget to download dataset from another HPC3 account. A dirctgory with 2 text files.
After decompressing and removign the original compressed file, used head and tail to cut the the 10th line and write it into to sperate files.
Lastly used cat to merge the files.

```
wget http://wfitch.bio.uci.edu/~tdlong/problem1.tar.gz
tar -xvf problem1.tar.gz
rm problem1.tar.gz

head -n 10 problem1/p.txt | tail n -1 > line10p.txt
head -n 10 problem1/f.txt | tail n -1 >line10f.txt
cat line10p.txt line10f.txt > lines10pf.txt

```

