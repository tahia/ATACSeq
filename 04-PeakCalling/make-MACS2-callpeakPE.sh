#!/bin/bash
# This will sort alignments according to coordinates from unsorted SAM files by bowtie1
# This script is for the pipe of ATAC-Seq data analysis
# Modified by Taslima Haque on 27th Jan,2018

if [[ -z $1 ]] | [[ -z $2 ]] ; then
  echo "Usage: make-picard-sort.sh in/dir out/dir "
  exit 1;
fi

INDIR=$1
ODIR=$2
PARAM="callpeakPE.param"
LOG="logs/"

if [ ! -d $LOG ]; then mkdir $LOG; fi

if [ ! -d $ODIR ]; then mkdir $ODIR; fi

if [ -e $PARAM ]; then rm $PARAM; fi
touch $PARAM


for fil in ${INDIR}*.bam; do
  BASE=$(basename $fil)
  NAME=${BASE%.bam}
  OLOG="${LOG}${NAME}_acllpeakPE.log"
  
   echo "macs2 callpeak -t $fil --keep-dup all -f BAMPE -n $NAME --call-summits -q 0.05  --max-gap 150 \
  --min-length 90 -g 500000000 --slocal 1000 --llocal 10000 -B --fe-cutoff 2 --cutoff-analysis --outdir $ODIR  2> $OLOG " >> $PARAM

done




#Core=`wc -l callpeakPE.param  |cut -f1 -d ' '`

## Change time (-t) and partition (-p) as per your need and in slurm file change your allocation name
#perl /home/taslima/Pipe/ATACSeq/03-picard-rmdup/batch_runner.pl $PARAM 10


