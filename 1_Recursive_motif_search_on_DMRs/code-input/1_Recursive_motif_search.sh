#!/bin/bash

## decompress dataset
cd /code-input/demo_dataset
unzip DMR.zip

## initialization
## need to provide genome and the path to Homer
directory=/code-input/demo_dataset
Hpath=/software/homer/
refpath=/database/mm10.genome/mm10.fa
seqextractpath=/code-input/scripts/Perl_script/sequence_extractor.pl
Rpath=/code-input/scripts/R_script/

## run recursive ETRM prediction 
sft=/code-input/scripts/Shell/recursive_motif_identification_noclustering.sh
$sft -i $directory -H $Hpath -r $refpath -t mL23DMR.txt -b mL23DMR.homer.background.txt -s $seqextractpath -R $Rpath

# Explanation of command: 
# -i: path containing the DMR file
# -H: path to HOMER database
# -s: sequence extractor Perl script
# -R: path to R script files
# -t: DMR matrix
# -b: DMR background matrix
# -r: path containing the reference fasta file; examples are mm10.fa, hg19.fa etc.
# -h: explains required parameters \
# more details can be found in https://github.com/BSharmi/ETRM-identification
