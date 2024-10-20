## README for ATACSeq Peak Calling pipe
#### Editor : Taslima Haque
#### Last Modified: 11/08/2022

**Contact : taslima@utexas.edu**

======================================================================================
**This pipeline contains the basic scripts to call peaks for ATACSeq data**

The steps of this pipeline are as follows:

      00-qual-report: quality check
  
      01-qual-filter: raw data filter
  
      02-bowtie-mapping: mapping against appropriate reference genome
  
      03-clean-alignments: filter only HQ mapped reads and mask blacklisted regions
  
      04-PeakCalling: calling peaks by MACS

The scripts are written in bash which can either be run in a cluster with
the aid of some batch scripts like SLURM or forkmanager.

In each directory:

"make-*.sh" are the files in bash to generate parameters for multiple samples
"*.param" are the param files
