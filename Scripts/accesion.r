setwd("~/lastversion_gwas_analysis/PermGWAS_OverCo/")
setwd("~/lastversion_gwas_analysis/PermGWAS_Scripts/AC_1_0_files/")
Y <- list()
csvfiles<-list.files(pattern = "*.csv")
Y <- lapply(csvfiles, function(x) {
  file <- read.csv(x)
  return(file)
})

d<-read.csv("~/lastversion_gwas_analysis/overlapping_result/perm_overlapping_genes.csv")
d['accesion']<-NA
for(i in 1:nrow(d)){
  a<-Y[[i]][which(Y[[i]]$Phenotype==1),]
  d[i,15]<-paste(as.character(na.omit(a$X)),collapse=',')
}
write.csv(d, "~/lastversion_gwas_analysis/overlapping_result/accesions_overlapping_genes.csv", row.names = FALSE)



  
  