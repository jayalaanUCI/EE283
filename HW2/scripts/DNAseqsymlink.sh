SourceDir="/data/class/ecoevo283/public/Bioinformatics_Course/DNAseq"
DestDir="/pub/jayalaan/EE283/HW2/data"

FILES="$SourceDir/*"
for f in $FILES
do
	ff=$(basename $f)
	echo "Processing $ff file..."
	ln -s $SourceDir/$ff $DestDir/$ff
done

