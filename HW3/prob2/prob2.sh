module load fastqc
module load java
module load trimmomatic/0.39

data="/pub/jayalaan/EE283/HW2/data/ATACseq"
output="/pub/jayalaan/EE283/HW3/prob2"

READ1=${data}/P004_A4_ED_2_R1.fq.gz
READ2=${data}/P004_A4_ED_2_R2.fq.gz

fastqc ${READ1} ${READ2} -o ${output}

java -jar  /opt/apps/trimmomatic/0.39/trimmomatic-0.39.jar PE -threads 4 \
	${READ1} ${READ2} \
	${output}/P004_ED_2_R1_paired.fq ${output}/P004_ED_2_R1_unpaired.fq \
	${output}/P004_ED_2_R2_paired.fq ${output}/P004_ED_2_R2_unpaired.fq \
	ILLUMINACLIP:/opt/apps/trimmomatic/0.39/adapters/NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

fastqc ${output}/P004_A4_ED_2_R1_paired.fq ${output}/P004_A4_ED_2_R2_paired.fq
