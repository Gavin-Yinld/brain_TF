options(stringsAsFactors=F)
load("demo_dataset/ETRM.single-cell.Exp.Rdata")
exp.genes <- apply(dataSC,1,function(x){return(which(x>0))})
names(exp.genes) <- rownames(dataSC)
len <- nrow(dataSC)*(nrow(dataSC)-1) / 2
data_summary <- data.frame(geneA=c(rep(" ",len)),geneB=c(rep(" ",len)),expA=c(rep(0,len)),expB=c(rep(0,len)),expAB=c(rep(0,len)),pvalue=c(rep(1,len)))
count <- c()
i=0
for(gA in rownames(dataSC))
{	
	expA <- length(exp.genes[[gA]])
	for(gB in rownames(dataSC))
	{	
		if(gA!=gB & !(paste(gA,gB,sep='_')%in% count |paste(gB,gA,sep='_')%in% count)){
		i = i+1
		cat(gA,'\t',gB,'\n')
		expB <- length(exp.genes[[gB]])
		expAB <- length(intersect(exp.genes[[gA]],exp.genes[[gB]]))
		x <- matrix(c(expAB,expA-expAB,expB-expAB,length(setdiff(rownames(dataSC),unique(c(exp.genes[[gA]],exp.genes[[gB]]))))),2,2)
		p <- fisher.test(x)$p.value
		RF <- (ncol(dataSC)*expAB)/(expA*expB)
		data_summary[i,1]=gA
		data_summary[i,2]=gB
		data_summary[i,3]=expA
		data_summary[i,4]=expB
		data_summary[i,5]=expAB
		data_summary[i,6]=p
		count <- c(count,paste(gA,gB,sep='_'))}
	}

}

data_summary$propA <- data_summary$expAB / data_summary$expA
data_summary$propB <- data_summary$expAB / data_summary$expB

data_summary$padj = p.adjust(data_summary$pvalue)

plot.data <- matrix(0,length(genes),length(genes))
colnames(plot.data) <- genes
rownames(plot.data) <- genes
for(i in 1:nrow(data_summary))
{
  if(data_summary$pvalue[i]<=0.05 ){
    plot.data[data_summary$geneA[i],data_summary$geneB[i]] = data_summary$propA[i]
    plot.data[data_summary$geneB[i],data_summary$geneA[i]] = data_summary$propB[i]}
}
plot.data <- t(plot.data)
my_palette <- colorRampPalette(c("white","#6FB7B7","#FF8040"))(100)

library(pheatmap)
pheatmap(plot.data,color=my_palette,cluster_rows = F,cluster_cols = F,fontsize=10,main="Excitatory" )




