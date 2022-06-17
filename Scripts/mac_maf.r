#MAC or MAf filter
#i <- Sys.getenv("SLURM_ARRAY_TASK_ID")
library(tidyverse)
library(fs)
setwd("~/lastversion_gwas_analysis/Over_Coocurrence_files/GWAS_F95_Result/")
######this is mac>5 for .rda file
Y <- list()
GWAS_F95 <- list.files(pattern = ".rda")
dd<-grep(".rda", list.files(), value=T)
d<-data.matrix(dd)
for (i in 1:length((d))){
    yyz<-load(d[i])
   R<-subset(results, results$MAC>5 )
 R<-subset(results,results$Pval<0.05/nrow(results))
    write.csv(R, file=paste( d[i],"f95_small",".csv", sep=""))
}
###mac>5 filtered version for .csv results
setwd("~/lastversion_gwas_analysis/PermGWAS_Scripts/MAC_filtered/")
Y <- list()
csvfiles<-list.files(pattern = "*.csv")
Y <- lapply(csvfiles, function(x) {
  file <- read.csv(x)
  return(file)
})
for (i in 1:length((csvfiles))){
  R<-subset(Y[[i]],Y[[i]][["MAC"]]>5)
  write.csv(R, file=paste( "filtered_",csvfiles[i],".csv", sep=""))
}
###maf filtered version
setwd("~/lastversion_gwas_analysis/PermGWAS_Scripts/maf_filtered/")
Y <- list()
csvfiles<-list.files(pattern = "*.csv")
Y <- lapply(csvfiles, function(x) {
  file <- read.csv(x)
  return(file)
})
for (i in 1:length((csvfiles))){
  R<-subset(Y[[i]],Y[[i]][["maf"]]>0.05)
  write.csv(R, file=paste( "filtered_",csvfiles[i], sep=""))
}
##
%%R
#maf filtered >0.05

library(tidyverse)
library(fs)
setwd("~/lastversion_gwas_analysis/PermGWAS_Scripts/permgwas_filtered_pvalue/")

Y <- list()
csvfiles<-list.files(pattern = "*.csv")

Y <- lapply(csvfiles, function(x) {
  file <- read.csv(x)
  return(file)
})

for (i in 1:length((list_of_files))){
  R<-subset(Y[[i]],Y[[i]][["maf"]]>0.05)
  write.csv(R, file=paste( "filtered_",csvfiles[i],".csv", sep=""))
}

