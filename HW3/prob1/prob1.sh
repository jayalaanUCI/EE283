module load fastqc
module load java
module load trimmomatic/0.39

data="/pub/jayalaan/EE283/HW2/data/DNAseq"
output="/pub/jayalaan/EE283/HW3/prob1"

READ1=${data}/ADL06_1_1.fq.gz
READ2=${data}/ADL06_1_2.fq.gz

fastqc ${READ1} ${READ2} -o ${output}

java -jar  /opt/apps/trimmomatic/0.39/trimmomatic-0.39.jar PE -threads 4 \
	${READ1} ${READ2} \
	${output}/ADL06_1_1.paired.fq ${output}/ADL06_1_1.unpaired.fq \
	${output}/ADL06_1_2.paired.fq ${output}/ADL06_1_2.unpaired.fq \
	ILLUMINACLIP:/opt/apps/trimmomatic/0.39/adapters/TruSeq2-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

fastqc ${output}/ADL06_1_1.paired.fq ${output}/ADL06_1_2.paired.fq -o ${output}
