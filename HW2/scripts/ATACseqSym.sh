# Setting up symlink for ATACseq data

SourceDir="/data/class/ecoevo283/public/Bioinformatics_Course/ATACseq"
DestDir="/pub/jayalaan/EE283/HW2/data/ATACseq"

tail -n +2 ${SourceDir}/README.ATACseq.txt | head -n -3 > ${DestDir}/ATACseq.txt
File="${DestDir}/ATACseq.txt"
while read p
do
	echo "${p}"
	barcode=$(echo $p | cut -f1 -d" ")
	genotype=$(echo $p | cut -f2 -d" ")
	tissue=$(echo $p | cut -f3 -d" ")
	bioRep=$(echo $p | cut -f4 -d" ")
	READ1=$(find ${SourceDir}/ -type f -iname "*_${barcode}_R1.fq.gz")
	READ2=$(find ${SourceDir}/ -type f -iname "*_${barcode}_R2.fq.gz")

	sample="${barcode}_${genotype}_${tissue}_${bioRep}"

		for f in $READ1 $READ2
		do
			ff=$(basename $f)
			echo "Processing $ff file..."
			read=$(echo "$ff" | grep -o 'R[12]')
			ln -s $f $DestDir/${sample}_${read}.fq.gz
		done

done <  $File
