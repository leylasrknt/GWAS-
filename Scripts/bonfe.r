#%%R
library(tidyverse)
library(fs)
####this is bonferoni correction version more stringent 
Y <- list()
csvfiles<-list.files(pattern = "*.csv")
Y <- lapply(csvfiles, function(x) {
  file <- read.csv(x)
  return(file)
})
for (i in 1:length((csvfiles))){
  R<-subset(Y[[i]],Y[[i]][["Pval"]]<0.05/(2800000*738))
  write.csv(R, file=paste( "filtered_",csvfiles[i],".csv", sep=""))
}
