#!/bin/bash
#  CallPeak by MACS2
# This script is for the pipe of ATAC-Seq data analysis
# Modified by Taslima Haque on 8th Nov,2022

if [[ -z $1 ]] | [[ -z $2 ]] | [[ -z $3 ]] ; then
  echo "Usage: make-cleanHQPeak.sh in/dir in/black/path/to/bed out/dir "
  exit 1;
fi

INDIR=$1
BLCK=$2
ODIR=$3
PARAM="cleanpeak.param"
LOG="logs/"

if [ ! -d $LOG ]; then mkdir $LOG; fi

if [ ! -d $ODIR ]; then mkdir $ODIR; fi

if [ -e $PARAM ]; then rm $PARAM; fi
touch $PARAM


for fil in ${INDIR}*.narrowPeak; do
        BASE=$(basename $fil)
	NAME=${BASE%.narrowPeak}
        OUTF="${ODIR}${NAME}.clean.narrowPeak"
	OLOG="${LOG}${NAME}_cleanpeak.log"
   	echo "/home/taslima/Tools/bedtools2/bin/bedtools intersect -v -f 0.1 -a $fil -b $BLCK >$OUTF  2> $OLOG " >> $PARAM

done


