options(stringsAsFactors=F)

# Load the demo dataset
load("demo-dataset/data.for.decomposition.github.Rdata")

library(DWLS) # more details for this package can be found in https://bitbucket.org/yuanlab/dwls
predicte.proportion <- NULL
for(sample in colnames(dataBulk)){
print(sample)
dir.create(paste0("../output/",sample,".results"))

# Build signature from single-cell data
Signature<-buildSignatureMatrixMAST(scdata=dataSC,id=cell_type,path=paste0("../output/",sample,".results"),diff.cutoff=0.5,pval.cutoff=0.01)

bulkExp <- dataBulk[,sample]
names(bulkExp) <- rownames(dataBulk)
  
# Filter signature and bulk data to contain the same differentially expressed genes
tr<-trimData(Signature,bulkExp)
  
# Estimate using dampened weighted least squares (deconvolution)
solDWLS<-solveDampenedWLS(tr$sig,tr$bulk)
 
predicte.proportion <- cbind(predicte.proportion,solDWLS)
}
colnames(predicte.proportion) <- colnames(dataBulk)
write.csv(predicte.proportion,file="../output/prediction.proportions.csv")
