options(stringsAsFactors=F)
load("demo-dataset/data.for.decomposition.github.Rdata")
library(DWLS) #https://bitbucket.org/yuanlab/dwls
predicte.proportion <- NULL
for(sample in colnames(dataBulk)){
print(sample)
dir.create(paste0("../output/",sample,".results"))
Signature<-buildSignatureMatrixMAST(scdata=dataSC,id=cell_type,path=paste0("../output/",sample,".results"),diff.cutoff=0.5,pval.cutoff=0.01)
bulkExp <- dataBulk[,sample]
names(bulkExp) <- rownames(dataBulk)
tr<-trimData(Signature,bulkExp)
solDWLS<-solveDampenedWLS(tr$sig,tr$bulk)
predicte.proportion <- cbind(predicte.proportion,solDWLS)
}
colnames(predicte.proportion) <- colnames(dataBulk)
write.csv(predicte.proportion,file="../output/prediction.proportions.csv")
