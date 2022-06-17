library(tidyverse)
library(fs)
library(dplyr)
library(stringr)
setwd("~/lastversion_gwas_analysis/new/Over_Coocurrence/")

###
new_discard<-sapply(a, paste , "_small", sep ="")
discardd<-gsub(".csv", "", new_discard )
new_discardd<-sapply(discardd, paste , ".csv", sep ="")
new_discardd<-data.frame(new_discardd)
write_csv(new_discardd,"~/lastversion_gwas_analysis/f95_bonf/new_discard.csv", col_names = F)

##count your lines on R code
list.files(path="~/lastversion_gwas_analysis/new/Over_Coocurrence/", recursive=F, full.names=T)%>%
  str_subset("[csv]$")%>%
  sapply(function(x)x%>%readLines()%>%length())%>%
  sum()

##summarize files

sum_file = function(path){
  dat = read_csv(path)
  tibble(file = path,
         sum = sum(dat$Phenotype, na.rm = T))
}
##list files
files=list.files("~/lastversion_gwas_analysis/new/Over_Coocurrence/", pattern=".csv", full.names=T)

###summarize all
summary=map_dfr(files, sum_file)
head(summary)
write_csv(summary,"~/lastversion_gwas_analysis/f95_bonf/summary_file.csv")

####change the folder name########
folder = "~/lastversion_gwas_analysis/PermGWAS_Scripts/MAC_PermGWAS/"
files <- list.files(folder,pattern = "filtered_.*.csv",full.names = T) 
sapply(files,FUN=function(eachPath){ 
  file.rename(from=eachPath,to= sub(pattern="filtered_", paste0(""),eachPath))
})
