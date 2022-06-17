#%%R
###Load libraries that are needed for .csv file reading and creating list
##Load libraries and sources that are needed for reading files and creating a list
library(tidyverse)
library(fs)
setwd("~/lastversion_gwas_analysis/F_95/")
source("gwas.r") 
source("emma.r")
source("plots_gwas.r")
source('~/lastversion_gwas_analysis/f95_gwas.r')

csvfiles <-
  dir(path = "~/lastversion_gwas_analysis/Over_Occ/Over_Coocurrence/",
      pattern = ".csv",
      full.names = TRUE)

##Creating an empty list and put all phenotype file in this list
Y <- list()
for (i in seq_along(csvfiles)) {
  Y[[i]] <- read.csv(file = csvfiles[i])
  Y[[i]][, 1] <- as.numeric(Y[[i]][, 1])
  Y[[i]][, 2] <- as.numeric(Y[[i]][, 2])
}

Y<-set_names(Y,csvfiles )

##Gwas is running for each phenotype file with "f95_gwas" fuction
for (i in seq_along(csvfiles)) {
  f95_gwas(Y[[i]],pre=i)
}
saveRDS(csvfiles, file="phenotype_list.Rds") #save the list 