#!/bin/bash
#  CallPeak by MACS2
# This script is for the pipe of ATAC-Seq data analysis
# Modified by Taslima Haque on 8th Nov,2022

if [[ -z $1 ]] | [[ -z $2 ]] ; then
  echo "Usage: make-BAM-toBEDTag.sh in/dir out/dir "
  exit 1;
fi

INDIR=$1
ODIR=$2
PARAM="bamtobedTAG.param"
LOG="logs/"

if [ ! -d $LOG ]; then mkdir $LOG; fi

if [ ! -d $ODIR ]; then mkdir $ODIR; fi

if [ -e $PARAM ]; then rm $PARAM; fi
touch $PARAM


for fil in ${INDIR}*.bam; do
  BASE=$(basename $fil)
  NAME=${BASE%.bam}
  OFIL="${ODIR}${NAME}.TAG.bed"
  OLOG="${LOG}${NAME}_TAG.log"
  echo "/home/taslima/Tools/bedtools2/bin/bedtools bamtobed -i $fil | \
  awk 'BEGIN {OFS = \"\t\"} ; {if (\$6 == \"+\") {\$2 = \$2 + 4} else {\$3 = \$3 - 6} print \$0}' > $OFIL  2> $OLOG " >> $PARAM

done




###### Use perl wrapper for parallele processing
#Core=`wc -l bamtobed.param  |cut -f1 -d ' '`

#perl /home/taslima/Pipe/ATACSeq/03-picard-rmdup/batch_runner.pl $PARAM 10


