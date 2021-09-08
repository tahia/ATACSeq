#!/bin/bash
# This will index bam file
# This script is for the pipe of ATAC-Seq data analysis
# Modified by Taslima Haque on 30th Jan,2018

if [[ -z $1 ]] | [[ -z $2 ]] | [[ -z $3 ]] ; then
  echo "Usage: make-samtool-filter.sh in/dir out/dir bed/file"
  exit 1;
fi

SCRIPT="samtools view"
INDIR=$1
ODIR=$2
BED=$3

PARAM="filter.param"

LOG="logs/"

if [ ! -d $LOG ]; then mkdir $LOG; fi

if [ ! -d $ODIR ]; then mkdir $ODIR; fi

if [ -e $PARAM ]; then rm $PARAM; fi
touch $PARAM

# Loop over the filtered bam files : FIL
for fil in ${INDIR}*.sam; do
  BASE=$(basename $fil)
  NAME=${BASE%.*sam}
  OUT="${ODIR}${NAME}.bam"
  OLOG="${LOG}${NAME}.log"
  echo "$SCRIPT -b -f 2 -q 5 -@ 7 -L $BED $fil | samtools sort -@ 7 -m 1G -o $OUT > $OLOG " >> $PARAM


done


#Core=`wc -l filter.param  |cut -f1 -d ' '`

## Change time (-t) and partition (-p) as per your need and in slurm file change your allocation name
#perl /home/taslima/Pipe/ATACSeq/03-picard-rmdup/batch_runner.pl filter.param 4

