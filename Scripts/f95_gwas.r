f95_gwas<-function(Y,n=2,X.folder='~/lastversion_gwas_analysis/F_95',K.file='~/lastversion_gwas_analysis/F_95/K_F95.rda',incl.lm=FALSE,incl.beta=FALSE,update.snps=FALSE,save.output=T,out.format='rda',generate.plot=T,pre=colnames(Y)[n]) {

load(K.file)

  for ( u in 1:6) {

  filename<-paste(X.folder,'/X_f95_',u,'.rda',sep='')

  load(filename)
  if (u==1) {
    results<-amm_gwas(Y,X,K,m=n,include.lm=incl.lm,calculate.effect.size=incl.beta,update.top_snps=update.snps)
  rm(X)
  } else {

  
  output<-amm_gwas(Y,X,K,m=n,include.lm=incl.lm,calculate.effect.size=incl.beta,update.top_snps=update.snps)
  results<-rbind(results,output)
  rm(X)
  }

  }

#return(results)


if (save.output==T) {
  auto<-0
  if (('rda'%in%out.format)==T) {
name1<-paste(colnames(Y)[n],pre,'gwasf95.rda',sep='_')
save(results,file=name1)
auto<-1
  }
  if (('csv'%in%out.format)==T) {
    name1b<-paste(colnames(Y)[n],pre,'gwasf95.csv',sep='_')
    write.csv(results,file=name1b,row.names=FALSE)
    auto<-1
  }
  if(auto==0){
    cat('wrong output format to save the data specified','\n')}
}
if (generate.plot==T) {
 name2<-paste(colnames(Y)[n],pre,'gwasf95.pdf',sep='_')
 name3<-paste(colnames(Y)[n],pre,sep='_')
pdf(file=name2)
plot_gwas(results,maf_or_mac=2,mac=5,name=name3)
dev.off()
}

}


