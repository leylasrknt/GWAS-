%%R
####filter stringent result files, only contain trans hits
####filter stringent result files, only contain trans hits
setwd("~/lastversion_gwas_analysis/Over_Occ/")
small_gene<-read.csv("~/lastversion_gwas_analysis/Over_Occ/trans_filtered_hit.csv")
ara11<-read.csv("~/lastversion_gwas_analysis/ara11_50.csv")

Y <- list()
csvfiles<-list.files(pattern = "*.csv")
Y <- lapply(csvfiles, function(x) {
  file <- read.csv(x)
  return(file)
})
for (i in 1:length((csvfiles))){
  b<-ara11[which(ara11$Gene==S$second_gene_name[i]),]
  trials<-subset(Y[[i]],!(b$Start<Y[[i]][["Pos"]] & Y[[i]][["Pos"]]<b$Stop))
  write.csv(trials, file=paste( "filtered_",csvfiles[i],".csv", sep=""))
}