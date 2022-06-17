%%R
##permgwas:find pvalue_threshold each phenotype separetly then apply this threshold value for filtering step
library(tidyverse)
library(fs)
setwd("~/lastversion_gwas_analysis/PermGWAS_Scripts/")

list_of_files <- list.files(path = "~/PermGWAS/",
                            recursive = TRUE,
                            pattern = "*min_",
                            full.names = TRUE)
Y <- lapply(list_of_files, function(x) {
  file <- read.csv(x)
  return(file)
})
###find perm_threshold for each phenotype
new_list<-vector()
for (i in 1:length((list_of_files))){
  A<-Y[[i]][order(Y[[i]][,2]),]
  perm_thres<-A[5,2]
  new_list<-c(new_list,perm_thres)
  new_list<-as.matrix(new_list, sep=",")
  new<-as.data.frame(new_list)
}
####use this threshold and filter perm_gwas result

csv_files <- list.files(path = "~/PermGWAS/",
                        recursive = TRUE,
                        pattern = "*gwasp_",
                        full.names = TRUE)
Y_ <- lapply(csv_files, function(x) {
  file <- read.csv(x)
  return(file)
})
a<-read.csv("~/lastversion_gwas_analysis/names.csv")
for (i in 1:length((csv_files))){
  R<-subset(Y_[[i]],Y_[[i]][["p_value"]]<(new[i,]))
  write.csv(R, file=paste(a$x[i] , sep=""))
}



