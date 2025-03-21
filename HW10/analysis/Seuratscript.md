# Seurat Analysis of scRNAseq of Pathogenic vs NonPathogenic Th17 skewing conditions
## Cell Ranger Code to produce mtx files

## Seurat Analysis
### Preliminary R files
In Bash:
```
cd /pub/jayalaan/EE283/HW10/analysis/
mkdir data
mkdir figures
```
In Rstudio, because I could not get the high mem partision on the HPC with the class account and I do not have an account.

```
library(tidyverse)
library(dplyr)
library(Matrix)
library(ggplot2)
library(Seurat)
library(glmGamPoi)
rm(list = ls())

#Save data paths
data_path <- "data/"
fig_path <- "figures/"

#convenient functions

SaveFigure <- function(plots, name, type = "png", width, height, res){
        if(type == "png"){
                png(paste0(fig_path, name, ".",type),
                width = width, height = height, units= "in", res = 200)
                } else {
                pdf(paste0(fig_path, name, ".", type),
                width = width, height = height)
                }
        print(plots)
        dev.off()
        }

SaveObject <- function(object, name) {
        saveRDS(object, paste0(data_path, name, ".RDS"))
        }

ReadObject <- function(name){
  readRDS(paste0(data_path, name, ".RDS"))
}

#EndPrelim.R
```
### Install Packages is not already installed
```
install.packages("Seurat")  
if (!requireNamespace("BiocManager", quietly = TRUE))  
   install.packages("BiocManager")  
BiocManager::install("glmGamPoi")  
install.packages('devtools') 
devtools::install_github('immunogenomics/presto')
```
Ran prelimR.
```
source("prelim.R")

counts = readMM("analysis/data/NP/NP.matrix.mtx.gz")
barcodes = read.table("analysis/data/NP/NP.matrix.mtx.gz.barcodes.tsv.gz", stringsAsFactors=F)[,1]
features = read.csv("analysis/data/NP/NP.features.tsv.gz", stringsAsFactors=F, sep="\t", header=F)

rownames(counts) = make.unique(unlist(features[,2]))
colnames(counts) = barcodes

NP = CreateSeuratObject(counts, project = "NP")
head(NP@meta.data)
head(colnames(NP))

counts = readMM("analysis/data/NP/P.matrix.mtx.gz")
barcodes = read.table("analysis/data/P/P.barcodes.tsv.gz", stringsAsFactors=F)[,1]

features = read.csv("analysis/data/P/P.features.tsv.gz", stringsAsFactors=F, sep="\t", header=F)

rownames(counts) = make.unique(unlist(features[,2]))
colnames(counts) = barcodes

P = CreateSeuratObject(counts, project = "P")
head(P@meta.data)
head(colnames(P))
```



