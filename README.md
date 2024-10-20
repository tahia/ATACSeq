# README for ATACSeq Peak Calling pipe
### Editor : Taslima Haque
### Last Modified: 11/08/2022

**Contact : taslima@utexas.edu**

======================================================================================
**This pipeline contains the basic scripts to call peaks for ATACSeq data**

The structure of this pipeline is as follows:

  00-qual-report
  
  01-qual-filter
  
  02-bowtie-mapping
  
  03-clean-alignments
  
  04-PeakCalling

The scripts are written in bash which can either be run in a cluster with
the aid of some batch scripts like SLURM or forkmanager.

In each directory:

"make-*.sh" are the files in bash to generate parameters for multiple samples
"*.param" are the param files
