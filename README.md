# README for ATACSeq Peak Calling pipe
**Written by : Taslima Haque**
**Last Modified: 09/09/2021**

**Contact : taslima@utexas.edu**

====================================================================================
**This pipeline contains the basic codes to call peaks for ATACSeq raw data**

The structure of this pipeline is as follows:

  00-qual-report
  
  01-qual-filter
  
  02-bowtie-mapping
  
  03-map-filter
  
  04-PeakCalling

The scripts are written in a way so that it can be either run in a cluster with
the aid of some batch scripts like SLURM or forkmanager.

In each directory:

"make-*.sh" are the files in bash to generate parameters for multiple samples
"*.param" are the param files
