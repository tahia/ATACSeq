#!/bin/bash
# This will mark the duplicates from sorted BAM files by SortSam
# This script is for the pipe of ATAC-Seq data analysis
# Modified by Taslima Haque on 27th Jan,2018

if [[ -z $1 ]] | [[ -z $2 ]] | [[ -z $3 ]]; then
  echo "Usage: make-picard-dedup.sh in/dir out/dir mat/dir"
  exit 1;
fi

#SCRIPT="/home/taslima/Tools/picard/build/libs/picard.jar MarkDuplicates"
SCRIPT="java -Xmx1G -jar $TACC_PICARD_DIR/build/libs/picard.jar MarkDuplicates"
INDIR=$1
ODIR=$2
MAT=$3
PARAM="markdup.param"
LOG="logs/"

if [ ! -d $LOG ]; then mkdir $LOG; fi

if [ ! -d $ODIR ]; then mkdir $ODIR; fi

if [ ! -d $MAT ]; then mkdir $MAT; fi

if [ -e $PARAM ]; then rm $PARAM; fi
touch $PARAM

# Loop over the filtered sam files and
# create a bam file with suffix "_markdup.bam"
for fil in ${INDIR}*_markdup.bam; do
  BASE=$(basename $fil)
  NAME=${BASE%.bam}
  OUT="${ODIR}${NAME}_markdup.bam"
  MO="${MAT}${NAME}_markdup.txt"
  OLOG="${LOG}${NAME}.log"
# We can get 3/4 of memory virtually for JAVA so set memory accordingly
#A rule of thumb for reads of ~100bp is to set MAX_RECORDS_IN_RAM to be 250,000 reads per each GB given to the -Xmx parameter for SortSam
  echo "java -Xms1G -Xmx4G -jar $SCRIPT MAX_RECORDS_IN_RAM=4000000 INPUT=$fil OUTPUT=$OUT  METRICS_FILE=$MO REMOVE_DUPLICATES=true 1>$OLOG " >> $PARAM
done


#Core=`wc -l markdup.param  |cut -f1 -d ' '`

## Change time (-t) and partition (-p) as per your need and in slurm file change your allocation name
#perl /home/taslima/Pipe/ATACSeq/03-picard-rmdup/batch_runner.pl markdup.param 6

