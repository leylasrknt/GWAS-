#%%R
i <- as.numeric(Sys.getenv("SLURM_ARRAY_TASK_ID"))
##Load libraries and sources that are needed for reading files and creating a list
library(tidyverse)
library(fs)
setwd("~/lastversion_gwas_analysis/F_95/")
source("gwas.r") 
source("emma.r")
source("plots_gwas.r")
source('~/lastversion_gwas_analysis/f95_gwas.r')

##Creating an empty list and put all phenotype file in this list
setwd("~/lastversion_gwas_analysis/Over_Occ/Over_Coocurrence/") #phenotype files folder 
Y <- list()
csvfiles<-list.files(pattern = "*.csv")
print(csvfiles[i])
Y[[i]] <- read.csv(file = csvfiles[i])
Y[[i]][, 1] <- as.numeric(Y[[i]][, 1])
Y[[i]][, 2] <- as.numeric(Y[[i]][, 2])

##Rewrite the same filename 
Y <- lapply(csvfiles, function(x) {
  file <- read.csv(x)
  # Get the start of filename prefix 
  prefix = gsub("_.*", "", x)
  # Get the suffix number
  suffix = gsub(".csv*", "", x)  
  colnames(file) <- paste(colnames(file), suffix, sep='_')
  return(file)
})

##Gwas is running for each phenotype file with "f95_gwas" fuction
f95_gwas(Y[[i]],pre="")