#####duplicated_genes
library(fs)
library(tidyverse)
library(dplyr)
duplicated_genes<-read.csv("/storage/full-share/evolgen/leyla/overlapping_result/duplicated_overlapping_genes.csv")

S<-duplicated_genes[which(!duplicated_genes$duplicated==""),]

a<-nchar(gsub('[^,]','',S$duplicated))+1
df<-as.data.frame(a)
S['gene_count']<-NA
S['gene_count']<-df
S['fake_genes']<-NA
w1<-unlist(strsplit(S$duplicated, ","))
W1<-table(w1)
W1<-sort(W1, decreasing = TRUE)
W_1<-W1[1:32]
setwd("~/lastversion_gwas_analysis/PermGWAS_Scripts/fake_genes_duplicated/")
load("/storage/full-share/evolgen/results_110522.rda")
a<-1
#d:file contain the file names, trans genes, number of trans genes, column 5 has information number of trans genes, column 13
#put fake genes according to column 12: number of rel trans genes, 
for(a in 1:100){
  u<-1
  for (u in 1:nrow(S)){
    i<-sample(1:33056, S[u,5])
    S[u,6]<-as.character(paste(ara11[i,5],collapse =","))
  }
  w<-unlist(strsplit(S$fake_genes, ","))
  
  W<-table(w)
  W<-sort(W, decreasing = TRUE)
  W[1:32]
  W_<-W[1:32]
  W_<-W[1:32]
  W_<-as.matrix(W_, sep=",")
  new<-as.data.frame(W_)
  write.csv(new, file=paste( "filtered_",a,".csv", sep=""))
}
data_all <- list.files(path = "~/lastversion_gwas_analysis/PermGWAS_Scripts/fake_genes_duplicated/",  # Identify all CSV files
                       pattern = "*.csv", full.names = TRUE) %>% 
  lapply(read_csv) %>%                              # Store all files in list
  bind_rows                                         # Combine data sets into one data set 
data_all 

S_<-S[,2:6]
write.csv(a_, "~/lastversion_gwas_analysis/overlapping_result/ger_1_2.csv", row.names = FALSE)


