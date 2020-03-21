# Epigenetic regulation of neuronal cell specification inferred with single cell “Omics” data

<div align=center><img width="600" height="750" src="https://github.com/Gavin-Yinld/brain_TF/blob/master/Figures/cover.png" /></div>

# Introduction

Growing single-cell “omics” data provide an opportunity to explore brain epigenetic regulatory modules with unprecedented resolution. In this repository, we provide an analysis pipeline to symmetrically determine transcription factors participating in the process of brain neuron specification, by integrating DNA methylation and RNA-seq data at single-cell level. The functional importance of these TFs were finally validated by ChIP-seq data, and the datasets generated from gene knockout mouse brain.

# How to use

Briefly, the pipeline contains following steps:
1.	Recursive motif search on DMRs of neuronal subtypes to identify key TFs associated with cell specification.
2.	Single-cell RNA-seq analysis to check cell-type specific expression of key TFs.
3.	Epigenetic transcription regulatory module inference (ETRM).
4.	Co-expression analysis of ETRM.
  a)	At single-cell level
  b)	At bulk level
5.	Validation of computational predictions.
  a)	Identify ETRM from ChIP-seq data.
  b)	Methylation level of DMRs of gene knock sample across neuronal subtypes. (optional)
  c)	Predicted cell-compositions of gene knock sample. (optional)



