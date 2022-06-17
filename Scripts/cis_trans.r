#i <- as.numeric(Sys.getenv("SLURM_ARRAY_TASK_ID"))
library(tidyverse)
library(fs)
library(readxl)
setwd("~/lastversion_gwas_analysis/PermGWAS_Scripts/maf_filtered/")
ara11<-read.csv("~/lastversion_gwas_analysis/ara11_50.csv")
load("~/lastversion_gwas_analysis/tair10.rda")
small_gene<-read_excel("~/lastversion_gwas_analysis/Over_Occ/stringent_hits.xlsx")
setwd("~/lastversion_gwas_analysis/PermGWAS_Scripts/MAC_filtered/")

Y <- list()
csvfiles<-list.files(pattern = "*filtered_")
Y <- lapply(csvfiles, function(x) {
  file <- read.csv(x)
  return(file)
})
###number of cis hits counted for each file
new_list<-list()
for (i in 1:length((csvfiles))){
  b<-ara11[which(ara11$Gene==small_gene$...3[i]),]
  c<-sum(b$Start<Y[[i]][["POS"]] & Y[[i]][["POS"]]<b$Stop)
  new_list<-c(new_list,c)
  new_list<-as.matrix(new_list, sep=",")
  write.csv( new_list, "small_gene_cis.csv")
}
###
for (i in 1:length((csvfiles))){
  b<-aa[which(aa$first_gene_name==aa$second_gene_name[i]),]
  c<-aa[which(aa$second_gene_name==aa$first_gene_name[i]),]
}

####change the folder name########
folder = "~/lastversion_gwas_analysis/PermGWAS_Scripts/deneme2//"
files <- list.files(folder,pattern = "trans_.*.csv",full.names = T) 
sapply(files,FUN=function(eachPath){ 
  file.rename(from=eachPath,to= sub(pattern="trans_", paste0(""),eachPath))
})


##
files <- list.files(folder,pattern = "filtered_.*.csv",full.names = T) 
sapply(files,FUN=function(eachPath){ 
  file.rename(from=eachPath,to= sub(pattern="filtered_", paste0(""),eachPath))
})
write.csv( SNPs, "~/lastversion_gwas_analysis/F_95/SNPs_11.csv")
