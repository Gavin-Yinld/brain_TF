options(stringsAsFactors=F)
library(dplyr)
library(Seurat)

# Load the brain dataset
load("demo_dataset/scRNA-seq.demo.Rdata")
# Initialize the Seurat object with the raw (non-normalized data).
brain <- CreateSeuratObject(counts = brain.data, project = "brain", min.cells = 3, min.features = 200)
brain
# Normalizing the data
brain <- NormalizeData(brain, normalization.method = "LogNormalize", scale.factor = 10000)

#Identification of highly variable features (feature selection)
brain <- FindVariableFeatures(brain, selection.method = "vst", nfeatures = 2000)

# Dimensional reduction
all.genes <- rownames(brain)
brain <- ScaleData(brain, features = all.genes)
brain <- RunPCA(brain, features = VariableFeatures(object = brain))
brain <- JackStraw(brain, num.replicate = 100)
brain <- ScoreJackStraw(brain, dims = 1:20)
ElbowPlot(brain) # to determine the munber of PCs used to generate tSNE plot

# tSNE and gene expression
brain <- RunTSNE(brain, dims = 1:12)
DimPlot(brain, reduction = "tsne")
VlnPlot(brain, features = c("Egr1"),pt.size=0)
FeaturePlot(brain, features = c("Egr1"))
