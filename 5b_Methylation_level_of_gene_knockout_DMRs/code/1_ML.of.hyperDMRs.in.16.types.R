options(stringsAsFactors=F)
load("demo_dataset/methylation.level.Rdata")
library(pheatmap)
pheatmap(ml,cluster_rows = T,cluster_cols = F, show_rownames = F,fontsize =20,cutree_rows = 4)
