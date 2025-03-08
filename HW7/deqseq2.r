#installed Deqseq2:
# if (!require("BiocManager", quietly = TRUE))
#    install.packages("BiocManager")
#BiocManager::install("DESeq2")

library("tidyverse")
library("DESeq2")
library("cowplot")

sampleInfo = read.table("shortRNAseq.txt")
sampleInfo$FullSampleName = as.character(sampleInfo$FullSampleName)

countdata = read.table("fly_counts.txt", header=TRUE, row.names=1)

countdata = countdata[ ,6:ncol(countdata)]
#clean up data
temp = colnames(countdata)
temp = gsub("X.pub.jayalaan.EE283.prob5.RNAout.RNAseq.bam.","",temp)
temp = gsub(".sort.bam","",temp)
colnames(countdata) = temp

cbind(temp,sampleInfo$FullSampleName,temp == sampleInfo$FullSampleName)

#Deseq objects

dds = DESeqDataSetFromMatrix(countData=countdata, colData=sampleInfo, design=~TissueCode)
dds <- DESeq(dds)
res <- results(  dds )
res

plotMA( res, ylim = c(-1, 1))
plotDispEsts( dds )
hist( res$pvalue, breaks=20, col="grey" )
#filter out lowly expressed genes?
head(res$pvalue)

#external annotation to gene IDs and log transform
BiocManager::install("biomaRt")
library(biomaRt)

rld = rlog( dds )

head( assay(rld) )
mydata= assay(rld)

sampleDist = dist( t( assay(rld) )

sampleDistMatrix = as.matrix( sampleDist )
rownames(sampleDistMatrix = rld$TissueCode
colnames(sampleDistMatrix) = NULL
library( "gplots" )
library( "RColorBrewer" )
colours = colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
heatmap.2( sampleDistMatrix, trace="none", col=colours)

#PCs
print( plotPCA( rld, intgroup = "TissueCode") )
#Heatmap
BiocManager::install("genefilter")
library( "genefilter" )

# these are the top genes (that tell tissue apart no doubt)
topVarGenes <- head( order( rowVars( assay(rld) ), decreasing=TRUE ), 35 )
heatmap.2( assay(rld)[ topVarGenes, ], scale="row", trace="none", dendrogram="column", col = colorRampPalette( rev(brewer.pal(9, "RdBu")) )(255))

#Volcano Plot
BiocManager::install("EnhancedVolcano")
library("EnhancedVolcano")

 EnhancedVolcano(res,
    lab = rownames(res),
    x = 'log2FoldChange',
    y = 'pvalue'
