options(stringsAsFactors=F)
load(file="demo_dataset/tpm.Rdata")
Egr_ETRM <- c("Egr1","Egr2","Zfp281","Klf9","Klf14")
Exc_marker <- c("Neurod6","Slc17a7","Nrn1")
inh_marker <- c("Gad1", "Gad2", "Pnoc", "Slc32a1")

ETRM_Exp <- tpm[which(rownames(tpm)%in%c(Egr_ETRM,Exc_marker,inh_marker)),]
ETRM_Exp <- log2(ETRM_Exp+1)
library(pheatmap)
my_palette <- colorRampPalette(c("green","white","red"))(100)

# ETRM expression
pheatmap(ETRM_Exp,color=my_palette)
ETRM_Exp <- ETRM_Exp[c("Klf14","Neurod6","Zfp281","Egr2","Klf9","Egr1","Nrn1","Slc17a7","Gad1","Pnoc","Gad2","Slc32a1"),]

# pairwise correlatioin of TFs in ETRM
pheatmap(cor(t(ETRM_Exp)),cluster_rows = T,cluster_cols = T,display_numbers=F)






