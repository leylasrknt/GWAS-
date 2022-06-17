%%R
##filtering overlapping genes in 10 kb window
library(tidyverse)
SNPs<-read.csv('~/lastversion_gwas_analysis/SNPs_11_10.csv')
ara11<-read.csv("~/lastversion_gwas_analysis/ara11_50.csv")
small_gene<-pd.read_csv("~/lastversion_gwas_analysis/Over_Occ/Small_gene.csv")

A<-read.csv('~/lastversion_gwas_analysis/f95_bonf/trans_filtered_hits.csv')
S<-A[,1:5]
S$gens_trans<-NA
S$gens_trans_10kb<-NA

####apply all files see if it is any pattern
setwd("~/lastversion_gwas_analysis/Over_Occ/trans_hits/")
Trans <- list()
csvfiles<-list.files(pattern = "*filtered_")
Trans <- lapply(csvfiles, function(x) {
  file <- read.csv(x)
  return(file)
})

for (i in 1:length((csvfiles))){
  Z<-merge(Trans[[i]][,c(4,9)],SNPs[,c(5,17,18)],by='SNP')
  S[i,6]<-paste(as.character(na.omit(unique(Z$gene_ara11))),collapse=',')
  S[i,7]<-paste(unique(unlist(strsplit(as.character(na.omit(unique(Z$genes_10kb__ara11))),split=','))),collapse=',')
  cat(i,'\n')
}

a<-nchar(gsub('[^,]','',S$gens_trans))+1
df<-as.data.frame(a)
S['gene_count']<-NA
S['gene_count']<-df
write.csv(S, "~/lastversion_gwas_analysis/overlapping_result/overlapping_genes.csv")
b<-S[duplicated(S$gens_trans),]
c<-overlapping_genes[duplicated(overlapping_genes$gens_trans_10kb),]
d<-overlapping_genes[duplicated(overlapping_genes$gens_trans) & duplicated(overlapping_genes$gens_trans_10kb),]
